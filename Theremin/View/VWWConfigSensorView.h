//
//  VWWConfigSensorView.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWAxisFrequencies.h"



@interface VWWConfigSensorView : UIView
-(void)setLineFrequencies:(VWWAxisFrequencies *)line;
-(void)setLineXMax:(VWWAxisFrequencies *)line valid:(bool)valid;
-(void)setLineXMin:(VWWAxisFrequencies *)line valid:(bool)valid;
-(void)setLineYMax:(VWWAxisFrequencies *)line valid:(bool)valid;
-(void)setLineYMin:(VWWAxisFrequencies *)line valid:(bool)valid;
-(void)setLineZMax:(VWWAxisFrequencies *)line valid:(bool)valid;
-(void)setLineZMin:(VWWAxisFrequencies *)line valid:(bool)valid;
@end
