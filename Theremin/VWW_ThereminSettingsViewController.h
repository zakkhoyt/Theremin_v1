//
//  VWW_ThereminSettingsViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWW_ThereminSynthesizerSettings.h"
#import "VWW_ThereminMotionMonitor.h"

@protocol VWW_ThereminSettingsViewControllerDelegate <NSObject>
-(void)userIsDoneWithSettings;
-(void)userIsCancelledSettings;

-(void)userSetAccelerometerInput:(bool)enabled;
-(void)userSetMagnetometerInput:(bool)enabled;
-(void)userSetGyroInput:(bool)enabled;
-(void)userSetTouchInput:(bool)enabled;

@end

@interface VWW_ThereminSettingsViewController : UIViewController
@property (nonatomic, assign) id <VWW_ThereminSettingsViewControllerDelegate> delegate;
@property (nonatomic, retain) VWW_ThereminSynthesizerSettings* settings;
@property (nonatomic, retain) VWW_ThereminMotionMonitor* motion;
@end
