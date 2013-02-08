//
//  VWWThereminConfigInputFrequencyViewController.m
//  Theremin
//// VWWThereminConfigInputFrequencyViewController
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputFrequencyViewController.h"
#import "VWWConfigInputFrequencyView.h"
#import "VWWThereminInputs.h"


const NSUInteger kEndzoneWidth = 30;

typedef enum{
    kLineTypeNone = 0,
    kLineTypeXMax,
    kLineTypeXMin,
    kLineTypeYMax,
    kLineTypeYMin,
    kLineTypeZMax,
    kLineTypeZMin,
} LineType;

static __attribute ((unused)) NSString* kXMaxLabelPrefix = @"X Max";
static __attribute ((unused)) NSString* kXMinLabelPrefix = @"X Min";
static __attribute ((unused)) NSString* kYMaxLabelPrefix = @"Y Max";
static __attribute ((unused)) NSString* kYMinLabelPrefix = @"Y Min";
static __attribute ((unused)) NSString* kZMaxLabelPrefix = @"Z Max";
static __attribute ((unused)) NSString* kZMinLabelPrefix = @"Z Min";

@interface VWWThereminConfigInputFrequencyViewController ()
//@property (retain, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic, strong) IBOutlet UIView* infoView;
@property (strong, nonatomic) IBOutlet VWWConfigInputFrequencyView *configView;
@property (strong, nonatomic) IBOutlet UILabel *frequencyMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *frequencyMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *xMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *xMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *yMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *yMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *zMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *zMinLabel;
@property (nonatomic) LineType lineType;
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect frequencyEndzone;
@property (nonatomic, strong) VWWThereminInput* input;

- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigInputFrequencyViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeClass];
    }
    return self;
}

-(void)initializeClass{

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
            self.zMaxLabel.hidden = YES;
            self.zMinLabel.hidden = YES;
            break;
        case kInputNone:
            self.navigationItem.title = @"Invalid Input";
            self.input = nil;
        default:
            break;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    // Update labels
    self.frequencyMaxLabel.text = [self stringFromFrequency:VWW_FREQUENCY_MAX];
    self.frequencyMinLabel.text = [self stringFromFrequency:VWW_FREQUENCY_MIN];
    
    // Set up frequency line
    CGPoint begin = self.frequencyMaxLabel.center;
    begin.y += self.frequencyMaxLabel.frame.size.height/2.0;
    CGPoint end = self.frequencyMinLabel.center;
    NSLog(@"%@", NSStringFromCGPoint(end));
    end.y -= self.frequencyMinLabel.frame.size.height/2.0;
    VWWLine* frequenciesLine = [[VWWLine alloc]
                                initWithBegin:begin
                                andEnd:end];
    [self.configView setLineFrequencies:frequenciesLine];
    
    // Calculate endzone (for touch events)
    self.frequencyEndzone = CGRectMake(begin.x - kEndzoneWidth/2.0,
                                       begin.y,
                                       kEndzoneWidth,
                                       end.y - begin.y);
    
    
    
    
    // Update GUI from data in memory
    [self makeLinesFromInputData];
    [self updateFrequencyLabels];
    
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
    
    if(CGRectContainsPoint(self.xMaxLabel.frame, begin)){
        self.lineType = kLineTypeXMax;
        self.begin = [self getLineXMaxBegin];
    }
    else if(CGRectContainsPoint(self.xMinLabel.frame, begin)){
        self.lineType = kLineTypeXMin;
        self.begin = [self getLineXMinBegin];
    }
    else if(CGRectContainsPoint(self.yMaxLabel.frame, begin)){
        self.lineType = kLineTypeYMax;
        self.begin = [self getLineYMaxBegin];
    }
    else if(CGRectContainsPoint(self.yMinLabel.frame, begin)){
        self.lineType = kLineTypeYMin;
        self.begin = [self getLineYMinBegin];
    }
    else if(CGRectContainsPoint(self.zMaxLabel.frame, begin)){
        self.lineType = kLineTypeZMax;
        self.begin = [self getLineZMaxBegin];
    }
    else if(CGRectContainsPoint(self.zMinLabel.frame, begin)){
        self.lineType = kLineTypeZMin;
        self.begin = [self getLineZMinBegin];
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
    
    if(CGRectContainsPoint(self.frequencyEndzone, self.end)){
        
        // Calculate frequcency
        float endzonePoint = self.frequencyEndzone.origin.y + self.frequencyEndzone.size.height - self.end.y;
        float endzoneHeight = self.frequencyEndzone.size.height;
        float ratio = endzonePoint/endzoneHeight;
        float frequency = ((VWW_FREQUENCY_MAX - VWW_FREQUENCY_MIN) * ratio) + VWW_FREQUENCY_MIN;
        NSString* frequencyString = [self stringFromFrequency:frequency];
        [self updateAxisLabelsWithFrequency:frequencyString];
        
        [self updateConfigViewLinesValid:YES];
    }
    else{
        [self updateAxisLabelsWithFrequency:@""];
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

    if(CGRectContainsPoint(self.frequencyEndzone, end)){
        self.end = CGPointMake(self.frequencyEndzone.origin.x + self.frequencyEndzone.size.width/2.0, end.y);
        
        // Calculate frequcency
        float endzonePoint = self.frequencyEndzone.origin.y + self.frequencyEndzone.size.height - end.y;
        float endzoneHeight = self.frequencyEndzone.size.height;
        float ratio = endzonePoint/endzoneHeight;
        float frequency = ((VWW_FREQUENCY_MAX - VWW_FREQUENCY_MIN) * ratio) + VWW_FREQUENCY_MIN;
        
        // Update data structure
        [self updateInputFrequency:frequency];
        
        // Update GUI
        NSString* frequencyString = [self stringFromFrequency:frequency];
        [self updateAxisLabelsWithFrequency:frequencyString];
        [self updateConfigViewLinesValid:YES];
    }
    else{
        // Setting these points to 0 will cause it not to be drawn
        self.begin = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        [self updateConfigViewLinesValid:NO];
    }
}

-(NSString*)stringFromFrequency:(float)frequency{
    if(frequency < 1000){
        return [NSString stringWithFormat:@"%d Hz", (int)frequency];
    }
    float significand = frequency / 1000;
    return [NSString stringWithFormat:@"%.2f kHz", significand];
}

// For when a user is drawing
-(void)updateInputFrequency:(float)frequency{
    switch(self.lineType){
        case kLineTypeXMax:
            self.input.x.frequencyMax = frequency;
            break;
        case kLineTypeXMin:
            self.input.x.frequencyMin = frequency;
            break;
        case kLineTypeYMax:
            self.input.y.frequencyMax = frequency;
            break;
        case kLineTypeYMin:
            self.input.y.frequencyMin = frequency;
            break;
        case kLineTypeZMax:
            self.input.z.frequencyMax = frequency;
            break;
        case kLineTypeZMin:
            self.input.z.frequencyMin = frequency;
            break;
        default:
            return;
            
    }
}


// For when a user is drawing
-(void)updateAxisLabelsWithFrequency:(NSString*)frequency{
    switch(self.lineType){
        case kLineTypeXMax:
            self.xMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kXMaxLabelPrefix, frequency];
            break;
        case kLineTypeXMin:
            self.xMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kXMinLabelPrefix, frequency];
            break;
        case kLineTypeYMax:
            self.yMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kYMaxLabelPrefix, frequency];
            break;
        case kLineTypeYMin:
            self.yMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kYMinLabelPrefix, frequency];
            break;
        case kLineTypeZMax:
            self.zMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kZMaxLabelPrefix, frequency];
            break;
        case kLineTypeZMin:
            self.zMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kZMinLabelPrefix, frequency];
            break;
        default:
            return;
            
    }
}

// For when a user is drawing
-(void)updateConfigViewLinesValid:(bool)valid{
    VWWLine* line = [[VWWLine alloc]initWithBegin:self.begin andEnd:self.end];
    switch(self.lineType){
        case kLineTypeXMax:
            [self.configView setLineXMax:line valid:valid];
            break;
        case kLineTypeXMin:
            [self.configView setLineXMin:line valid:valid];
            break;
        case kLineTypeYMax:
            [self.configView setLineYMax:line valid:valid];
            break;
        case kLineTypeYMin:
            [self.configView setLineYMin:line valid:valid];
            break;
        case kLineTypeZMax:
            [self.configView setLineZMax:line valid:valid];
            break;
        case kLineTypeZMin:
            [self.configView setLineZMin:line valid:valid];
            break;
        default:
            return;
            
    }
    [self.configView setNeedsDisplay];
}



-(void)makeLinesFromInputData{
    VWWLine* xMaxLine = [[VWWLine alloc]initWithBegin:[self getLineXMaxBegin]
                                               andEnd:[self getLineXMaxEnd]];
    [self.configView setLineXMax:xMaxLine valid:YES];
    
    VWWLine* xMinLine = [[VWWLine alloc]initWithBegin:[self getLineXMinBegin]
                                                andEnd:[self getLineXMinEnd]];
    [self.configView setLineXMin:xMinLine valid:YES];
    
    VWWLine* yMaxLine = [[VWWLine alloc]initWithBegin:[self getLineYMaxBegin]
                                                andEnd:[self getLineYMaxEnd]];
    [self.configView setLineYMax:yMaxLine valid:YES];
    
    VWWLine* yMinLine = [[VWWLine alloc]initWithBegin:[self getLineYMinBegin]
                                                andEnd:[self getLineYMinEnd]];
    [self.configView setLineYMin:yMinLine valid:YES];
    
    if(self.inputType != kInputTouch){
        VWWLine* zMaxLine = [[VWWLine alloc]initWithBegin:[self getLineZMaxBegin]
                                                    andEnd:[self getLineZMaxEnd]];
        [self.configView setLineZMax:zMaxLine valid:YES];
        
        VWWLine* zMinLine = [[VWWLine alloc]initWithBegin:[self getLineZMinBegin]
                                                    andEnd:[self getLineZMinEnd]];
        [self.configView setLineZMin:zMinLine valid:YES];
    }
}

-(void)updateFrequencyLabels{
    self.xMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kXMaxLabelPrefix, [self stringFromFrequency:self.input.x.frequencyMax]];
    self.xMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kXMinLabelPrefix, [self stringFromFrequency:self.input.x.frequencyMin]];
    self.yMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kYMaxLabelPrefix, [self stringFromFrequency:self.input.y.frequencyMax]];
    self.yMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kYMinLabelPrefix, [self stringFromFrequency:self.input.y.frequencyMin]];
    self.zMaxLabel.text = [NSString stringWithFormat:@"%@\n%@", kZMaxLabelPrefix, [self stringFromFrequency:self.input.z.frequencyMax]];
    self.zMinLabel.text = [NSString stringWithFormat:@"%@\n%@", kZMinLabelPrefix, [self stringFromFrequency:self.input.z.frequencyMin]];

}

-(CGPoint)getLineXMaxBegin{
    return CGPointMake(self.xMaxLabel.center.x + self.xMaxLabel.frame.size.width/2.0,
                self.xMaxLabel.center.y);
}
-(CGPoint)getLineXMaxEnd{
    return [self getPointOnFrequencyLine:self.input.x.frequencyMax];
}
-(CGPoint)getLineXMinBegin{
    return CGPointMake(self.xMinLabel.center.x + self.xMinLabel.frame.size.width/2.0,
                self.xMinLabel.center.y);
}
-(CGPoint)getLineXMinEnd{
    return [self getPointOnFrequencyLine:self.input.x.frequencyMin];
}
-(CGPoint)getLineYMaxBegin{
    return CGPointMake(self.yMaxLabel.center.x + self.yMaxLabel.frame.size.width/2.0,
                self.yMaxLabel.center.y);
}
-(CGPoint)getLineYMaxEnd{
    return [self getPointOnFrequencyLine:self.input.y.frequencyMax];
}
-(CGPoint)getLineYMinBegin{
    return CGPointMake(self.yMinLabel.center.x + self.yMinLabel.frame.size.width/2.0,
                self.yMinLabel.center.y);
}
-(CGPoint)getLineYMinEnd{
    return [self getPointOnFrequencyLine:self.input.y.frequencyMin];
}
-(CGPoint)getLineZMaxBegin{
    return CGPointMake(self.zMaxLabel.center.x + self.zMaxLabel.frame.size.width/2.0,
                self.zMaxLabel.center.y);
}
-(CGPoint)getLineZMaxEnd{
    return [self getPointOnFrequencyLine:self.input.z.frequencyMax];
}
-(CGPoint)getLineZMinBegin{
    return CGPointMake(self.zMinLabel.center.x + self.zMinLabel.frame.size.width/2.0,
                self.zMinLabel.center.y);
}
-(CGPoint)getLineZMinEnd{
    return [self getPointOnFrequencyLine:self.input.z.frequencyMin];
}

-(CGPoint)getPointOnFrequencyLine:(float)frequency{
    float fTotal = VWW_FREQUENCY_MAX - VWW_FREQUENCY_MIN;
    float fPoint = (frequency - VWW_FREQUENCY_MIN) / fTotal; // 0.0 .. 1.0
    return CGPointMake(self.frequencyEndzone.origin.x + self.frequencyEndzone.size.width/2.0, // center x wise
                       (self.frequencyEndzone.origin.y + self.frequencyEndzone.size.height
                       - (self.frequencyEndzone.size.height * fPoint))); // origin + % of height
    
}


#pragma mark - Custom UI action handlers. 
- (IBAction)dismissInfoViewButton:(id)sender {
    [UIView animateWithDuration:VWW_DISMISS_INFO_DURATION animations:^{
        self.infoView.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.infoView removeFromSuperview];
    }];
}


- (IBAction)doneButtonHandler:(id)sender {
    [VWWThereminInputs saveConfigFile];
    [self.delegate VWWThereminConfigInputFrequencyViewControllerUserIsDone:self];
}
@end




