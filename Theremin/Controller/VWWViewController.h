//
//  VWWViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWThereminSynthesizerSettings.h"
#import "VWWThereminInstrumentView.h"
#import "VWWThereminSettingsViewController.h"
#import "VWWThereminHelpViewController.h"
#import "VWWMotionMonitor.h"

@interface VWWViewController : UIViewController
    <VWWThereminInstrumentViewDelegate,
    VWWThereminSettingsViewControllerDelegate,
    VWWThereminHelpViewControllerDelegate,
    VWWMotionMonitorDelegate>
@end
