//
//  VWWThereminInputAxis.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface VWWThereminInputAxis : NSObject
// These values are read/written to config file
@property (nonatomic) float frequencyMax;
@property (nonatomic) float frequencyMin;
@property (nonatomic, setter=setWaveType:) WaveType waveType;
@property (nonatomic) float sensitivity;
@property (nonatomic, setter=setEffectType:) EffectType effectType;

// These values change on the fly
@property (nonatomic, setter=setFrequency:) float frequency;
@property (nonatomic, setter=setVolume:) float volume;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary*)jsonRepresentation;

@end
