//
//  VWWThereminInputAxis.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputAxis.h"

@implementation VWWThereminInputAxis
-(id)init{
    self = [super init];
    if(self){
        _frequencyMax = VWW_FREQUENCY_MAX;
        _frequencyMin = VWW_FREQUENCY_MIN;
        _waveType = VWW_WAVETYPE;
        _sensitivity = VWW_SENSITIVITY;
        _effectType = VWW_EFFECT;
    }
    return self;
}

-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:@(self.frequencyMax) forKey:@"fmax"];
    [jsonDict setValue:@(self.frequencyMin) forKey:@"fmin"];
    [jsonDict setValue:[self stringForWaveform] forKey:@"wavetype"];
    [jsonDict setValue:@(self.sensitivity) forKey:@"sensitivity"];
    [jsonDict setValue:[self stringForEffect] forKey:@"effect"];
    return jsonDict;
//    NSError* error = nil;
//    NSData* outData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONReadingMutableContainers error:&error];
//    NSString* outDataString = [[NSString alloc]initWithBytes:[outData bytes] length:outData.length encoding:NSUTF8StringEncoding];
////    NSLog(@"%@", outDataString);
//    return outDataString;
}

-(NSString*)stringForWaveform{
    switch (self.waveType) {
        case kWaveSin:
            return @"sin";
        case kWaveSquare:
            return @"square";
        case kWaveTriangle:
            return @"triangle";
        case kWaveSawtooth:
            return @"sawtooth";
        case kWaveNone:
        default:
            return @"none";
    }
}


-(NSString*)stringForEffect{
    switch(self.effectType){
        case kEffectAutoTune:
            return @"autotune";
        case kEffectLinearize:
            return @"linearize";
        case kEffectThrottle:
            return @"throttle";
        case kEffectNone:
        default:
            return @"none";
    }
}
@end
