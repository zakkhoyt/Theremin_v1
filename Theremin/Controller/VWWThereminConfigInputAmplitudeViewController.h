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
@property (nonatomic, strong) VWWLine* axisFrequenciesX;
@property (nonatomic, strong) VWWLine* axisFrequenciesY;
@property (nonatomic, strong) VWWLine* axisFrequenciesZ;
@property (nonatomic, weak) id <VWWThereminConfigInputAmplitudeViewControllerDelegate> delegate;
@end
