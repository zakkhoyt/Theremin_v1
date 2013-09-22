//
//  VWWSettingsWaveformTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsWaveformTableViewCell.h"
#import "VWWThereminTypes.h"
#import "VWWThereminInputs.h"

@interface VWWSettingsWaveformTableViewCell ()
@property (nonatomic, strong) VWWThereminWaveformBlock completion;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *autotuneButton;

@property (weak, nonatomic) IBOutlet UIButton *noneButton;


@end
@implementation VWWSettingsWaveformTableViewCell

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

    if(self.input.effectType == kEffectNone){
        self.noneButton.alpha = 0.5;
        self.autotuneButton.alpha = 1.0;
        self.statusLabel.text = @"None";
    }
    else if(self.input.effectType == kEffectAutoTune){
        self.noneButton.alpha = 1.0;
        self.autotuneButton.alpha = 0.5;
        self.statusLabel.text = @"Autotune";
    }
//    [VWWThereminInputs saveConfigFile];
}

#pragma mark IBActions

- (IBAction)noneButtonTouchUpInside:(id)sender {
    self.input.effectType = kEffectNone;
    [self updateControls];
}

- (IBAction)autotuneButtonTouchUpInside:(id)sender {
    self.input.effectType = kEffectAutoTune;
    [self updateControls];
}

#pragma mark Public methods
-(void)setCompletionBlock:(VWWThereminWaveformBlock)completion{
    _completion = completion;
}


-(void)setInput:(VWWThereminInputAxis *)input{
    _input = input;
    
    [self updateControls];
}


@end

