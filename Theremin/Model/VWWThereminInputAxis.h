//
//  VWWThereminInputAxis.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "VWWThereminSynthesizerSettings.h"

@interface VWWThereminInputAxis : NSObject
@property (nonatomic) NSUInteger frequencyMax;
@property (nonatomic) NSUInteger frequencyMin;
@property (nonatomic) WaveType waveType;
@property (nonatomic) float sensitivity;
@property (nonatomic) EffectType effectType;
@end
