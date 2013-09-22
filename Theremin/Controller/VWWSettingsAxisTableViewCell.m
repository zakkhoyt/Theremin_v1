//
//  VWWSettingsAxisTableViewCell.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsAxisTableViewCell.h"
#import "VWWSettingsKeys.h"

@interface VWWSettingsAxisTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *axisLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@end

@implementation VWWSettingsAxisTableViewCell

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
    [self.delegate settingsAxisTableViewCellSettingsButtonTouchUpInside:self];
}

#pragma mark Public methods
-(void)setKey:(NSString *)key{
    _key = key;
    self.axisLabel.text = key;
}

@end
