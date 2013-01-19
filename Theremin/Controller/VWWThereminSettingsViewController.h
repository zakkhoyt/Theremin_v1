//
//  VWWThereminSettingsViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VWWMotionMonitor.h"

@protocol VWWThereminSettingsViewControllerDelegate <NSObject>
-(void)userIsDoneWithSettings;
-(void)userIsCancelledSettings;

-(void)userSetAccelerometerInput:(bool)enabled;
-(void)userSetMagnetometerInput:(bool)enabled;
-(void)userSetGyroInput:(bool)enabled;

@end

@interface VWWThereminSettingsViewController : UIViewController
@property (nonatomic, weak) id <VWWThereminSettingsViewControllerDelegate> delegate;
@property (nonatomic, strong) VWWMotionMonitor* motion;
@end
