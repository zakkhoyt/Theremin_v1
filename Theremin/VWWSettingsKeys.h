//
//  VWWSettingsKeys.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWSettingsKeys_h
#define Theremin_VWWSettingsKeys_h

#import "VWWThereminTypes.h"

typedef void (^VWWThereminFrequencyBlock)(float frequencyMax, float frequencyMin);
typedef void (^VWWThereminAmplitudeBlock)(float amplitude);
typedef void (^VWWThereminSensitivityBlock)(float sensitivity);
typedef void (^VWWThereminWaveformBlock)(WaveType waveType);
typedef void (^VWWThereminEffectBlock)(EffectType effectType);


static NSString* kConfigFileName = @"theremin.cfg";

static NSString *kTouchScreenKey = @"Touch Screen";
static NSString *kAccelerometerKey = @"Accelerometer";
static NSString *kMagnetometerKey = @"Magnetometer";
static NSString *kGyroscopesKey = @"Gyrosscope";
static NSString *kGeneralKey = @"General Settings";


static NSString *kXAxisKey = @"X Axis";
static NSString *kYAxisKey = @"Y Axis";
static NSString *kZAxisKey = @"Z Axis";


static NSString *kFrequencyKey = @"Frequency";
static NSString *kAmplitudeKey = @"Amplitude";
static NSString *kWaveformKey = @"Waveform";
static NSString *kSensitivityKey = @"Sensitivity";
static NSString *kEffectKey = @"Effect";
static NSString *kKeyKey = @"Key";
#endif

