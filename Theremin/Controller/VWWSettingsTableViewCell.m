//
//  VWWSettingsTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsTableViewCell.h"


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
- (IBAction)enabledSwitchValueChanged:(id)sender {
    [self.delegate settingsTableViewCellEnableSwitchValueChanged:self];
}


#pragma mark Public methods
-(void)setKey:(NSString *)key{
    _key = key;
    
    self.inputLabel.text = self.key;
    
    
    if([self.key isEqualToString:kTouchScreenKey]){
        self.enabledSwitch.enabled = NO;
    }
    else{
        
    }
    
}

@end
