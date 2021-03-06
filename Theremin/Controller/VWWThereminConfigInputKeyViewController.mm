//
//  VWWThereminConfigInputKeyViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 1/6/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputKeyViewController.h"
#import "VWWThereminInputs.h"
#import "VWWConfigInputKeyView.h"

typedef enum{
    kLineTypeNone = 0,
    kLineTypeX,
    kLineTypeY,
    kLineTypeZ,
} LineType;

@interface VWWThereminConfigInputKeyViewController ()
@property (nonatomic, strong) IBOutlet UIView* infoView;
@property (nonatomic, strong) IBOutlet VWWConfigInputKeyView* configView;
@property (nonatomic) LineType lineType;
@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *zLabel;

@property (strong, nonatomic) IBOutlet UIButton *notesChromaticLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesAMinorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesAMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesBMinorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesBMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesCMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesDMinorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesDMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesEMinorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesEMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesFMAjorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesGMinorLabel;
@property (strong, nonatomic) IBOutlet UIButton *notesGMAjorLabel;

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect waveformEndzone;
@property (nonatomic, strong) VWWThereminInput* input;
- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigInputKeyViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//#if defined(VWW_SHOW_INFO_SCREENS)
//    [self.view addSubview:self.infoView];
//    [self.infoView setFrame:self.view.frame];
//    [self.infoView setHidden:NO];
//#endif
//    
//    // Set nav bar title
//    switch(self.inputType){
//        case kInputAccelerometer:
//            self.navigationItem.title = @"Accelerometers";
//            self.input = [VWWThereminInputs accelerometerInput];
//            break;
//        case kInputGyros:
//            self.navigationItem.title = @"Gyroscopes";
//            self.input = [VWWThereminInputs gyroscopeInput];
//            break;
//        case kInputMagnetometer:
//            self.navigationItem.title = @"Magnetometers";
//            self.input = [VWWThereminInputs magnetometerInput];
//            break;
//        case kInputTouch:
//            self.navigationItem.title = @"Touch Screen";
//            self.input = [VWWThereminInputs touchscreenInput];
//            self.zLabel.hidden = YES;
//            break;
//        case kInputNone:
//            self.navigationItem.title = @"Invalid Input";
//            self.input = nil;
//        default:
//            break;
//    }
//    
//    self.waveformEndzone = CGRectMake(self.autotuneLabel.frame.origin.x,
//                                      self.autotuneLabel.frame.origin.y,
//                                      self.autotuneLabel.frame.size.width,
//                                      self.noEffectLabel.frame.origin.y + self.noEffectLabel.frame.size.height);
//    
//    
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [self makeLinesFromInputData];
//    [self.configView setNeedsDisplay];
//}
//
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//
//
//#pragma mark - UIResponder touch events
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSArray *touchesArray = [touches allObjects];
//    UITouch* touch = [touchesArray objectAtIndex:0];
//    CGPoint begin = [touch locationInView:self.configView];
//    
//    if(CGRectContainsPoint(self.xLabel.frame, begin)){
//        self.lineType = kLineTypeX;
//        self.begin = CGPointMake(self.xLabel.center.x + self.xLabel.frame.size.width/2.0,
//                                 self.xLabel.center.y);
//    }
//    else if(CGRectContainsPoint(self.yLabel.frame, begin)){
//        self.lineType = kLineTypeY;
//        self.begin = CGPointMake(self.yLabel.center.x + self.yLabel.frame.size.width/2.0,
//                                 self.yLabel.center.y);
//    }
//    else if(CGRectContainsPoint(self.zLabel.frame, begin)){
//        self.lineType = kLineTypeZ;
//        self.begin = CGPointMake(self.zLabel.center.x + self.zLabel.frame.size.width/2.0,
//                                 self.zLabel.center.y);
//    }
//    else{
//        self.lineType = kLineTypeNone;
//        return;
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    // We don't want to draw a line if we didnt' start from an appropriate location
//    if(self.lineType == kLineTypeNone){
//        return;
//    }
//    
//    NSArray *touchesArray = [touches allObjects];
//    UITouch* touch = [touchesArray objectAtIndex:0];
//    self.end = [touch locationInView:self.configView];
//    
//    
//    if(CGRectContainsPoint(self.notesChromaticLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesAMinorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesAMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesBMinorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesBMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesCMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesDMinorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesDMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesEMinorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesEMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesFMAjorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesGMinorLabel.frame, self.end) ||
//       CGRectContainsPoint(self.notesGMAjorLabel.frame, self.end)){
//        [self updateConfigViewLinesValid:YES];
//    }
//    else{
//        [self updateConfigViewLinesValid:NO];
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    // We don't want to draw a line if we didnt' start from an appropriate location
//    if(self.lineType == kLineTypeNone){
//        return;
//    }
//    
//    NSArray *touchesArray = [touches allObjects];
//    UITouch* touch = [touchesArray objectAtIndex:0];
//    CGPoint end = [touch locationInView:self.configView];
//    
//    if(CGRectContainsPoint(self.autotuneLabel.frame, end)){
//        [self updateEffect:kEffectAutoTune];
//        self.end = CGPointMake(self.autotuneLabel.frame.origin.x, self.autotuneLabel.frame.origin.y + self.autotuneLabel.frame.size.height/2.0);
//        [self updateConfigViewLinesValid:YES];
//    }
//    else if(CGRectContainsPoint(self.linearizeLabel.frame, end)){
//        [self updateEffect:kEffectLinearize];
//        self.end = CGPointMake(self.linearizeLabel.frame.origin.x, self.linearizeLabel.frame.origin.y + self.linearizeLabel.frame.size.height/2.0);
//        [self updateConfigViewLinesValid:YES];
//    }
//    else if(CGRectContainsPoint(self.throttleLabel.frame, end)){
//        [self updateEffect:kEffectThrottle];
//        self.end = CGPointMake(self.throttleLabel.frame.origin.x, self.throttleLabel.frame.origin.y + self.throttleLabel.frame.size.height/2.0);
//        [self updateConfigViewLinesValid:YES];
//    }
//    else if(CGRectContainsPoint(self.noEffectLabel.frame, end)){
//        [self updateEffect:kEffectNone];
//        self.end = CGPointMake(self.noEffectLabel.frame.origin.x, self.noEffectLabel.frame.origin.y + self.noEffectLabel.frame.size.height/2.0);
//        [self updateConfigViewLinesValid:YES];
//    }
//    else{
//        // Setting these points to 0 will cause it not to be drawn
//        self.begin = CGPointMake(0, 0);
//        self.end = CGPointMake(0, 0);
//        [self updateConfigViewLinesValid:NO];
//    }
//}
//
//
//// For when a user is drawing
//-(void)updateEffect:(EffectType)effect{
//    switch(self.lineType){
//        case kLineTypeX:
//            self.input.x.effectType = effect;
//            break;
//        case kLineTypeY:
//            self.input.y.effectType = effect;
//            break;
//        case kLineTypeZ:
//            self.input.z.effectType = effect;
//            break;
//        default:
//            return;
//    }
//}
//
//-(void)updateConfigViewLinesValid:(bool)valid{
//    VWWLine* line = [[VWWLine alloc]initWithBegin:self.begin andEnd:self.end];
//    switch(self.lineType){
//        case kLineTypeX:
//            [self.configView setLineX:line valid:valid];
//            break;
//        case kLineTypeY:
//            [self.configView setLineY:line valid:valid];
//            break;
//        case kLineTypeZ:
//            [self.configView setLineZ:line valid:valid];
//            break;
//        default:
//            return;
//            
//    }
//    [line release];
//    [self.configView setNeedsDisplay];
//}
//
//
//
//
//// For loading data
//-(void)makeLinesFromInputData{
//    VWWLine* xLine = [[[VWWLine alloc]initWithBegin:[self getLineXBegin]
//                                             andEnd:[self getLineXEnd]]autorelease];
//    [self.configView setLineX:xLine valid:YES];
//    
//    VWWLine* yLine = [[[VWWLine alloc]initWithBegin:[self getLineYBegin]
//                                             andEnd:[self getLineYEnd]]autorelease];
//    [self.configView setLineY:yLine valid:YES];
//    
//    if(self.inputType != kInputTouch){
//        VWWLine* zLine = [[[VWWLine alloc]initWithBegin:[self getLineZBegin]
//                                                 andEnd:[self getLineZEnd]]autorelease];
//        [self.configView setLineZ:zLine valid:YES];
//    }
//}
//
//-(CGPoint)getLineXBegin{
//    return CGPointMake(self.xLabel.center.x + self.xLabel.frame.size.width/2.0,
//                       self.xLabel.center.y);
//}
//-(CGPoint)getLineXEnd{
//    return [self getLineEndWithEffect:self.input.x.effectType];
//}
//-(CGPoint)getLineYBegin{
//    return CGPointMake(self.yLabel.center.x + self.yLabel.frame.size.width/2.0,
//                       self.yLabel.center.y);
//}
//-(CGPoint)getLineYEnd{
//    return [self getLineEndWithEffect:self.input.y.effectType];
//}
//-(CGPoint)getLineZBegin{
//    return CGPointMake(self.zLabel.center.x + self.zLabel.frame.size.width/2.0,
//                       self.zLabel.center.y);
//}
//-(CGPoint)getLineZEnd{
//    return [self getLineEndWithEffect:self.input.z.effectType];
//}
//-(CGPoint)getLineEndWithEffect:(EffectType)effect{
//    switch(effect){
//        case kEffectAutoTune:
//            return CGPointMake(self.autotuneLabel.frame.origin.x, self.autotuneLabel.frame.origin.y + self.autotuneLabel.frame.size.height/2.0);
//            break;
//        case kEffectLinearize:
//            return CGPointMake(self.linearizeLabel.frame.origin.x, self.linearizeLabel.frame.origin.y + self.linearizeLabel.frame.size.height/2.0);
//            break;
//        case kEffectThrottle:
//            return CGPointMake(self.throttleLabel.frame.origin.x, self.throttleLabel.frame.origin.y + self.throttleLabel.frame.size.height/2.0);
//            break;
//        case kEffectNone:
//        default:
//            return CGPointMake(self.noEffectLabel.frame.origin.x, self.noEffectLabel.frame.origin.y + self.noEffectLabel.frame.size.height/2.0);
//    }
//}
//
//
//
- (IBAction)dismissInfoViewButton:(id)sender {
//    [UIView animateWithDuration:VWW_DISMISS_INFO_DURATION animations:^{
//        self.infoView.alpha = 0.0;
//    } completion:^(BOOL finished){
//        [self.infoView removeFromSuperview];
//    }];
}
//
//
//- (void)dealloc {
//    [_autotuneLabel release];
//    [_noEffectLabel release];
//    [_linearizeLabel release];
//    [_throttleLabel release];
//    [super dealloc];
//}
//
- (IBAction)doneButtonHandler:(id)sender {
//    [VWWThereminInputs saveConfigFile];
//    [self.delegate vwwThereminConfigInputKeyViewControllerUserIsDone:self];
}
@end
