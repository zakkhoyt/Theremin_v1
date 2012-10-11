//
//  VWW_ViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWW_ThereminSynthesizerSettings.h"
#import "VWW_ThereminInstrumentView.h"
#import "VWW_ThereminSettingsViewController.h"
#import "VWW_ThereminHelpViewController.h"
#import "VWW_ThereminMotionMonitor.h"

@interface VWW_ViewController : UIViewController
    <VWW_ThereminInstrumentViewDelegate,
    VWW_ThereminSettingsViewControllerDelegate,
    VWW_ThereminHelpViewControllerDelegate,
    VWW_MotionControlDelegate>
@end
