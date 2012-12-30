//
//  VWWConfigInputEffectsView.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"

@interface VWWConfigInputEffectsView : UIView
-(void)setLineX:(VWWLine *)line valid:(bool)valid;
-(void)setLineY:(VWWLine *)line valid:(bool)valid;
-(void)setLineZ:(VWWLine *)line valid:(bool)valid;
@end
