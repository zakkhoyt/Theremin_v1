//
//  VWWThereminSettingsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSettingsViewController.h"
#import "VWWThereminConfigInputFrequencyViewController.h"
#import "VWWThereminConfigInputWaveformsViewController.h"
#import "VWWThereminConfigInputSensitivityViewController.h"
#import "VWWThereminConfigInputEffectsViewController.h"

static NSString* kSegueSettingsToConfigInputFrequency = @"segueSettingsToConfigInputFrequency";
static NSString* kSegueSettingsToConfigInputWaveform = @"segueSettingsToConfigInputWaveform";
static NSString* kSegueSettingsToConfigInputSensitivity = @"segueSettingsToConfigInputSensitivity";
static NSString* kSegueSettingsToConfigInputEffects = @"segueSettingsToConfigInputEffects";

@interface VWWThereminSettingsViewController () <VWWThereminConfigInputFrequencyViewControllerDelegate,
VWWThereminConfigInputWaveformsViewControllerDelegate,
VWWThereminConfigInputSensitivityViewControllerDelegate,
VWWThereminConfigInputEffectsViewControllerDelegate>


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


@property (nonatomic) InputType configInputType;
- (IBAction)configMagnetometerFrequency:(id)sender;
- (IBAction)configAccelerometerFrequency:(id)sender;
- (IBAction)configGyroscopeFrequency:(id)sender;
- (IBAction)configTouchscreenFrequency:(id)sender;
- (IBAction)configMagnetometerWaveform:(id)sender;
- (IBAction)configAccelerometerWaveform:(id)sender;
- (IBAction)configGyroscopeWaveform:(id)sender;
- (IBAction)configTouchscreenWaveform:(id)sender;
- (IBAction)configMagnetometerSensitivity:(id)sender;
- (IBAction)configAccelerometerSensitivity:(id)sender;
- (IBAction)configGyroscopeSensitivity:(id)sender;
- (IBAction)configTouchscreenSensitivity:(id)sender;
- (IBAction)configMagnetometerEffects:(id)sender;
- (IBAction)configAccelerometerEffects:(id)sender;
- (IBAction)configGyroscopeEffects:(id)sender;
- (IBAction)configTouchscreenEffects:(id)sender;





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
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // A segue is about to be performed. This is our chance to send data to the
    // view controller that will be loaded.
	if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputFrequency])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputFrequencyViewController* configFrequencyController = [[navigationController viewControllers]objectAtIndex:0];
		configFrequencyController.delegate = self;
        configFrequencyController.inputType = self.configInputType;
	}
    else if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputWaveform])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputWaveformsViewController* configWaveformController = [[navigationController viewControllers]objectAtIndex:0];
		configWaveformController.delegate = self;
        configWaveformController.inputType = self.configInputType;
	}
    else if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputSensitivity])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputSensitivityViewController* configSensitivityController = [[navigationController viewControllers]objectAtIndex:0];
		configSensitivityController.delegate = self;
        configSensitivityController.inputType = self.configInputType;
	}
    
    else if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputEffects])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputEffectsViewController* configEffectsController = [[navigationController viewControllers]objectAtIndex:0];
		configEffectsController.delegate = self;
        configEffectsController.inputType = self.configInputType;
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

//- (IBAction)configInputFrequencyButtonHandler:(id)sender {
//    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
//}
//
//- (IBAction)configInputWaveformButtonHandler:(id)sender {
//     [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
//}
//
//- (IBAction)configInputSensitivityButtonHandler:(id)sender {
//     [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
//}



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


#pragma Mark Configuration button handlers
- (IBAction)configMagnetometerFrequency:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
}

- (IBAction)configAccelerometerFrequency:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
}

- (IBAction)configGyroscopeFrequency:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
}

- (IBAction)configTouchscreenFrequency:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
}

- (IBAction)configMagnetometerWaveform:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
}

- (IBAction)configAccelerometerWaveform:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
}

- (IBAction)configGyroscopeWaveform:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
}

- (IBAction)configTouchscreenWaveform:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
}

- (IBAction)configMagnetometerSensitivity:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
}

- (IBAction)configAccelerometerSensitivity:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
}

- (IBAction)configGyroscopeSensitivity:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
}

- (IBAction)configTouchscreenSensitivity:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
}

- (IBAction)configMagnetometerEffects:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputEffects sender:self];
}

- (IBAction)configAccelerometerEffects:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputEffects sender:self];
}

- (IBAction)configGyroscopeEffects:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputEffects sender:self];
}

- (IBAction)configTouchscreenEffects:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputEffects sender:self];
}


#pragma mark - Implements VWWThereminConfigInputFrequencyViewControllerDelegate
-(void)VWWThereminConfigInputFrequencyViewControllerUserIsDone:(VWWThereminConfigInputFrequencyViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)VWWThereminConfigInputFrequencyViewControllerUserDidCancel:(VWWThereminConfigInputFrequencyViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}





#pragma mark - Implements VWWThereminConfigInputSensitivityViewControllerDelegate
-(void)vwwThereminConfigInputSensitivityViewControllerUserIsDone:(VWWThereminConfigInputSensitivityViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputSensitivityViewControllerUserCancelled:(VWWThereminConfigInputSensitivityViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Implements VWWThereminConfigInputWaveformsViewControllerDelegate 
-(void)vwwThereminConfigInputWaveformsViewControllerUserIsDone:(VWWThereminConfigInputWaveformsViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputWaveformsViewControllerUserCancelled:(VWWThereminConfigInputWaveformsViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWThereminConfigInputEffectsViewControllerDelegate
-(void)vwwThereminConfigInputEffectsViewControllerUserIsDone:(VWWThereminConfigInputEffectsViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputEffectsViewControllerUserCancelled:(VWWThereminConfigInputEffectsViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
