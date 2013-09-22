//
//  VWWSettingsEffectTableViewCell.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWSettingsKeys.h"
#import "VWWThereminInputAxis.h"


@interface VWWSettingsEffectTableViewCell : UITableViewCell
@property (nonatomic, strong) VWWThereminInputAxis *input;
-(void)setCompletionBlock:(VWWThereminEffectBlock)completion;
@end
