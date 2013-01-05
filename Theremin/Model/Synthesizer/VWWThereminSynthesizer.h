//
//  VWWThereminSynthesizer.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See boilerplate code example here:
//  http://timbolstad.com/2010/03/14/core-audio-getting-started/
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "VWWThereminSynthesizerSettings.h"
#include "CAStreamBasicDescription.h"





@interface VWWThereminSynthesizer : NSObject

@property float volume;
@property float frequency;
@property WaveType waveType;
@property EffectType effectType;

@property double sinPhase;
@property double theta;


-(id)initWithVolume:(float)volume andFrequency:(float)frequency;

- (void)start;
- (void)stop;


@end
