//
//  VWWThereminConfigInputWaveformsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputWaveformsViewController.h"
#import "VWWConfigInputWaveformView.h"

typedef enum{
    kLineTypeNone = 0,
    kLineTypeX,
    kLineTypeY,
    kLineTypeZ,
} LineType;

@interface VWWThereminConfigInputWaveformsViewController ()
@property (nonatomic, retain) IBOutlet UIView* infoView;
@property (nonatomic) LineType lineType;
@property (nonatomic, retain) IBOutlet VWWConfigInputWaveformView* configView;
@property (retain, nonatomic) IBOutlet UILabel *xLabel;
@property (retain, nonatomic) IBOutlet UILabel *yLabel;
@property (retain, nonatomic) IBOutlet UILabel *zLabel;
@property (retain, nonatomic) IBOutlet UIImageView *sinImageView;
@property (retain, nonatomic) IBOutlet UIImageView *squareImageView;
@property (retain, nonatomic) IBOutlet UIImageView *triangleImageView;
@property (retain, nonatomic) IBOutlet UIImageView *sawtoothImageView;

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGRect waveformEndzone;
- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)cancelButtonHandler:(id)sender;
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
            break;
        case kInputGyros:
            self.navigationItem.title = @"Gyroscopes";
            break;
        case kInputMagnetometer:
            self.navigationItem.title = @"Magnetometers";
            break;
        case kInputTouch:
            self.navigationItem.title = @"Touch Screen";
            break;
        case kInputNone:
            self.navigationItem.title = @"Invalid Input";
        default:
            break;
    }
    
    self.waveformEndzone = CGRectMake(self.sinImageView.frame.origin.x,
                                      self.sinImageView.frame.origin.y,
                                      self.sinImageView.frame.size.width,
                                      self.sawtoothImageView.frame.origin.y + self.sawtoothImageView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.begin = CGPointMake(self.xLabel.center.x + self.xLabel.frame.size.width/2.0,
                                 self.xLabel.center.y);
    }
    else if(CGRectContainsPoint(self.yLabel.frame, begin)){
        self.lineType = kLineTypeY;
        self.begin = CGPointMake(self.yLabel.center.x + self.yLabel.frame.size.width/2.0,
                                 self.yLabel.center.y);
    }
    else if(CGRectContainsPoint(self.zLabel.frame, begin)){
        self.lineType = kLineTypeZ;
        self.begin = CGPointMake(self.zLabel.center.x + self.zLabel.frame.size.width/2.0,
                                 self.zLabel.center.y);
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
    UITouch* touch = [touchesArray objectAtIndex:0];
    CGPoint end = [touch locationInView:self.configView];
    
//    if(CGRectContainsPoint(self.waveformEndzone, end)){
//        self.end = CGPointMake(self.waveformEndzone.origin.x + self.waveformEndzone.size.width/2.0, end.y);
//        [self updateConfigViewLinesValid:YES];
//    }
    if(CGRectContainsPoint(self.sinImageView.frame, end)){
        self.end = CGPointMake(self.sinImageView.frame.origin.x, self.sinImageView.frame.origin.y + self.sinImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.squareImageView.frame, end)){
        self.end = CGPointMake(self.squareImageView.frame.origin.x, self.squareImageView.frame.origin.y + self.squareImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.triangleImageView.frame, end)){
        self.end = CGPointMake(self.triangleImageView.frame.origin.x, self.triangleImageView.frame.origin.y + self.triangleImageView.frame.size.height/2.0);
        [self updateConfigViewLinesValid:YES];
    }
    else if(CGRectContainsPoint(self.sawtoothImageView.frame, end)){
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












- (IBAction)dismissInfoViewButton:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.infoView.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.infoView removeFromSuperview];
    }];
}

- (IBAction)cancelButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigInputWaveformsViewControllerUserCancelled:self];
}

- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigInputWaveformsViewControllerUserIsDone:self];
}
- (void)dealloc {
    [_xLabel release];
    [_yLabel release];
    [_zLabel release];
    [_sinImageView release];
    [_squareImageView release];
    [_triangleImageView release];
    [_sawtoothImageView release];
    [super dealloc];
}
@end
