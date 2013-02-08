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
static __attribute ((unused)) NSString* kKeyFMax = @"fmax";
static __attribute ((unused)) NSString* kKeyFMin = @"fmin";
static __attribute ((unused)) NSString* kKeyEffect = @"effect";
static __attribute ((unused)) NSString* kKeySensitivity = @"sensitivity";
static __attribute ((unused)) NSString* kKeyWaveType = @"wavetype";
static __attribute ((unused)) NSString* kKeySin = @"sin";
static __attribute ((unused)) NSString* kKeySquare = @"square";
static __attribute ((unused)) NSString* kKeyTriangle = @"triangle";
static __attribute ((unused)) NSString* kKeySawtooth = @"sawtooth";
static __attribute ((unused)) NSString* kKeyAutotune = @"autotune";
static __attribute ((unused)) NSString* kKeyLinearize = @"linearize";
static __attribute ((unused)) NSString* kKeyThrottle = @"throttle";
static __attribute ((unused)) NSString* kKeyAmplitude = @"amplitude";
static __attribute ((unused)) NSString* kKeyMuted = @"muted";
static __attribute ((unused)) NSString* kKeyNone = @"none";


@interface VWWThereminInputAxis ()
@property (nonatomic, strong) VWWThereminSynthesizer* synthesizer; 
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
        _amplitude = VWW_AMPLITUDE;
        _muted = VWW_MUTED;

        _frequency = _frequencyMax;
        _synthesizer = [[VWWThereminSynthesizer alloc]initWithAmplitude:_amplitude andFrequency:_frequency];
        _synthesizer.waveType = _waveType;
        _synthesizer.effectType = _effectType;
        _synthesizer.muted = _muted;
        [_synthesizer start];
    }
    return self;
}

-(void)stop{
    [self.synthesizer stop];
}
-(void)start{
    [self.synthesizer start];
}
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
        if(dictionary){
            NSNumber* fMaxNumber = dictionary[kKeyFMax];
            _frequencyMax = fMaxNumber.floatValue;
            NSNumber* fMinNumber = dictionary[kKeyFMin];
            _frequencyMin = fMinNumber.floatValue;
            NSString* effectString = dictionary[kKeyEffect];
            _effectType = [self effectFromString:effectString];
            NSNumber* sensitivityNumber = dictionary[kKeySensitivity];
            _sensitivity = sensitivityNumber.floatValue;
            NSString* wavetypeString = dictionary[kKeyWaveType];
            _waveType = [self  waveformFromString:wavetypeString];
            NSNumber* amplitudeNumber = dictionary[kKeyAmplitude];
            _amplitude = amplitudeNumber.floatValue;
            NSNumber* mutedNumber = dictionary[kKeyMuted];
            _muted = mutedNumber.floatValue > 0;
        }
        else{
            _frequencyMax = VWW_INPUT_FREQUENCY_MAX;
            _frequencyMin = VWW_INPUT_FREQUENCY_MIN;
            _waveType = VWW_WAVETYPE;
            _sensitivity = VWW_SENSITIVITY;
            _effectType = VWW_EFFECT;
            _amplitude = VWW_AMPLITUDE;
            _muted = VWW_MUTED;
        }
    
        _frequency = _frequencyMax;
        _synthesizer = [[VWWThereminSynthesizer alloc]initWithAmplitude:_amplitude andFrequency:_frequency];
        _synthesizer.waveType = _waveType;
        _synthesizer.effectType = _effectType;
        _synthesizer.muted = _muted;
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
    [jsonDict setValue:@(self.amplitude) forKey:kKeyAmplitude];
    [jsonDict setValue:@(_muted ? 1 : 0) forKey:kKeyMuted];
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


-(void)setAmplitude:(float)newAmplitude{
    _amplitude = newAmplitude;
    self.synthesizer.amplitude = _amplitude;
}

-(void)setEffectType:(EffectType)newEffectType{
    _effectType = newEffectType;
    self.synthesizer.effectType = _effectType;
}

-(void)setWaveType:(WaveType)newWaveType{
    _waveType = newWaveType;
    self.synthesizer.waveType = _waveType;
}

-(void)setMuted:(bool)newMuted{
    _muted = newMuted;
    self.synthesizer.muted = _muted;
}
@end
