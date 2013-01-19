//
//  VWWThereminConfigInputFrequencyViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"


@class VWWThereminConfigInputFrequencyViewController;

@protocol VWWThereminConfigInputFrequencyViewControllerDelegate <NSObject>
-(void)VWWThereminConfigInputFrequencyViewControllerUserIsDone:(VWWThereminConfigInputFrequencyViewController *)sender;
@end

@interface VWWThereminConfigInputFrequencyViewController : UIViewController
@property (nonatomic) InputType inputType;
@property (nonatomic, strong) VWWLine* axisFrequenciesX;
@property (nonatomic, strong) VWWLine* axisFrequenciesY;
@property (nonatomic, strong) VWWLine* axisFrequenciesZ;
@property (nonatomic, weak) id <VWWThereminConfigInputFrequencyViewControllerDelegate> delegate;
@end
