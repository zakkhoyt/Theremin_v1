//
//  VWWViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import "VWWViewController.h"
#import "VWWThereminInstrumentView.h"

@interface VWWViewController ()
@property (nonatomic, retain) VWWThereminSynthesizerSettings* settings;
@property (nonatomic, retain) VWWMotionMonitor* motion;

// UI components
@property (nonatomic, retain) IBOutlet VWWThereminInstrumentView* instrumentView;
@property (retain, nonatomic) IBOutlet UILabel *lblAccelerometer;
@property (retain, nonatomic) IBOutlet UILabel *lblGyros;
@property (retain, nonatomic) IBOutlet UILabel *lblMagnetometer;
@property (retain, nonatomic) IBOutlet UILabel *lblInfo;

// custom methods
-(void)initializeClass;

@end

@implementation VWWViewController
@synthesize settings = _settings;
@synthesize motion = _motion;
@synthesize instrumentView = _instrumentView;
@synthesize lblAccelerometer = _lblAccelerometer;
@synthesize lblGyros = _lblGyros;
@synthesize lblMagnetometer = _lblMagnetometer;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeClass];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup other UI components
    self.instrumentView.backgroundColor = [UIColor blackColor];
    UIColor* textColor = [UIColor greenColor];
    self.instrumentView.crosshairColor = textColor;
    self.lblAccelerometer.textColor = textColor;
    self.lblGyros.textColor = textColor;
    self.lblMagnetometer.textColor = textColor;

    
    // Register for touch event callbacks
    self.instrumentView.delegate = self;

    self.motion = [[VWWMotionMonitor alloc]init];
    self.motion.delegate = self;
    
    // share settings with instrument view
    self.instrumentView.settings = self.settings;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
 
    [self.motion release];

    [_lblAccelerometer release];
    [_lblGyros release];
    [_lblMagnetometer release];
    [_lblInfo release];
    [super dealloc];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // A segue is about to be performed. This is our chance to send data to the
    // view controller that will be loaded.
	if ([segue.identifier isEqualToString:@"segue_VWWThereminSettingsViewController"])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminSettingsViewController* viewController = [[navigationController viewControllers]objectAtIndex:0];
		viewController.delegate = self;
        viewController.settings = self.settings;
        viewController.motion = self.motion;
	}
    else if ([segue.identifier isEqualToString:@"segue_VWWThereminHelpViewController"]){
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminHelpViewController* viewController = [[navigationController viewControllers]objectAtIndex:0];
		viewController.delegate = self;
    }
}

#pragma mark - Implements VWWThereminInstrumentViewDelegate
//-(void)touchBegan{
//    [self.settings start];
//}
//
//-(void)touchEnded{
//    [self.settings stop];
//}

#pragma mark - Implements VWWThereminSettingsViewControllerDelegate
-(void)userIsDoneWithSettings{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userIsCancelledSettings{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userSetAccelerometerInput:(bool)enabled{
    self.lblAccelerometer.hidden = !enabled;
}
-(void)userSetMagnetometerInput:(bool)enabled{
    self.lblMagnetometer.hidden = !enabled;
}
-(void)userSetGyroInput:(bool)enabled{
     self.lblGyros.hidden = !enabled;
}
-(void)userSetTouchInput:(bool)enabled{
    // TODO: implement touch blocking?
}

#pragma mark - Implements VWWThereminHelpViewControllerDelegate
-(void)userIsDoneWithHelp{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWMotionMonitor
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
    self.settings.accelerometerValue = device.x.currentNormalized;
    self.lblAccelerometer.text = [NSString stringWithFormat:@"Accelerometer\n"
                                  "(min, current, max):\n"
                                  "X; %f < %f < %f\n"
                                  "Y; %f < %f < %f\n"
                                  "Z; %f < %f < %f\n",
                                  device.x.min,
                                  device.x.current,
                                  device.x.max,
                                  device.y.min,
                                  device.y.current,
                                  device.y.max,
                                  device.z.min,
                                  device.z.current,
                                  device.z.max];
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
    self.settings.magnetometerValue = device.x.currentNormalized;
    self.lblMagnetometer.text = [NSString stringWithFormat:@"Magnetometer\n"
                                 "(min, current, max):\n"
                                 "X; %f < %f < %f\n"
                                 "Y; %f < %f < %f\n"
                                 "Z; %f < %f < %f\n",
                                 device.x.min,
                                 device.x.current,
                                 device.x.max,
                                 device.y.min,
                                 device.y.current,
                                 device.y.max,
                                 device.z.min,
                                 device.z.current,
                                 device.z.max];

}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
    self.settings.gyroValue = device.x.currentNormalized;
    self.lblGyros.text = [NSString stringWithFormat:@"Gyro\n"
                          "(min, current, max):\n"
                          "X; %f < %f < %f\n"
                          "Y; %f < %f < %f\n"
                          "Z; %f < %f < %f\n",
                          device.x.min,
                          device.x.current,
                          device.x.max,
                          device.y.min,
                          device.y.current,
                          device.y.max,
                          device.z.min,
                          device.z.current,
                          device.z.max];

}


#pragma mark - Custom methods

-(void)initializeClass{
    // settings is a controller for the synthesizer.
    // We will use this single pointer throughout the app.
    // Occasionally shared with other controllers
    self.settings = [[VWWThereminSynthesizerSettings alloc]init];
}

- (IBAction)handle_butSettings:(id)sender{
    [self performSegueWithIdentifier:@"segue_VWWThereminSettingsViewController" sender:self];
}
- (IBAction)handle_butHelp:(id)sender{
    [self performSegueWithIdentifier:@"segue_VWWThereminHelpViewController" sender:self];
    
}

#pragma  mark - Implements VWWThereminInstrumentViewDelegate
-(void)VWWThereminInstrumentView:(VWWThereminInstrumentView*)sender touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.lblInfo.hidden = YES;
}

@end














