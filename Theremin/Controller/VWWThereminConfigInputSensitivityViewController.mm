//
//  VWWThereminConfigInputSensitivityViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputSensitivityViewController.h"
#import "VWWConfigInputSensitivityView.h"
#import "VWWThereminInputs.h"

@interface VWWThereminConfigInputSensitivityViewController ()
@property (nonatomic, strong) IBOutlet UIView* infoView;
@property (nonatomic, strong) IBOutlet VWWConfigInputSensitivityView* configView;
@property (nonatomic, strong) VWWThereminInput* input;
- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *xSlider;
@property (strong, nonatomic) IBOutlet UISlider *ySlider;
@property (strong, nonatomic) IBOutlet UISlider *zSlider;
@property (strong, nonatomic) IBOutlet UILabel *zSliderLabel;

- (IBAction)xSliderHandler:(id)sender;
- (IBAction)ySliderHandler:(id)sender;
- (IBAction)zSliderHandler:(id)sender;

@end

@implementation VWWThereminConfigInputSensitivityViewController

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
            self.zSlider.hidden = YES;
            self.zSliderLabel.hidden = YES;
            break;
        case kInputNone:
            self.navigationItem.title = @"Invalid Input";
            self.input = nil;
        default:
            break;
    }
    
    [self updateSlidersFromData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateSlidersFromData{
    self.xSlider.minimumValue = 0.0;
    self.xSlider.maximumValue = 1.0;
    self.xSlider.value = self.input.x.sensitivity;
    
    self.ySlider.minimumValue = 0.0;
    self.ySlider.maximumValue = 1.0;
    self.ySlider.value = self.input.y.sensitivity;
    
    self.zSlider.minimumValue = 0.0;
    self.zSlider.maximumValue = 1.0;
    self.zSlider.value = self.input.z.sensitivity;
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
    [self.delegate vwwThereminConfigInputSensitivityViewControllerUserIsDone:self];
}

- (IBAction)xSliderHandler:(id)sender {
    UISlider* slider = (UISlider*)sender;
    self.input.x.sensitivity = slider.value;
}

- (IBAction)ySliderHandler:(id)sender {
    UISlider* slider = (UISlider*)sender;
    self.input.y.sensitivity = slider.value;
}

- (IBAction)zSliderHandler:(id)sender {
    UISlider* slider = (UISlider*)sender;
    self.input.z.sensitivity = slider.value;
}
@end
