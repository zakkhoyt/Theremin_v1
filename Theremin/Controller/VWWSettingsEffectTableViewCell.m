//
//  VWWSettingsEffectTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsEffectTableViewCell.h"
#import "VWWThereminTypes.h"
#import "VWWThereminInputs.h"


@interface VWWSettingsEffectTableViewCell ()
@property (nonatomic, strong) VWWThereminEffectBlock completion;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *sineButton;
@property (weak, nonatomic) IBOutlet UIButton *squareButton;
@property (weak, nonatomic) IBOutlet UIButton *triangleButton;
@property (weak, nonatomic) IBOutlet UIButton *sawtoothButton;

@end

@implementation VWWSettingsEffectTableViewCell

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
//    [self.sineButton setSelected:NO];
//    [self.squareButton setSelected:NO];
//    [self.triangleButton setSelected:NO];
//    [self.sawtoothButton setSelected:NO];
    
    self.sineButton.alpha = 1.0;
    self.squareButton.alpha = 1.0;
    self.triangleButton.alpha = 1.0;
    self.sawtoothButton.alpha = 1.0;
    
    if(self.input.waveType == kWaveSin){
//        [self.sineButton setSelected:YES];
        self.sineButton.alpha = 0.5;
        self.statusLabel.text = @"Sine";
    }
    else if(self.input.waveType == kWaveSquare){
//        [self.squareButton setSelected:YES];
        self.squareButton.alpha = 0.5;
        self.statusLabel.text = @"Square";
    }
    else if(self.input.waveType == kWaveTriangle){
//        [self.triangleButton setSelected:YES];
        self.triangleButton.alpha = 0.5;
        self.statusLabel.text = @"Triangle";
    }
    else if(self.input.waveType == kWaveSawtooth){
//        [self.sawtoothButton setSelected:YES];
        self.sawtoothButton.alpha = 0.5;
        self.statusLabel.text = @"Sawtooth";
    }
//    [VWWThereminInputs saveConfigFile];

}

#pragma mark IBActions
- (IBAction)sineButtonTouchUpInside:(id)sender {
    self.input.waveType = kWaveSin;
    [self updateControls];
}

- (IBAction)squareButtonTouchUpInside:(id)sender {
    self.input.waveType = kWaveSquare;
    [self updateControls];
}

- (IBAction)triangleButtonTouchUpInside:(id)sender {
    self.input.waveType = kWaveTriangle;
    [self updateControls];
}

- (IBAction)sawtoothButtonTouchUpInside:(id)sender {
    self.input.waveType = kWaveSawtooth;
    [self updateControls];
}

#pragma mark Public methods
-(void)setCompletionBlock:(VWWThereminEffectBlock)completion{
    _completion = completion;
}

-(void)setInput:(VWWThereminInputAxis *)input{
    _input = input;
    
    [self updateControls];
}
@end
