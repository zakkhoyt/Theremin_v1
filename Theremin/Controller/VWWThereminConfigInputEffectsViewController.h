//
//  VWWThereminConfigInputEffectsViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VWWThereminConfigInputEffectsViewController;

@protocol VWWThereminConfigInputEffectsViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputEffectsViewControllerUserIsDone:(VWWThereminConfigInputEffectsViewController*)sender;
@end

@interface VWWThereminConfigInputEffectsViewController : UIViewController
@property (nonatomic, weak) id <VWWThereminConfigInputEffectsViewControllerDelegate> delegate;
@property (nonatomic) InputType inputType;
@end
