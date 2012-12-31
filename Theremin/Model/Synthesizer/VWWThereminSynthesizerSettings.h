//
//  VWWThereminSynthesizerSettings.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//



typedef enum{
    kWaveNone = 0,
    kWaveSin,
    kWaveSquare,
    kWaveTriangle,
    kWaveSawtooth,
} WaveType;

typedef enum{
    kInputNone = 0x00,
    kInputTouch = 0x01,
    kInputAccelerometer = 0x02,
    kInputGyros = 0x04,
    kInputMagnetometer = 0x08,
} InputType;

typedef enum{
    kEffectNone = 0x00,
    kEffectAutoTune = 0x01,
    kEffectLinearize = 0x02,
    kEffectThrottle = 0x04,
} EffectType;


#import <Foundation/Foundation.h>
#import "VWWThereminSynthesizer.h"


@interface VWWThereminSynthesizerSettings : NSObject {
//    float _volume;
//    float _frequency;
    WaveType _waveType;
    u_int32_t _inputType;   // This is a bit set/clear type variable
//    EffectType _effectType;
    
}
@property float volume;
@property float frequency;
//@property WaveType waveType;
@property EffectType effectType;

@property bool running;

@property float frequencyMin;
@property float frequencyMax;
@property float volumeMin;
@property float volumeMax;

@property float touchValue;
@property float accelerometerValue;
@property float magnetometerValue;
@property float gyroValue;

@property float touchSensitivity;
@property float accelerometerSensitivity;
@property float magnetometerSensitivity;
@property float gyroSensitivity;

+(VWWThereminSynthesizerSettings *)sharedInstance;

// Actions
-(void)restart;
-(void)start;
-(void)stop;

-(WaveType)waveType;
-(void)setWaveType:(WaveType)newWaveType;

-(u_int32_t)inputType;
-(void)setInputType:(InputType)newInputType;
-(void)clearInputType:(InputType)newInputType;

@end
