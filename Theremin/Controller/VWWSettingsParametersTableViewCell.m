//
//  VWWSettingsParametersTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsParametersTableViewCell.h"
#import "VWWSettingsKeys.h"

@interface VWWSettingsParametersTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *parameterLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@end

@implementation VWWSettingsParametersTableViewCell

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
    [self.delegate settingsParametersTableViewCellSettingsButtonTouchUpInside:self];
}


#pragma mark Public methods
-(void)setKey:(NSString *)key{
    _key = key;
    self.parameterLabel.text = key;
}

@end
