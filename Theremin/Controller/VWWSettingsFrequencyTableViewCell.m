//
//  VWWSettingsFrequencyTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsFrequencyTableViewCell.h"
#import "VWWThereminInputs.h"
@interface VWWSettingsFrequencyTableViewCell ()
@property (nonatomic, strong) VWWThereminFrequencyBlock completion;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISlider *frequencyMaxSlider;
@property (weak, nonatomic) IBOutlet UISlider *frequencyMinSlider;
@end

@implementation VWWSettingsFrequencyTableViewCell

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
    self.statusLabel.text = [NSString stringWithFormat:@"min:%d max:%d", (NSInteger)self.input.frequencyMin, (NSInteger)self.input.frequencyMax];
//    [VWWThereminInputs saveConfigFile];
}

#pragma mark IBActions
- (IBAction)frequencyMaxValueChanged:(id)sender {
    self.input.frequencyMax = self.frequencyMaxSlider.value;
    [self updateControls];
}

- (IBAction)frequencyMinValudeChanged:(id)sender {
    self.input.frequencyMin = self.frequencyMinSlider.value;
    [self updateControls];
}

#pragma mark Public methods
-(void)setCompletionBlock:(VWWThereminFrequencyBlock)completion{
    _completion = completion;
}


-(void)setInput:(VWWThereminInputAxis *)input{
    _input = input;
    self.frequencyMaxSlider.maximumValue = VWW_FREQUENCY_MAX;
    self.frequencyMaxSlider.minimumValue = VWW_FREQUENCY_MIN;
    self.frequencyMinSlider.maximumValue = VWW_FREQUENCY_MAX;
    self.frequencyMinSlider.minimumValue = VWW_FREQUENCY_MIN;
    
    self.frequencyMaxSlider.value = self.input.frequencyMax;
    self.frequencyMinSlider.value = self.input.frequencyMin;
    
    [self updateControls];
}


@end
