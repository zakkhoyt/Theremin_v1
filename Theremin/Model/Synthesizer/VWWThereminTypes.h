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
    kInputTouch,
    kInputAccelerometer,
    kInputGyros,
    kInputMagnetometer,
} InputType;

// Use bitwise so we can apply multiple settings to one channel
typedef enum{
    kEffectNone = 0x00,
    kEffectAutoTune = 0x01,
    kEffectLinearize = 0x02,
    kEffectThrottle = 0x04,
} EffectType;

typedef enum{
    kNoteKeyChromatic = 0,
    kNoteKeyAMinor,
    kNoteKeyAMajor,
    kNoteKeyBMinor,
    kNoteKeyBMajor,
    kNoteKeyCMajor,
    kNoteKeyDMinor,
    kNoteKeyDMajor,
    kNoteKeyEMinor,
    kNoteKeyEMajor,
    kNoteKeyFMajor,
    kNoteKeyGMinor,
    kNoteKeyGMajor,
} NoteKey;

#endif
