//
//  VWWThereminSynthesizerSettings.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//



typedef enum{
    kWaveNone = 0x00,
    kWaveSin = 0x01,
    kWaveSquare = 0x02,
    kWaveTriangle = 0x04,
    kWaveSawtooth = 0x08,
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
    kEffectType2 = 0x02,
    kEffectType3 = 0x04,
    kEffectType4 = 0x08,
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

// Actions
-(void)restart;
-(void)start;
-(void)stop;


// Setter/getters
//-(float)volume;
//-(void)setVolume:(float)newVolume;
//
//-(float)frequency;
//-(void)setFrequency:(float)newFrequency;
//

-(WaveType)waveType;
-(void)setWaveType:(WaveType)newWaveType;

-(u_int32_t)inputType;
-(void)setInputType:(InputType)newInputType;
-(void)clearInputType:(InputType)newInputType;



//-(EffectType)effectType;
//-(void)setEffectType:(EffectType)newEffect;


//-(void)setTouchValue:(float)newTouchValue;
//-(float)touchValue;

//-(float)touchValue;
//-(void)setTouchValue:(float)newValue;
//-(float)accelerometerValue;
//-(void)setAccelerometerValue:(float)newValue;
//-(float)magnetometerValue;
//-(void)setMagnetometerhValue:(float)newValue;
//-(float)gyroValue;
//-(void)setGyroValue:(float)newValue;

@end
