//
//  VWWSettingsParametersTableViewCell.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWSettingsKeys.h"



@class VWWSettingsParametersTableViewCell;

@protocol VWWSettingsParametersTableViewCellDelegate <NSObject>
-(void)settingsParametersTableViewCellSettingsButtonTouchUpInside:(VWWSettingsParametersTableViewCell*)sender;
@end

@interface VWWSettingsParametersTableViewCell : UITableViewCell
@property (nonatomic, weak) id <VWWSettingsParametersTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *key;
@end
