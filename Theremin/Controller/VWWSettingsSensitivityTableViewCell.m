//
//  VWWSettingsSensitivityTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsSensitivityTableViewCell.h"
#import "VWWThereminInputs.h"

@interface VWWSettingsSensitivityTableViewCell ()
@property (nonatomic, strong) VWWThereminSensitivityBlock completion;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISlider *sensitivitySlider;


@end

@implementation VWWSettingsSensitivityTableViewCell

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
#pragma mark Private methods
-(void)updateControls{
    self.statusLabel.text = [NSString stringWithFormat:@"%f/1.0", self.input.sensitivity];
//    [VWWThereminInputs saveConfigFile];
}

#pragma mark IBActions
- (IBAction)sensitivitySliderValueChanged:(id)sender {
    self.input.sensitivity = self.sensitivitySlider.value;
    [self updateControls];
}

#pragma mark Public methods
-(void)setCompletionBlock:(VWWThereminSensitivityBlock)completion{
    _completion = completion;
}

-(void)setInput:(VWWThereminInputAxis *)input{
    _input = input;
    
    self.sensitivitySlider.maximumValue = 1.0;
    self.sensitivitySlider.minimumValue = 0.0;
    self.sensitivitySlider.value = self.input.sensitivity;
    
    [self updateControls];
}
@end
