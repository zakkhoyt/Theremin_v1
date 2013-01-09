//
//  VWWThereminInputAxis.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface VWWThereminInputAxis : NSObject
@property (nonatomic) float amplitude;
@property (nonatomic) float frequencyMax;
@property (nonatomic) float frequencyMin;
@property (nonatomic) WaveType waveType;
@property (nonatomic) float sensitivity;
@property (nonatomic) EffectType effectType;
@property (nonatomic) float frequency;
@property (nonatomic) bool muted;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary*)jsonRepresentation;
-(void)stop;
-(void)start;
@end
