//
//  VWWSettingsTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsTableViewCell.h"
#import "VWWSettingsKeys.h"
#import "VWWThereminInputs.h"

@interface VWWSettingsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UISwitch *enabledSwitch;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@end


@implementation VWWSettingsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark IBActions
- (IBAction)settingsButtonTouchUpInside:(id)sender {
    [self.delegate settingsTableViewCellSettingsButtonTouchUpInside:self];
}
- (IBAction)enabledSwitchValueChanged:(UISwitch*)sender {
    //[self.delegate settingsTableViewCellEnableSwitchValueChanged:self];
    
    if([self.key isEqualToString:kTouchScreenKey]){
        VWWThereminInput* input = [VWWThereminInputs touchscreenInput];
        input.muted = !sender.on;
    }
    else if([self.key isEqualToString:kAccelerometerKey]){
        VWWThereminInput* input = [VWWThereminInputs accelerometerInput];
        input.muted = !sender.on;
    }
    else if([self.key isEqualToString:kGyroscopesKey]){
        VWWThereminInput* input = [VWWThereminInputs gyroscopeInput];
        input.muted = !sender.on;
    }
    else if([self.key isEqualToString:kMagnetometerKey]){
        VWWThereminInput* input = [VWWThereminInputs magnetometerInput];
        input.muted = !sender.on;
    }
}


#pragma mark Public methods
-(void)setKey:(NSString *)key{
    _key = key;
    
    self.inputLabel.text = self.key;
//    
//    if([VWWThereminInputs accelerometerInput].muted == NO)
////        [self.butInputAccelerometer setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    
//    if([VWWThereminInputs gyroscopeInput].muted == NO)
////        [self.butInputGyros setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    
//    if([VWWThereminInputs magnetometerInput].muted == NO)
////        [self.butInputMagnetometer setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    
//    if([VWWThereminInputs touchscreenInput].muted == NO)
////        [self.butInputTouch setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    if([self.key isEqualToString:kTouchScreenKey]){
        self.enabledSwitch.enabled = NO;
        [self.enabledSwitch setOn:YES];
    }
    else if([self.key isEqualToString:kAccelerometerKey]){
        self.enabledSwitch.enabled = YES;
        [self.enabledSwitch setOn:!([VWWThereminInputs accelerometerInput].muted)];
    }
    else if([self.key isEqualToString:kGyroscopesKey]){
        self.enabledSwitch.enabled = YES;
        [self.enabledSwitch setOn:!([VWWThereminInputs gyroscopeInput].muted)];
    }
    else if([self.key isEqualToString:kMagnetometerKey]){
        self.enabledSwitch.enabled = YES;
        [self.enabledSwitch setOn:!([VWWThereminInputs magnetometerInput].muted)];
    }
    
}

@end
