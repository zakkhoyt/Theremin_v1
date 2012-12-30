//
//  VWWThereminConfigInputEffectsViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWThereminSynthesizerSettings.h"

@class VWWThereminConfigInputEffectsViewController;

@protocol VWWThereminConfigInputEffectsViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputEffectsViewControllerUserIsDone:(VWWThereminConfigInputEffectsViewController*)sender;
-(void)vwwThereminConfigInputEffectsViewControllerUserCancelled:(VWWThereminConfigInputEffectsViewController*)sender;
@end

@interface VWWThereminConfigInputEffectsViewController : UIViewController
@property (nonatomic, assign) id <VWWThereminConfigInputEffectsViewControllerDelegate> delegate;
@property (nonatomic) InputType inputType;
@end
