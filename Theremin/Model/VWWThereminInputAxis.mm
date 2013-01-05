//
//  VWWThereminInputAxis.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputAxis.h"
#import "VWWThereminSynthesizer.h"

// Keys for read/writing hash sets
static NSString* kKeyFMax = @"fmax";
static NSString* kKeyFMin = @"fmin";
static NSString* kKeyEffect = @"effect";
static NSString* kKeySensitivity = @"sensitivity";
static NSString* kKeyWaveType = @"wavetype";
static NSString* kKeySin = @"sin";
static NSString* kKeySquare = @"square";
static NSString* kKeyTriangle = @"triangle";
static NSString* kKeySawtooth = @"sawtooth";
static NSString* kKeyAutotune = @"autotune";
static NSString* kKeyLinearize = @"linearize";
static NSString* kKeyThrottle = @"throttle";
static NSString* kKeyNone = @"none";


@interface VWWThereminInputAxis ()
@property (nonatomic, retain) VWWThereminSynthesizer* synthesizer; 
@end

@implementation VWWThereminInputAxis
-(id)init{
    self = [super init];
    if(self){
        _frequencyMax = VWW_INPUT_FREQUENCY_MAX;
        _frequencyMin = VWW_INPUT_FREQUENCY_MIN;
        _waveType = VWW_WAVETYPE;
        _sensitivity = VWW_SENSITIVITY;
        _effectType = VWW_EFFECT;
        
        _frequency = _frequencyMax;
        _volume = 0.0;
        _synthesizer = [[VWWThereminSynthesizer alloc]initWithVolume:_volume andFrequency:_frequency];
        _synthesizer.waveType = _waveType;
        _synthesizer.effectType = _effectType;
        [_synthesizer start];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
        if(dictionary){
            NSNumber* fMaxNumber = [dictionary objectForKey:kKeyFMax];
            _frequencyMax = fMaxNumber.floatValue;
            NSNumber* fMinNumber = [dictionary objectForKey:kKeyFMin];
            _frequencyMin = fMinNumber.floatValue;
            NSString* effectString = [dictionary objectForKey:kKeyEffect];
            _effectType = [self effectFromString:effectString];
            NSNumber* sensitivityNumber = [dictionary objectForKey:kKeySensitivity];
            _sensitivity = sensitivityNumber.floatValue;
            NSString* wavetypeString = [dictionary objectForKey:kKeyWaveType];
            _waveType = [self  waveformFromString:wavetypeString];
        }
        else{
            _frequencyMax = VWW_INPUT_FREQUENCY_MAX;
            _frequencyMin = VWW_INPUT_FREQUENCY_MIN;
            _waveType = VWW_WAVETYPE;
            _sensitivity = VWW_SENSITIVITY;
            _effectType = VWW_EFFECT;
        }
    
        _frequency = _frequencyMax;
        _volume = 0.0;
        _synthesizer = [[VWWThereminSynthesizer alloc]initWithVolume:_volume andFrequency:_frequency];
        _synthesizer.waveType = _waveType;
        _synthesizer.effectType = _effectType;
        [_synthesizer start];
    }
    return self;
}

-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:@(self.frequencyMax) forKey:kKeyFMax];
    [jsonDict setValue:@(self.frequencyMin) forKey:kKeyFMin];
    [jsonDict setValue:[self stringForEffect] forKey:kKeyEffect];
    [jsonDict setValue:@(self.sensitivity) forKey:kKeySensitivity];
    [jsonDict setValue:[self stringForWaveform] forKey:kKeyWaveType];
    return jsonDict;
}

-(NSString*)stringForWaveform{
    switch (self.waveType) {
        case kWaveSin:
            return kKeySin;
        case kWaveSquare:
            return kKeySquare;
        case kWaveTriangle:
            return kKeyTriangle;
        case kWaveSawtooth:
            return kKeySawtooth;
        case kWaveNone:
        default:
            return kKeyNone;
    }
}

-(WaveType)waveformFromString:(NSString*)waveString{
    if([waveString isEqualToString:kKeySin]){
        return kWaveSin;
    }
    else if([waveString isEqualToString:kKeySquare]){
        return kWaveSquare;
    }
    else if([waveString isEqualToString:kKeyTriangle]){
        return kWaveTriangle;
    }
    else if([waveString isEqualToString:kKeySawtooth]){
        return kWaveSawtooth;
    }
    else /* if([waveString isEqualToString:kKeyNone]) */ {
        return kWaveNone;
    }
}

-(NSString*)stringForEffect{
    switch(self.effectType){
        case kEffectAutoTune:
            return kKeyAutotune;
        case kEffectLinearize:
            return kKeyLinearize;
        case kEffectThrottle:
            return kKeyThrottle;
        case kEffectNone:
        default:
            return kKeyNone;
    }
}
-(EffectType)effectFromString:(NSString*)effectString{
    if([effectString isEqualToString:kKeyAutotune]){
        return kEffectAutoTune;
    }
    else if([effectString isEqualToString:kKeyLinearize]){
        return kEffectLinearize;
    }
    else if([effectString isEqualToString:kKeyThrottle]){
        return kEffectThrottle;
    }
    else /* if([effectString isEqualToString:kKeyNone]) */ {
        return kEffectNone;
    }
}


-(void)setFrequency:(float)newFrequency{
    _frequency = newFrequency;
    self.synthesizer.frequency = _frequency;
}


-(void)setVolume:(float)newVolume{
    _volume = newVolume;
    self.synthesizer.volume = _volume;
}

-(void)setEffectType:(EffectType)newEffectType{
    _effectType = newEffectType;
    self.synthesizer.effectType = _effectType;
}

-(void)setWaveType:(WaveType)newWaveType{
    _waveType = newWaveType;
    self.synthesizer.waveType = _waveType;
}
@end
