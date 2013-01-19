//
//  VWWThereminAboutViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VWWThereminAboutViewController;

@protocol VWWThereminAboutViewControllerDelegate <NSObject>
-(void)vwwThereminAboutViewControllerUserIsDone:(VWWThereminAboutViewController*)sender;
@end

@interface VWWThereminAboutViewController : UIViewController
@property (nonatomic, weak) id <VWWThereminAboutViewControllerDelegate> delegate;
@end
