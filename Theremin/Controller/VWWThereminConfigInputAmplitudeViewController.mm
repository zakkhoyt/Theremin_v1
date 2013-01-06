//
//  VWWThereminConfigInputAmplitudeViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 1/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputAmplitudeViewController.h"
#import "VWWConfigInputAmplitudeView.h"
#import "VWWThereminInputs.h"

const NSUInteger kEndzoneWidth = 30;

typedef enum{
    kLineTypeNone = 0,
    kLineTypeX,
    kLineTypeY,
    kLineTypeZ,
} LineType;


static NSString* kXLabelPrefix = @"X Axis";
static NSString* kYLabelPrefix = @"Y Axis";
static NSString* kZLabelPrefix = @"Z Axis";

@interface VWWThereminConfigInputAmplitudeViewController ()
@property (nonatomic, retain) IBOutlet UIView* infoView;
@property (retain, nonatomic) IBOutlet VWWConfigInputAmplitudeView *configView;
@property (retain, nonatomic) IBOutlet UILabel *amplitudeMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *amplitudeMinLabel;
@property (retain, nonatomic) IBOutlet UILabel *xLabel;
@property (retain, nonatomic) IBOutlet UILabel *yLabel;
@property (retain, nonatomic) IBOutlet UILabel *zLabel;

@property (nonatomic) LineType lineType;
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect amplitudeEndzone;
@property (nonatomic, retain) VWWThereminInput* input;

- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigInputAmplitudeViewController

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
            self.zLabel.hidden = YES;
            self.zLabel.hidden = YES;
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
    self.amplitudeMaxLabel.text = [self stringFromAmplitude:VWW_AMPLITUDE_MAX];
    self.amplitudeMaxLabel.text = [self stringFromAmplitude:VWW_AMPLITUDE_MIN];
    
    // Set up amplitude line
    CGPoint begin = self.amplitudeMaxLabel.center;
    begin.y += self.amplitudeMaxLabel.frame.size.height/2.0;
    CGPoint end = self.amplitudeMinLabel.center;
    NSLog(@"%@", NSStringFromCGPoint(end));
    end.y -= self.amplitudeMinLabel.frame.size.height/2.0;
    VWWLine* amplitudeLine = [[VWWLine alloc]
                                initWithBegin:begin
                                andEnd:end];
    [self.configView setLineAmplitude:amplitudeLine];
    [amplitudeLine release];
    
    // Calculate endzone (for touch events)
    self.amplitudeEndzone = CGRectMake(begin.x - kEndzoneWidth/2.0,
                                       begin.y,
                                       kEndzoneWidth,
                                       end.y - begin.y);
    
    
    
    
    // Update GUI from data in memory
    [self makeLinesFromInputData];
    [self updateAmplitudeLabels];
    
    [self.configView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_amplitudeMaxLabel release];
    [_amplitudeMinLabel release];
    [_xLabel release];
    [_yLabel release];
    [_zLabel release];
    [super dealloc];
}



#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
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
    UITouch* touch = [touchesArray objectAtIndex:0];
    self.end = [touch locationInView:self.configView];
    
    if(CGRectContainsPoint(self.amplitudeEndzone, self.end)){
        
        // Calculate frequcency
        float endzonePoint = self.amplitudeEndzone.origin.y + self.amplitudeEndzone.size.height - self.end.y;
        float endzoneHeight = self.amplitudeEndzone.size.height;
        float ratio = endzonePoint/endzoneHeight;
        float amplitude = ((VWW_AMPLITUDE_MAX - VWW_AMPLITUDE_MIN) * ratio) + VWW_AMPLITUDE_MIN;
        NSString* amplitudeString = [self stringFromAmplitude:amplitude];
        [self updateAxisLabelsWithAmplitude:amplitudeString];
        [self updateConfigViewLinesValid:YES];
    }
    else{
        [self updateAxisLabelsWithAmplitude:@""];
        [self updateConfigViewLinesValid:NO];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // We don't want to draw a line if we didnt' start from an appropriate location
    if(self.lineType == kLineTypeNone){
        return;
    }
    
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    CGPoint end = [touch locationInView:self.configView];
    
    if(CGRectContainsPoint(self.amplitudeEndzone, end)){
        self.end = CGPointMake(self.amplitudeEndzone.origin.x + self.amplitudeEndzone.size.width/2.0, end.y);
        
        // Calculate frequcency
        float endzonePoint = self.amplitudeEndzone.origin.y + self.amplitudeEndzone.size.height - end.y;
        float endzoneHeight = self.amplitudeEndzone.size.height;
        float ratio = endzonePoint/endzoneHeight;
        float amplitude = ((VWW_AMPLITUDE_MAX - VWW_AMPLITUDE_MIN) * ratio) + VWW_AMPLITUDE_MIN;
        
        // Update data structure
        [self updateInputAmplitude:amplitude];
        
        // Update GUI
        NSString* amplitudeString = [self stringFromAmplitude:amplitude];
        [self updateAxisLabelsWithAmplitude:amplitudeString];
        [self updateConfigViewLinesValid:YES];
    }
    else{
        // Setting these points to 0 will cause it not to be drawn
        self.begin = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        [self updateConfigViewLinesValid:NO];
    }
}

-(NSString*)stringFromAmplitude:(float)amplitude{
//    if(amplitude < 1000){
//        return [NSString stringWithFormat:@"%d Hz", (int)amplitude];
//    }
//    float significand = amplitude / 1000;
    return [NSString stringWithFormat:@"%d", (int)amplitude*100];
}

// For when a user is drawing
-(void)updateInputAmplitude:(float)amplitude{
    switch(self.lineType){
        case kLineTypeX:
            self.input.x.volume = amplitude;
            break;
        case kLineTypeY:
            self.input.y.volume = amplitude;
            break;
        case kLineTypeZ:
            self.input.z.volume = amplitude;
            break;
        default:
            return;
            
    }
}


// For when a user is drawing
-(void)updateAxisLabelsWithAmplitude:(NSString*)amplitude{
    switch(self.lineType){
        case kLineTypeX:
            self.xLabel.text = [NSString stringWithFormat:@"%@\n%@", kXLabelPrefix, amplitude];
            break;
        case kLineTypeY:
            self.yLabel.text = [NSString stringWithFormat:@"%@\n%@", kYLabelPrefix, amplitude];
            break;
        case kLineTypeZ:
            self.zLabel.text = [NSString stringWithFormat:@"%@\n%@", kZLabelPrefix, amplitude];
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
    [line release];
    [self.configView setNeedsDisplay];
}



-(void)makeLinesFromInputData{
    VWWLine* xLine = [[[VWWLine alloc]initWithBegin:[self getLineXBegin]
                                                andEnd:[self getLineXEnd]]autorelease];
    [self.configView setLineX:xLine valid:YES];
    
    
    VWWLine* yLine = [[[VWWLine alloc]initWithBegin:[self getLineYBegin]
                                                andEnd:[self getLineYEnd]]autorelease];
    [self.configView setLineY:yLine valid:YES];
    
    if(self.inputType != kInputTouch){
        VWWLine* zLine = [[[VWWLine alloc]initWithBegin:[self getLineZBegin]
                                                    andEnd:[self getLineZEnd]]autorelease];
        [self.configView setLineZ:zLine valid:YES];
    }
}

-(void)updateAmplitudeLabels{
    self.xLabel.text = [NSString stringWithFormat:@"%@\n%@", kXLabelPrefix, [self stringFromAmplitude:self.input.x.volume]];
    self.yLabel.text = [NSString stringWithFormat:@"%@\n%@", kYLabelPrefix, [self stringFromAmplitude:self.input.y.volume]];
    self.zLabel.text = [NSString stringWithFormat:@"%@\n%@", kZLabelPrefix, [self stringFromAmplitude:self.input.z.volume]];
}

-(CGPoint)getLineXBegin{
    return CGPointMake(self.xLabel.center.x + self.xLabel.frame.size.width/2.0,
                       self.xLabel.center.y);
}
-(CGPoint)getLineXEnd{
    return [self getPointOnAmplitudeLine:self.input.x.volume];
}
-(CGPoint)getLineYBegin{
    return CGPointMake(self.yLabel.center.x + self.yLabel.frame.size.width/2.0,
                       self.yLabel.center.y);
}
-(CGPoint)getLineYEnd{
    return [self getPointOnAmplitudeLine:self.input.y.volume];
}
-(CGPoint)getLineZBegin{
    return CGPointMake(self.zLabel.center.x + self.zLabel.frame.size.width/2.0,
                       self.zLabel.center.y);
}
-(CGPoint)getLineZEnd{
    return [self getPointOnAmplitudeLine:self.input.z.volume];
}

-(CGPoint)getPointOnAmplitudeLine:(float)amplitude{
    float fTotal = VWW_AMPLITUDE_MAX - VWW_AMPLITUDE_MIN;
    float fPoint = (amplitude - VWW_AMPLITUDE_MIN) / fTotal; // 0.0 .. 1.0
    return CGPointMake(self.amplitudeEndzone.origin.x + self.amplitudeEndzone.size.width/2.0, // center x wise
                       (self.amplitudeEndzone.origin.y + self.amplitudeEndzone.size.height
                        - (self.amplitudeEndzone.size.height * fPoint))); // origin + % of height
    
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
    [self.delegate vwwThereminConfigInputAmplitudeViewControllerUserIsDone:self];
}

@end
