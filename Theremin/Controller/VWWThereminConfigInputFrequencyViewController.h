//
//  VWWThereminConfigInputFrequencyViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"
#import "VWWThereminSynthesizerSettings.h"

//typedef enum{
//    kVWWSensorTypeNone = 0,
//    kVWWSensorTypeAccelerometer,
//    kVWWSensorTypeGyro,
//    kVWWSensorTypeMagnetometer,
//    kVWWSensorTypeTouch,
//} VWWSensorType;

@class VWWThereminConfigInputFrequencyViewController;

@protocol VWWThereminConfigInputFrequencyViewControllerDelegate <NSObject>
-(void)VWWThereminConfigInputFrequencyViewControllerUserIsDone:(VWWThereminConfigInputFrequencyViewController *)sender;
-(void)VWWThereminConfigInputFrequencyViewControllerUserDidCancel:(VWWThereminConfigInputFrequencyViewController*)sender;
@end

@interface VWWThereminConfigInputFrequencyViewController : UIViewController
@property (nonatomic) InputType inputType;
@property (nonatomic, retain) VWWLine* axisFrequenciesX;
@property (nonatomic, retain) VWWLine* axisFrequenciesY;
@property (nonatomic, retain) VWWLine* axisFrequenciesZ;
@property (nonatomic, assign) id <VWWThereminConfigInputFrequencyViewControllerDelegate> delegate;
@end
