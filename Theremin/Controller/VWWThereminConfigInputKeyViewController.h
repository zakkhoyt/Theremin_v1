//
//  VWWThereminConfigInputKeyViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/6/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VWWThereminConfigInputKeyViewController;

@protocol VWWThereminConfigInputKeyViewControllerDelegate <NSObject>
-(void)vwwThereminConfigInputKeyViewControllerUserIsDone:(VWWThereminConfigInputKeyViewController*)sender;
@end

@interface VWWThereminConfigInputKeyViewController : UIViewController
@property (nonatomic, weak) id <VWWThereminConfigInputKeyViewControllerDelegate> delegate;
@property (nonatomic) InputType inputType;
@end
