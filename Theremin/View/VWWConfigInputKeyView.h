//
//  VWWConfigInputKeyView.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/6/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"

@interface VWWConfigInputKeyView : UIView
-(void)setLineX:(VWWLine *)line valid:(bool)valid;
-(void)setLineY:(VWWLine *)line valid:(bool)valid;
-(void)setLineZ:(VWWLine *)line valid:(bool)valid;
@end
