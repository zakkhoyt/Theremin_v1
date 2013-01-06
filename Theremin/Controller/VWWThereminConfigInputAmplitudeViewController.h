//
//  VWWThereminConfigInputAmplitudeViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"

@class VWWThereminConfigInputAmplitudeViewController;

@protocol VWWThereminConfigInputAmplitudeViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputAmplitudeViewControllerUserIsDone:(VWWThereminConfigInputAmplitudeViewController*)sender;
@end

@interface VWWThereminConfigInputAmplitudeViewController : UIViewController
@property (nonatomic) InputType inputType;
@property (nonatomic, retain) VWWLine* axisFrequenciesX;
@property (nonatomic, retain) VWWLine* axisFrequenciesY;
@property (nonatomic, retain) VWWLine* axisFrequenciesZ;
@property (nonatomic, assign) id <VWWThereminConfigInputAmplitudeViewControllerDelegate> delegate;
@end
