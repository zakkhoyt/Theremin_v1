//
//  VWWThereminTypes.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWThereminTypes_h
#define Theremin_VWWThereminTypes_h

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

#endif
