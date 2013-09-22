//
//  VWWSettingsAmplitudeTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsAmplitudeTableViewCell.h"
#import "VWWThereminInputs.h"


@interface  VWWSettingsAmplitudeTableViewCell ()
@property (nonatomic, strong) VWWThereminAmplitudeBlock completion;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UISlider *amplitudeSlider;
@end


@implementation VWWSettingsAmplitudeTableViewCell

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
    self.statusLabel.text = [NSString stringWithFormat:@"%f/1.0", self.input.amplitude];
//    [VWWThereminInputs saveConfigFile];
}

#pragma mark IBActions
- (IBAction)amplitudeSliderValueChanged:(id)sender {
    self.input.amplitude = self.amplitudeSlider.value;
    [self updateControls];
}



#pragma mark Public methods


-(void)setCompletionBlock:(VWWThereminAmplitudeBlock)completion{
    _completion = completion;
}

-(void)setInput:(VWWThereminInputAxis *)input{
    _input = input;
    
    
    self.amplitudeSlider.minimumValue = 0.0;
    self.amplitudeSlider.maximumValue = 1.0;
    
    self.amplitudeSlider.value = self.input.amplitude;
    
    [self updateControls];
}
@end
