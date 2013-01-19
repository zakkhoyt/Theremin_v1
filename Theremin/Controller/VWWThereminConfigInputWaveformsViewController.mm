//
//  VWWThereminConfigInputWaveformsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputWaveformsViewController.h"
#import "VWWConfigInputWaveformView.h"
#import "VWWThereminInputs.h"

typedef enum{
    kLineTypeNone = 0,
    kLineTypeX,
    kLineTypeY,
    kLineTypeZ,
} LineType;

@interface VWWThereminConfigInputWaveformsViewController ()
@property (nonatomic, strong) IBOutlet UIView* infoView;
@property (nonatomic) LineType lineType;
@property (nonatomic, strong) IBOutlet VWWConfigInputWaveformView* configView;
@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *zLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sinImageView;
@property (strong, nonatomic) IBOutlet UIImageView *squareImageView;
@property (strong, nonatomic) IBOutlet UIImageView *triangleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *sawtoothImageView;
@property (nonatomic, strong) VWWThereminInput* input;
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect waveformEndzone;
- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigInputWaveformsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if defined(VWW_SHOW_INFO_SCREENS)
    [self.view addSubview:self.infoView];
    [self.infoView setFrame:self.view.frame];
    [self.infoView setHidden:NO];
#endif
    

    // Set nav bar title
    switch(self.inputType){
        case kInputAccelerometer:
            self.navigationItem.title = @"Accelerometers";
            self.input = [VWWThereminInputs accelerometerInput];
            break;
        case kInputGyros:
            self.navigationItem.title = @"Gyroscopes";
            self.input = [VWWThereminInputs gyroscopeInput];
            break;
        case kInputMagnetometer:
            self.navigationItem.title = @"Magnetometers";
            self.input = [VWWThereminInputs magnetometerInput];
            break;
        case kInputTouch:
            self.navigationItem.title = @"Touch Screen";
            self.input = [VWWThereminInputs touchscreenInput];
            self.zLabel.hidden = YES;
            break;
        case kInputNone:
            self.navigationItem.title = @"Invalid Input";
            self.input = nil;
        default:
            break;
    }
    
    self.waveformEndzone = CGRectMake(self.sinImageView.frame.origin.x,
                                      self.sinImageView.frame.origin.y,
                                      self.sinImageView.frame.size.width,
                                      self.sawtoothImageView.frame.origin.y + self.sawtoothImageView.frame.size.height);
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self makeLinesFromInputData];
    [self.configView setNeedsDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint begin = [touch locationInView:self.configView];
    //    NSLog(@"%@", NSStringFromCGPoint(begin));
    //    NSLog(@"%@", NSStringFromCGRect(self.xMaxLabel.frame));
    
    if(CGRectContainsPoint(self.xLabel.frame, begin)){
        self.lineType = kLineTypeX;
        self.begin = [self getLineXBegin];
    }
    else if(CGRectContainsPoint(self.yLabel.frame, begin)){
        self.lineType = kLineTypeY;
        self.begin = [self getLineYBegin];
    }
    else if(CGRectContainsPoint(self.zLabel.frame, begin)){
        self.lineType = kLineTypeZ;
        self.begin = [self getLineZBegin];
    }
    else{
        self.lineType = kLineTypeNone;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // We don't want to draw a line if we didnt' start from an appropriate location
    if(self.lineType == kLineTypeNone){
        return;
    }
    
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.end = [touch locationInView:self.configView];
    
    if(CGRectContainsPoint(self.waveformEndzone, self.end)){
        [self updateConfigViewLinesValid:YES];
    }
    else{
        [self updateConfigViewLinesValid:NO];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // We don't want to draw a line if we didnt' start from an appropriate location
    if(self.lineType == kLineTypeNone){
        return;
    }
    
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint end = [touch locationInView:self.configView];
    
    if(CGRectContainsPoint(self.sinImageView.frame, end)){
        [self updateWavetype:kWaveSin];
        self.end = CGPointMake(self.sinImageView.frame.origin.x, self.sinImageView.frame.origin.y + self.sinImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.squareImageView.frame, end)){
        [self updateWavetype:kWaveSquare];
        self.end = CGPointMake(self.squareImageView.frame.origin.x, self.squareImageView.frame.origin.y + self.squareImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.triangleImageView.frame, end)){
        [self updateWavetype:kWaveTriangle];
        self.end = CGPointMake(self.triangleImageView.frame.origin.x, self.triangleImageView.frame.origin.y + self.triangleImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.sawtoothImageView.frame, end)){
        [self updateWavetype:kWaveSawtooth];
        self.end = CGPointMake(self.sawtoothImageView.frame.origin.x, self.sawtoothImageView.frame.origin.y + self.sawtoothImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else{
        // Setting these points to 0 will cause it not to be drawn
        self.begin = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        [self updateConfigViewLinesValid:NO];
    }
}



// For when a user is drawing
-(void)updateWavetype:(WaveType)wavetype{
    switch(self.lineType){
        case kLineTypeX:
            self.input.x.waveType = wavetype;
            break;
        case kLineTypeY:
            self.input.y.waveType = wavetype;
            break;
        case kLineTypeZ:
            self.input.z.waveType = wavetype;
            break;
        default:
            return;
    }
}

// For when a user is drawing
-(void)updateConfigViewLinesValid:(bool)valid{
    VWWLine* line = [[VWWLine alloc]initWithBegin:self.begin andEnd:self.end];
    switch(self.lineType){
        case kLineTypeX:
            [self.configView setLineX:line valid:valid];
            break;
        case kLineTypeY:
            [self.configView setLineY:line valid:valid];
            break;
        case kLineTypeZ:
            [self.configView setLineZ:line valid:valid];
            break;
        default:
            return;
            
    }
    [self.configView setNeedsDisplay];
}

// For loading data
-(void)makeLinesFromInputData{
    VWWLine* xLine = [[VWWLine alloc]initWithBegin:[self getLineXBegin]
                                                andEnd:[self getLineXEnd]];
    [self.configView setLineX:xLine valid:YES];

    VWWLine* yLine = [[VWWLine alloc]initWithBegin:[self getLineYBegin]
                                             andEnd:[self getLineYEnd]];
    [self.configView setLineY:yLine valid:YES];
    
    if(self.inputType != kInputTouch){
        VWWLine* zLine = [[VWWLine alloc]initWithBegin:[self getLineZBegin]
                                                 andEnd:[self getLineZEnd]];
        [self.configView setLineZ:zLine valid:YES];
    }
}

-(CGPoint)getLineXBegin{
    return CGPointMake(self.xLabel.center.x + self.xLabel.frame.size.width/2.0,
                       self.xLabel.center.y);
}
-(CGPoint)getLineXEnd{
    return [self getLineEndWithWavetype:self.input.x.waveType];
}
-(CGPoint)getLineYBegin{
    return CGPointMake(self.yLabel.center.x + self.yLabel.frame.size.width/2.0,
                       self.yLabel.center.y);
}
-(CGPoint)getLineYEnd{
    return [self getLineEndWithWavetype:self.input.y.waveType];
}
-(CGPoint)getLineZBegin{
    return CGPointMake(self.zLabel.center.x + self.zLabel.frame.size.width/2.0,
                       self.zLabel.center.y);
}
-(CGPoint)getLineZEnd{
    return [self getLineEndWithWavetype:self.input.z.waveType];
}
-(CGPoint)getLineEndWithWavetype:(WaveType)wavetype{
    switch(wavetype){
        case kWaveSin:
            return CGPointMake(self.sinImageView.frame.origin.x, self.sinImageView.frame.origin.y + self.sinImageView.frame.size.height/2.0);
            break;
        case kWaveSquare:
            return CGPointMake(self.squareImageView.frame.origin.x, self.squareImageView.frame.origin.y + self.squareImageView.frame.size.height/2.0);
            break;
        case kWaveSawtooth:
            return CGPointMake(self.sawtoothImageView.frame.origin.x, self.sawtoothImageView.frame.origin.y + self.sawtoothImageView.frame.size.height/2.0);
            break;
        case kWaveTriangle:
            return CGPointMake(self.triangleImageView.frame.origin.x, self.triangleImageView.frame.origin.y + self.triangleImageView.frame.size.height/2.0);
            break;
        case kWaveNone:
        default:
            return CGPointMake(0,0);
    }
}



- (IBAction)dismissInfoViewButton:(id)sender {
    [UIView animateWithDuration:VWW_DISMISS_INFO_DURATION animations:^{
        self.infoView.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.infoView removeFromSuperview];
    }];
}

- (IBAction)doneButtonHandler:(id)sender {
    [VWWThereminInputs saveConfigFile];
    [self.delegate vwwThereminConfigInputWaveformsViewControllerUserIsDone:self];
}
@end
