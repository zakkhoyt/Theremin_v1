//
//  VWWSettingsTableViewCell.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWSettingsKeys.h"



@class VWWSettingsTableViewCell;

@protocol VWWSettingsTableViewCellDelegate <NSObject>
-(void)settingsTableViewCellSettingsButtonTouchUpInside:(VWWSettingsTableViewCell*)sender;
-(void)settingsTableViewCellEnableSwitchValueChanged:(VWWSettingsTableViewCell*)sender;
@end

@interface VWWSettingsTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString* key;
@property (nonatomic, weak) id <VWWSettingsTableViewCellDelegate> delegate;
@end
