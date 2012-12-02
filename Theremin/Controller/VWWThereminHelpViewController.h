//
//  VWWThereminHelpViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VWWThereminHelpViewControllerDelegate  <NSObject>
-(void)userIsDoneWithHelp;
@end

@interface VWWThereminHelpViewController : UIViewController
@property (nonatomic, assign) id <VWWThereminHelpViewControllerDelegate> delegate;
@end
