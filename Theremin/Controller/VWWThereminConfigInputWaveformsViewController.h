//
//  VWWThereminConfigInputWaveformsViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VWWThereminConfigInputWaveformsViewController;

@protocol VWWThereminConfigInputWaveformsViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputWaveformsViewControllerUserIsDone:(VWWThereminConfigInputWaveformsViewController*)sender;
@end

@interface VWWThereminConfigInputWaveformsViewController : UIViewController
@property (nonatomic, weak) id <VWWThereminConfigInputWaveformsViewControllerDelegate> delegate;
@property (nonatomic) InputType inputType;
@end
