//
//  VWW_ThereminHelpViewController.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VWW_ThereminHelpViewControllerDelegate  <NSObject>
-(void)userIsDoneWithHelp;
@end

@interface VWW_ThereminHelpViewController : UIViewController
@property (nonatomic, assign) id <VWW_ThereminHelpViewControllerDelegate> delegate;
@end
