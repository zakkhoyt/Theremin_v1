//
//  VWWThereminSettingsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
#import <iAd/iAd.h>
#import "VWWThereminSettingsViewController.h"
#import "VWWThereminConfigInputAmplitudeViewController.h"
#import "VWWThereminConfigInputFrequencyViewController.h"
#import "VWWThereminConfigInputWaveformsViewController.h"
#import "VWWThereminConfigInputSensitivityViewController.h"
#import "VWWThereminConfigInputEffectsViewController.h"
#import "VWWThereminConfigInputKeyViewController.h"
#import "VWWThereminInputs.h"

static NSString* kSegueSettingsToConfigInputAmplitude = @"segueSettingsToConfigInputAmplitude";
static NSString* kSegueSettingsToConfigInputFrequency = @"segueSettingsToConfigInputFrequency";
static NSString* kSegueSettingsToConfigInputWaveform = @"segueSettingsToConfigInputWaveform";
static NSString* kSegueSettingsToConfigInputSensitivity = @"segueSettingsToConfigInputSensitivity";
static NSString* kSegueSettingsToConfigInputEffects = @"segueSettingsToConfigInputEffects";
static NSString* kSegueSettingsToConfigInputKey = @"segueSettingsToConfigInputKey";

@interface VWWThereminSettingsViewController () <VWWThereminConfigInputAmplitudeViewControllerDelegate,
VWWThereminConfigInputFrequencyViewControllerDelegate,
VWWThereminConfigInputWaveformsViewControllerDelegate,
VWWThereminConfigInputSensitivityViewControllerDelegate,
VWWThereminConfigInputEffectsViewControllerDelegate,
VWWThereminConfigInputKeyViewControllerDelegate,
ADBannerViewDelegate>


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

@property (nonatomic)bool accelerometerMuteStateForAd;
@property (nonatomic)bool gyroscopeMuteStateForAd;
@property (nonatomic)bool magnetometerMuteStateForAd;
@property (nonatomic)bool touchMuteStateForAd;

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
- (IBAction)configTouchscreenAmplitude:(id)sender;
- (IBAction)configMagnetometerAmplitude:(id)sender;
- (IBAction)configGyroscopeAmplitude:(id)sender;
- (IBAction)configAccelerometerAmplitude:(id)sender;
- (IBAction)configTouchscreenKey:(id)sender;
- (IBAction)configAccelerometerKey:(id)sender;
- (IBAction)configGyroscopeKey:(id)sender;
- (IBAction)configMagnetometerKey:(id)sender;

- (IBAction)resetToDefaultsButtonHandler:(id)sender;

// Navigation bar buttons
- (IBAction)handle_butDone:(id)sender;
- (IBAction)handle_butCancel:(id)sender;




@property (retain, nonatomic) IBOutlet ADBannerView *adBannerView;



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
    [_adBannerView release];
    [super dealloc];
}


//- (void)viewDidAppear:(BOOL)animated{
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
    
    UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
    if([VWWThereminInputs accelerometerInput].muted == NO)
        [self.butInputAccelerometer setBackgroundImage:buttonImage forState:UIControlStateNormal];

    if([VWWThereminInputs gyroscopeInput].muted == NO)
        [self.butInputGyros setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    if([VWWThereminInputs magnetometerInput].muted == NO)
        [self.butInputMagnetometer setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    if([VWWThereminInputs touchscreenInput].muted == NO)
        [self.butInputTouch setBackgroundImage:buttonImage forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.adBannerView setNeedsDisplay];
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
    else if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputAmplitude])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputAmplitudeViewController* configAmplitudeController = [[navigationController viewControllers]objectAtIndex:0];
		configAmplitudeController.delegate = self;
        configAmplitudeController.inputType = self.configInputType;
	}
    else if ([segue.identifier isEqualToString:kSegueSettingsToConfigInputKey])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminConfigInputKeyViewController* configKeyController = [[navigationController viewControllers]objectAtIndex:0];
		configKeyController.delegate = self;
        configKeyController.inputType = self.configInputType;
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
    
}

- (IBAction)handle_butCommandStop:(id)sender{
//    [[VWWThereminInputs accelerometerInput].x. stop];;
}

- (IBAction)handle_butCommandRestart:(id)sender{

}


#pragma mark Handlers for input buttons
- (IBAction)handle_butInputMagnetometer:(id)sender{
    VWWThereminInput* magnetometer = [VWWThereminInputs magnetometerInput];
    UIButton* button = (UIButton*)sender;
    
    if(magnetometer.muted){
        UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion startMagnetometer];
        if(self.delegate) [self.delegate userSetMagnetometerInput:YES];
    }
    else{
        UIImage * buttonImage = [UIImage imageNamed:@"button_background.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion stopMagnetometer];
        if(self.delegate) [self.delegate userSetMagnetometerInput:NO];
    }
    magnetometer.muted = !magnetometer.muted;
}

- (IBAction)handle_butInputAccelerometer:(id)sender{
    VWWThereminInput* accelerometer = [VWWThereminInputs accelerometerInput];
    UIButton* button = (UIButton*)sender;

    if(accelerometer.muted){
        UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion startAccelerometer];
        if(self.delegate) [self.delegate userSetAccelerometerInput:YES];
    }
    else{
        UIImage * buttonImage = [UIImage imageNamed:@"button_background.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion stopAccelerometer];
        if(self.delegate) [self.delegate userSetAccelerometerInput:NO];
    }
    accelerometer.muted = !accelerometer.muted;
}

- (IBAction)handle_butInputTouch:(id)sender{
    VWWThereminInput* touchscreen = [VWWThereminInputs touchscreenInput];
    UIButton* button = (UIButton*)sender;
    
    if(touchscreen.muted){
        UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        //        [self.motion startAccelerometer];
        //        if(self.delegate) [self.delegate userSetAccelerometerInput:YES];
    }
    else{
        UIImage * buttonImage = [UIImage imageNamed:@"button_background.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        //        [self.motion stopAccelerometer];
        //        if(self.delegate) [self.delegate userSetAccelerometerInput:NO];
    }
    touchscreen.muted = !touchscreen.muted;
}

- (IBAction)handle_butInputGyros:(id)sender{
    VWWThereminInput* gyroscope = [VWWThereminInputs gyroscopeInput];
    UIButton* button = (UIButton*)sender;
    
    if(gyroscope.muted){
        UIImage * buttonImage = [UIImage imageNamed:@"button_background_pressed.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion startGyros];
        if(self.delegate) [self.delegate userSetGyroInput:YES];
    }
    else{
        UIImage * buttonImage = [UIImage imageNamed:@"button_background.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.motion stopGyros];
        if(self.delegate) [self.delegate userSetGyroInput:NO];
    }
    gyroscope.muted = !gyroscope.muted;
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


- (IBAction)configTouchscreenAmplitude:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputAmplitude sender:self];
}

- (IBAction)configMagnetometerAmplitude:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputAmplitude sender:self];
}

- (IBAction)configAccelerometerAmplitude:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputAmplitude sender:self];
}

- (IBAction)configGyroscopeAmplitude:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputAmplitude sender:self];
}

- (IBAction)configTouchscreenKey:(id)sender {
    self.configInputType = kInputTouch;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputKey sender:self];
}

- (IBAction)configAccelerometerKey:(id)sender {
    self.configInputType = kInputAccelerometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputKey sender:self];
}

- (IBAction)configGyroscopeKey:(id)sender {
    self.configInputType = kInputGyros;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputKey sender:self];
}

- (IBAction)configMagnetometerKey:(id)sender {
    self.configInputType = kInputMagnetometer;
    [self performSegueWithIdentifier:kSegueSettingsToConfigInputKey sender:self];
}

- (IBAction)resetToDefaultsButtonHandler:(id)sender {
    [VWWThereminInputs resetConfigAndSave];
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

#pragma mark - Implements VWWThereminConfigInputAmplitudeViewControllerDelegate
-(void)vwwThereminConfigInputAmplitudeViewControllerUserIsDone:(VWWThereminConfigInputAmplitudeViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];    
}

#pragma mark - Implements VWWThereminConfigInputKeyViewControllerDelegate
-(void)vwwThereminConfigInputKeyViewControllerUserIsDone:(VWWThereminConfigInputKeyViewController*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"%s", __FUNCTION__);
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
     NSLog(@"%s", __FUNCTION__);
    [UIView animateWithDuration:VWW_DISMISS_INFO_DURATION animations:^{
        self.adBannerView.alpha = 1.0;
    }];
    
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"%s", __FUNCTION__);
    // TODO: a better way to mute all
    [[VWWThereminInputs accelerometerInput].x stop];
    [[VWWThereminInputs accelerometerInput].y stop];
    [[VWWThereminInputs accelerometerInput].z stop];
    
    [[VWWThereminInputs gyroscopeInput].x stop];
    [[VWWThereminInputs gyroscopeInput].y stop];
    [[VWWThereminInputs gyroscopeInput].z stop];
    
    [[VWWThereminInputs magnetometerInput].x stop];
    [[VWWThereminInputs magnetometerInput].y stop];
    [[VWWThereminInputs magnetometerInput].z stop];
    
    [[VWWThereminInputs touchscreenInput].x stop];
    [[VWWThereminInputs touchscreenInput].y stop];
    return YES;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"%s", __FUNCTION__);
    
    // TODO: a better way to mute all
    [[VWWThereminInputs accelerometerInput].x start];
    [[VWWThereminInputs accelerometerInput].y start];
    [[VWWThereminInputs accelerometerInput].z start];
    
    [[VWWThereminInputs gyroscopeInput].x start];
    [[VWWThereminInputs gyroscopeInput].y start];
    [[VWWThereminInputs gyroscopeInput].z start];
    
    [[VWWThereminInputs magnetometerInput].x start];
    [[VWWThereminInputs magnetometerInput].y start];
    [[VWWThereminInputs magnetometerInput].z start];
    
    [[VWWThereminInputs touchscreenInput].x start];
    [[VWWThereminInputs touchscreenInput].y start];

}


- (void)viewDidUnload {
    [self setAdBannerView:nil];
    [super viewDidUnload];
}
@end
