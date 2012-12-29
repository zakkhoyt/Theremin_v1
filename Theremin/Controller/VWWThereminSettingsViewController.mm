//
//  VWWThereminSettingsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSettingsViewController.h"
#import "VWWThereminConfigInputFrequencyViewController.h"

static NSString* kSegueSettingsToConfigInputFrequency = @"segueSettingsToConfigInputFrequency";
@interface VWWThereminSettingsViewController () <VWWThereminConfigInputFrequencyViewControllerDelegate>


/// Command buttons
@property (retain, nonatomic) IBOutlet UIButton *butCommandStart;
@property (retain, nonatomic) IBOutlet UIButton *butCommandStop;
@property (retain, nonatomic) IBOutlet UIButton *butCommandRestart;
- (IBAction)handle_butCommandStart:(id)sender;
- (IBAction)handle_butCommandStop:(id)sender;
- (IBAction)handle_butCommandRestart:(id)sender;

// Input buttons
@property (retain, nonatomic) IBOutlet UIButton *butInputMagnetometer;
@property (retain, nonatomic) IBOutlet UIButton *butInputAccelerometer;
@property (retain, nonatomic) IBOutlet UIButton *butInputTouch;
@property (retain, nonatomic) IBOutlet UIButton *butInputGyros;
- (IBAction)handle_butInputMagnetometer:(id)sender;
- (IBAction)handle_butInputAccelerometer:(id)sender;
- (IBAction)handle_butInputTouch:(id)sender;
- (IBAction)handle_butInputGyros:(id)sender;
- (IBAction)handle_butConfigAccelerometer:(id)sender;



//// Input sliders
//@property (retain, nonatomic) IBOutlet UISlider *sldMagnetometer;
//@property (retain, nonatomic) IBOutlet UISlider *sldAccelerometer;
//@property (retain, nonatomic) IBOutlet UISlider *sldGyros;
//@property (retain, nonatomic) IBOutlet UISlider *sldTouch;
//- (IBAction)handle_sldMagnetometer:(id)sender;
//- (IBAction)handle_sldAccelerometer:(id)sender;
//- (IBAction)handle_sldGyros:(id)sender;
//- (IBAction)handle_sldTouch:(id)sender;



// Waveform buttons
@property (retain, nonatomic) IBOutlet UIButton *butWaveformSine;
@property (retain, nonatomic) IBOutlet UIButton *butWaveformSquare;
@property (retain, nonatomic) IBOutlet UIButton *butWaveformTriangle;
@property (retain, nonatomic) IBOutlet UIButton *butWaveformSawtooth;
- (IBAction)handle_butWaveformSine:(id)sender;
- (IBAction)handle_butWaveformSquare:(id)sender;
- (IBAction)handle_butWaveformTriangle:(id)sender;
- (IBAction)handle_butWaveformSawtooth:(id)sender;

// Frequency buttons
@property (retain, nonatomic) IBOutlet UIButton *butFrequencyNext;
@property (retain, nonatomic) IBOutlet UIButton *butFrequencyPrevious;
@property (retain, nonatomic) IBOutlet UIButton *butFrequencyDouble;
@property (retain, nonatomic) IBOutlet UIButton *butFrequencyHalf;
- (IBAction)handle_butFrequencyNext:(id)sender;
- (IBAction)handle_butFrequencyPrevious:(id)sender;
- (IBAction)handle_butFrequencyDouble:(id)sender;
- (IBAction)handle_butFrequencyHalf:(id)sender;


// Effect buttons
@property (retain, nonatomic) IBOutlet UIButton *butEffectAutotune;
@property (retain, nonatomic) IBOutlet UIButton *butEffectNone;
- (IBAction)handle_butEffectAutotune:(id)sender;
- (IBAction)handle_butEffectNone:(id)sender;


// Navigation bar buttons
- (IBAction)handle_butDone:(id)sender;
- (IBAction)handle_butCancel:(id)sender;

// Custom methods
-(void)initializeClass;
@end

@implementation VWWThereminSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeClass];
    }
    return self;
}

- (void)dealloc {
        
    [_butCommandStart release];
    [_butCommandStop release];
    [_butCommandRestart release];
    [_butInputMagnetometer release];
    [_butInputAccelerometer release];
    [_butInputTouch release];
    [_butInputGyros release];
    [_butWaveformSine release];
    [_butWaveformSquare release];
    [_butWaveformTriangle release];
    [_butWaveformSawtooth release];
    [_butFrequencyNext release];
    [_butFrequencyPrevious release];
    [_butFrequencyDouble release];
    [_butFrequencyHalf release];
//    [_sldMagnetometer release];
//    [_sldAccelerometer release];
//    [_sldGyros release];
//    [_sldTouch release];
    [_butEffectAutotune release];
    [_butEffectNone release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)initializeClass{
//    self.sldAccelerometer.minimumValue = 0.1;
//    self.sldAccelerometer.maximumValue = 2.0;
//    self.sldAccelerometer.value = 1.0;
//    
//    self.sldMagnetometer.minimumValue = 0.1;
//    self.sldMagnetometer.maximumValue = 2.0;
//    self.sldMagnetometer.value = 1.0;
//    
//    self.sldGyros.minimumValue = 0.1;
//    self.sldGyros.maximumValue = 2.0;
//    self.sldGyros.value = 1.0;
//    
//    self.sldTouch.minimumValue = 0.1;
//    self.sldTouch.maximumValue = 2.0;
//    self.sldTouch.value = 1.0;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // A segue is about to be performed. This is our chance to send data to the
    // view controller that will be loaded.
	if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputFrequency])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputFrequencyViewController* configSensorController = [[navigationController viewControllers]objectAtIndex:0];
		configSensorController.delegate = self;
//        configSensorController.settings = self.settings;
//        configSensorController.motion = self.motionMonitor;
	}
}



- (IBAction)handle_butDone:(id)sender {
    if(self.delegate){
        [self.delegate userIsDoneWithSettings];
    }
}

- (IBAction)handle_butCancel:(id)sender {
    if(self.delegate){
        [self.delegate userIsCancelledSettings];
    }

}



#pragma mark Handlers for command buttons

- (IBAction)handle_butCommandStart:(id)sender{
    [self.settings start];
}

- (IBAction)handle_butCommandStop:(id)sender{
    [self.settings stop];
}

- (IBAction)handle_butCommandRestart:(id)sender{
    [self.settings restart];
}


#pragma mark Handlers for input buttons
- (IBAction)handle_butInputMagnetometer:(id)sender{
//    UIButton* button = (UIButton*)sender;
    if((self.settings.inputType & kInputMagnetometer) == kInputMagnetometer){
//        UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
//        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion stopMagnetometer];
        [self.settings clearInputType:kInputMagnetometer];
        if(self.delegate) [self.delegate userSetMagnetometerInput:NO];
    }
    else{
//        UIImage * buttonImage = [UIImage imageNamed:@"button_background.png"];
//        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion startMagnetometer];
        [self.settings setInputType:kInputMagnetometer];
        if(self.delegate) [self.delegate userSetMagnetometerInput:YES];
    }
}

- (IBAction)handle_butInputAccelerometer:(id)sender{
    if((self.settings.inputType & kInputAccelerometer) == kInputAccelerometer){
        [self.motion stopAccelerometer];
        [self.settings clearInputType:kInputAccelerometer];
        if(self.delegate) [self.delegate userSetAccelerometerInput:NO];
    }
    else{
        [self.motion startAccelerometer];
        [self.settings setInputType:kInputAccelerometer];
        if(self.delegate) [self.delegate userSetAccelerometerInput:YES];
    }
}

- (IBAction)handle_butInputTouch:(id)sender{
    if((self.settings.inputType & kInputTouch) == kInputTouch){
        // TODO: Stop Touch
        [self.settings clearInputType:kInputTouch];
        if(self.delegate) [self.delegate userSetTouchInput:NO];
    }
    else{
        // TODO: Start Touch
        [self.settings setInputType:kInputTouch];
        if(self.delegate) [self.delegate userSetTouchInput:YES];
    }
}

- (IBAction)handle_butInputGyros:(id)sender{
    if((self.settings.inputType & kInputGyros) == kInputGyros){
        [self.motion stopGyros];
        [self.settings clearInputType:kInputGyros];
        if(self.delegate) [self.delegate userSetGyroInput:NO];
    }
    else{
        [self.motion startGyros];
        [self.settings setInputType:kInputGyros];
        if(self.delegate) [self.delegate userSetGyroInput:YES];
    }
}

- (IBAction)handle_butConfigAccelerometer:(id)sender {
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
}

//#pragma mark Handlers for hardware slider sensitivity
//- (IBAction)handle_sldMagnetometer:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//    [self.settings setMagnetometerSensitivity:slider.value];
//}
//
//- (IBAction)handle_sldAccelerometer:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//    [self.settings setAccelerometerSensitivity:slider.value];
//}
//
//- (IBAction)handle_sldGyros:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//    [self.settings setGyroSensitivity:slider.value];
//}
//
//- (IBAction)handle_sldTouch:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//    [self.settings setTouchSensitivity:slider.value];
//}


#pragma mark Handlers for waveform buttons
- (IBAction)handle_butWaveformSine:(id)sender{
    self.settings.waveType = kWaveSin;
}

- (IBAction)handle_butWaveformSquare:(id)sender{
    self.settings.waveType = kWaveSquare;
}

- (IBAction)handle_butWaveformTriangle:(id)sender{
    self.settings.waveType = kWaveTriangle;
}

- (IBAction)handle_butWaveformSawtooth:(id)sender{
    self.settings.waveType = kWaveSawtooth;
}


#pragma mark Handlers for frequency buttons
- (IBAction)handle_butFrequencyNext:(id)sender {

}

- (IBAction)handle_butFrequencyPrevious:(id)sender {
}

- (IBAction)handle_butFrequencyDouble:(id)sender {
    float f = self.settings.frequency;
    f *= 2;
    self.settings.frequency = f;
}

- (IBAction)handle_butFrequencyHalf:(id)sender {
    float f = self.settings.frequency;
    f /= 2;
    self.settings.frequency = f;
}


#pragma mark Handlers for effect buttons
- (IBAction)handle_butEffectAutotune:(id)sender {
    self.settings.effectType = kEffectAutoTune;
}

- (IBAction)handle_butEffectNone:(id)sender {
    self.settings.effectType = kEffectNone;
}

#pragma mark - Implements VWWThereminConfigInputFrequencyViewControllerDelegate
-(void)VWWThereminConfigInputFrequencyViewControllerUserIsDone:(VWWThereminConfigInputFrequencyViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)VWWThereminConfigInputFrequencyViewControllerUserDidCancel:(VWWThereminConfigInputFrequencyViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
