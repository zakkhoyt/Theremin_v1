//
//  VWWConfigInputFrequencyView.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"

@interface VWWConfigInputFrequencyView : UIView
-(void)setLineFrequencies:(VWWLine *)line;
-(void)setLineXMax:(VWWLine *)line valid:(bool)valid;
-(void)setLineXMin:(VWWLine *)line valid:(bool)valid;
-(void)setLineYMax:(VWWLine *)line valid:(bool)valid;
-(void)setLineYMin:(VWWLine *)line valid:(bool)valid;
-(void)setLineZMax:(VWWLine *)line valid:(bool)valid;
-(void)setLineZMin:(VWWLine *)line valid:(bool)valid;
@end
