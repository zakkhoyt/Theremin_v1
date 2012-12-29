//
//  VWWThereminConfigInputFrequencyViewController.m
//  Theremin
//// VWWThereminConfigInputFrequencyViewController
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputFrequencyViewController.h"
#import "VWWConfigSensorView.h"

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

static NSString* kXMaxLabelPrefix = @"X Max";
static NSString* kXMinLabelPrefix = @"X Min";
static NSString* kYMaxLabelPrefix = @"Y Max";
static NSString* kYMinLabelPrefix = @"Y Min";
static NSString* kZMaxLabelPrefix = @"Z Max";
static NSString* kZMinLabelPrefix = @"Z Min";

@interface VWWThereminConfigInputFrequencyViewController ()
//@property (retain, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (nonatomic, retain) IBOutlet UIView* infoView;
@property (retain, nonatomic) IBOutlet VWWConfigSensorView *configView;
@property (retain, nonatomic) IBOutlet UILabel *frequencyMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *frequencyMinLabel;
@property (retain, nonatomic) IBOutlet UILabel *xMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *xMinLabel;
@property (retain, nonatomic) IBOutlet UILabel *yMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *yMinLabel;
@property (retain, nonatomic) IBOutlet UILabel *zMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *zMinLabel;
@property (nonatomic) LineType lineType;
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect frequencyEndzone;


- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)cancelButtonHandler:(id)sender;
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
    switch(self.sensorType){
        case kVWWSensorTypeAccelerometer:
            self.navigationItem.title = @"Accelerometer";
            break;
        case kVWWSensorTypeGyro:
            self.navigationItem.title = @"Gyroscopes";
            break;
        case kVWWSensorTypeMagnetometer:
            self.navigationItem.title = @"Magnetometers";
            break;
        case kVWWSensorTypeTouch:
            self.navigationItem.title = @"Touch Screen";
            break;
        case kVWWSensorTypeNone:
            self.navigationItem.title = @"Invalid Input";
        default:
            break;
    }
    
    self.frequencyMaxLabel.text = [self stringFromFrequency:VWW_FREQUENCY_MAX];
    self.frequencyMinLabel.text = [self stringFromFrequency:VWW_FREQUENCY_MIN];
    
    CGPoint begin = self.frequencyMaxLabel.center;
    begin.y += self.frequencyMaxLabel.frame.size.height/2.0;
    
    CGPoint end = self.frequencyMinLabel.center;
    NSLog(@"%@", NSStringFromCGPoint(end));
    end.y -= self.frequencyMinLabel.frame.size.height/2.0;
    
    VWWLine* frequenciesLine = [[VWWLine alloc]
                                           initWithBegin:begin
                                           andEnd:end];
    [self.configView setLineFrequencies:frequenciesLine];
    [frequenciesLine release];

    self.frequencyEndzone = CGRectMake(begin.x - kEndzoneWidth/2.0,
                                       begin.y,
                                       kEndzoneWidth,
                                       end.y - begin.y);
//    NSLog(@"_frequencyEndzone = %@", NSStringFromCGRect(self.frequencyEndzone));

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_frequencyMaxLabel release];
    [_frequencyMinLabel release];
    [_xMaxLabel release];
    [_xMinLabel release];
    [_yMaxLabel release];
    [_yMinLabel release];
    [_zMaxLabel release];
    [_zMinLabel release];
    [super dealloc];
}



#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    CGPoint begin = [touch locationInView:self.configView];
//    NSLog(@"%@", NSStringFromCGPoint(begin));
//    NSLog(@"%@", NSStringFromCGRect(self.xMaxLabel.frame));
    
    if(CGRectContainsPoint(self.xMaxLabel.frame, begin)){
        self.lineType = kLineTypeXMax;
        self.begin = CGPointMake(self.xMaxLabel.center.x + self.xMaxLabel.frame.size.width/2.0,
                                 self.xMaxLabel.center.y);
    }
    else if(CGRectContainsPoint(self.xMinLabel.frame, begin)){
        self.lineType = kLineTypeXMin;
        self.begin = CGPointMake(self.xMinLabel.center.x + self.xMinLabel.frame.size.width/2.0,
                                 self.xMinLabel.center.y);
    }
    else if(CGRectContainsPoint(self.yMaxLabel.frame, begin)){
        self.lineType = kLineTypeYMax;
        self.begin = CGPointMake(self.yMaxLabel.center.x + self.yMaxLabel.frame.size.width/2.0,
                                 self.yMaxLabel.center.y);
    }
    else if(CGRectContainsPoint(self.yMinLabel.frame, begin)){
        self.lineType = kLineTypeYMin;
        self.begin = CGPointMake(self.yMinLabel.center.x + self.yMinLabel.frame.size.width/2.0,
                                 self.yMinLabel.center.y);
    }
    else if(CGRectContainsPoint(self.zMaxLabel.frame, begin)){
        self.lineType = kLineTypeZMax;
        self.begin = CGPointMake(self.zMaxLabel.center.x + self.zMaxLabel.frame.size.width/2.0,
                                 self.zMaxLabel.center.y);
    }
    else if(CGRectContainsPoint(self.zMinLabel.frame, begin)){
        self.lineType = kLineTypeZMin;
        self.begin = CGPointMake(self.zMinLabel.center.x + self.zMinLabel.frame.size.width/2.0,
                                 self.zMinLabel.center.y);
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
    UITouch* touch = [touchesArray objectAtIndex:0];
    CGPoint end = [touch locationInView:self.configView];

    if(CGRectContainsPoint(self.frequencyEndzone, end)){
        self.end = CGPointMake(self.frequencyEndzone.origin.x + self.frequencyEndzone.size.width/2.0, end.y);
        
        // Calculate frequcency
        float endzonePoint = self.frequencyEndzone.origin.y + self.frequencyEndzone.size.height - end.y;
        float endzoneHeight = self.frequencyEndzone.size.height;
        float ratio = endzonePoint/endzoneHeight;
        float frequency = ((VWW_FREQUENCY_MAX - VWW_FREQUENCY_MIN) * ratio) + VWW_FREQUENCY_MIN;
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
    [line release];
    [self.configView setNeedsDisplay];
}


- (IBAction)dismissInfoViewButton:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.infoView.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.infoView removeFromSuperview];
    }];
}

- (IBAction)cancelButtonHandler:(id)sender {
    [self.delegate VWWThereminConfigInputFrequencyViewControllerUserDidCancel:self];
}

- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate VWWThereminConfigInputFrequencyViewControllerUserIsDone:self];
}
@end
