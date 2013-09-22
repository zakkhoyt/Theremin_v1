//
//  VWWSettingsAxisTableViewCell.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWSettingsKeys.h"


@class VWWSettingsAxisTableViewCell;

@protocol VWWSettingsAxisTableViewCellDelegate <NSObject>
-(void)settingsAxisTableViewCellSettingsButtonTouchUpInside:(VWWSettingsAxisTableViewCell*)sender;
@end

@interface VWWSettingsAxisTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *key;
@property (nonatomic, weak) id <VWWSettingsAxisTableViewCellDelegate> delegate;

@end
