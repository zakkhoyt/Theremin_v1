//
//  VWWThereminConfigInputSensitivityViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWThereminSynthesizerSettings.h"

@class VWWThereminConfigInputSensitivityViewController;

@protocol VWWThereminConfigInputSensitivityViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputSensitivityViewControllerUserIsDone:(VWWThereminConfigInputSensitivityViewController*)sender;
-(void)vwwThereminConfigInputSensitivityViewControllerUserCancelled:(VWWThereminConfigInputSensitivityViewController*)sender;
@end

@interface VWWThereminConfigInputSensitivityViewController : UIViewController
@property (nonatomic, assign) id <VWWThereminConfigInputSensitivityViewControllerDelegate> delegate;
@property (nonatomic) InputType inputType;
@end
