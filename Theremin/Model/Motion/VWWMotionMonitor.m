//
//  VWWMotionMonitor.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>
#import "VWWMotionMonitor.h"
#import "VWWThereminInputs.h"

const float kAccelerometerXMax = 2.0;
const float kAccelerometerYMax = 2.0;
const float kAccelerometerZMax = 2.0;

const float kGyroXMax = 20.0;
const float kGyroYMax = 20.0;
const float kGyroZMax = 20.0;

const float kMagnetometerXMax = 80.0f;
const float kMagnetometerYMax = 30.0f;
const float kMagnetometerZMax = 30.0f;


@interface VWWMotionMonitor ()
@property (nonatomic, retain) CMMotionManager* motion;
@property Devices devices;
@property (nonatomic) bool accelerometerRunning;
@property (nonatomic) bool magnetometerRunning;
@property (nonatomic) bool gyrosRunning;
@end

@implementation VWWMotionMonitor

-(id)init{
    self = [super init];
    if(self){
        _accelerometerRunning = NO;
        _magnetometerRunning = NO;
        _gyrosRunning = NO;
        memset(&_devices, 0, sizeof(Devices));
        self.motion = [[CMMotionManager alloc]init];
        
    }
    return self;
}

-(void)dealloc{
    [self.motion release];
    self.motion = nil;
    [super dealloc];
}


-(void)startAccelerometer{
    if(self.accelerometerRunning == YES) return;
    
    self.motion.accelerometerUpdateInterval = 1/30.0f;

    NSOperationQueue* accelerometerQueue = [[NSOperationQueue alloc] init];

    CMAccelerometerHandler accelerometerHandler = ^(CMAccelerometerData *accelerometerData, NSError *error) {

        // X Axis
        // Accelerometer value is currently in the range of
        // (-kAccelerometerXMax .. kAccelerometerXMax)
        // Convert to value in range
        // (0 .. 2*kAccelerometerXMax)
        float value = accelerometerData.acceleration.x + kAccelerometerXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kAccelerometerXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _devices.accelerometer.x.current = accelerometerData.acceleration.x;
        _devices.accelerometer.x.currentNormalized = value;
        
        
        // Y Axis
        value = accelerometerData.acceleration.y + kAccelerometerYMax;
        normalize = (float)2.0*kAccelerometerYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.accelerometer.y.current = accelerometerData.acceleration.y;
        _devices.accelerometer.y.currentNormalized = value;

        // Z Axis
        value = accelerometerData.acceleration.z + kAccelerometerZMax;
        normalize = (float)2.0*kAccelerometerZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.accelerometer.z.current = accelerometerData.acceleration.z;
        _devices.accelerometer.z.currentNormalized = value;

        
        
        // Set device min and max values
        if(accelerometerData.acceleration.x < _devices.accelerometer.x.min){
            _devices.accelerometer.x.min = accelerometerData.acceleration.x;
        }
        if(accelerometerData.acceleration.x > _devices.accelerometer.x.max){
            _devices.accelerometer.x.max = accelerometerData.acceleration.x;
        }
        if(accelerometerData.acceleration.y < _devices.accelerometer.y.min){
            _devices.accelerometer.y.min = accelerometerData.acceleration.y;
        }
        if(accelerometerData.acceleration.y > _devices.accelerometer.y.max){
            _devices.accelerometer.y.max = accelerometerData.acceleration.y;
        }
        if(accelerometerData.acceleration.z < _devices.accelerometer.z.min){
            _devices.accelerometer.z.min = accelerometerData.acceleration.z;
        }
        if(accelerometerData.acceleration.z > _devices.accelerometer.z.max){
            _devices.accelerometer.z.max = accelerometerData.acceleration.z;
        }

        // Send new frequencie to the synth channels
        VWWThereminInput* accelerometer = [VWWThereminInputs accelerometerInput];
        {
            float centerFreq = (accelerometer.x.frequencyMax - accelerometer.x.frequencyMin) / 2.0;
            float maxDrift = accelerometer.x.frequencyMax - centerFreq;
            float driftFactor = _devices.accelerometer.x.currentNormalized * accelerometer.x.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            accelerometer.x.frequency = newFrequency;
//            NSLog(@"X normalized:%f newFreq:%f", _devices.accelerometer.x.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (accelerometer.y.frequencyMax - accelerometer.y.frequencyMin) / 2.0;
            float maxDrift = accelerometer.y.frequencyMax - centerFreq;
            float driftFactor = _devices.accelerometer.y.currentNormalized * accelerometer.y.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            accelerometer.y.frequency = newFrequency;
//            NSLog(@"Y normalized:%f newFreq:%f", _devices.accelerometer.y.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (accelerometer.z.frequencyMax - accelerometer.z.frequencyMin) / 2.0;
            float maxDrift = accelerometer.z.frequencyMax - centerFreq;
            float driftFactor = _devices.accelerometer.z.currentNormalized * accelerometer.z.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            accelerometer.z.frequency = newFrequency;
//            NSLog(@"Z normalized:%f newFreq:%f", _devices.accelerometer.z.currentNormalized, newFrequency);
        }
        
        // Update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self accelerometerUpdated:self.devices.accelerometer];
        });
    };

    [self.motion startAccelerometerUpdatesToQueue:accelerometerQueue withHandler:[[accelerometerHandler copy]autorelease]];
    self.accelerometerRunning = YES;
    NSLog(@"Started Accelerometer");
}
    

-(void)stopAccelerometer{
    if(self.accelerometerRunning == NO) return;
    
    [self.motion stopAccelerometerUpdates];
    memset(&_devices.accelerometer, 0, sizeof(MotionDevice));
    self.accelerometerRunning = NO;
    NSLog(@"Stopped Accelerometer");
}


-(void)startMagnetometer{
    if(self.magnetometerRunning == YES) return;
    
    self.motion.magnetometerUpdateInterval = 1/30.0f;
    
    NSOperationQueue* magnetometerQueue = [[NSOperationQueue alloc] init];
    
    CMMagnetometerHandler magnetometerHandler = ^(CMMagnetometerData *magnetometerData, NSError *error) {
        
        // X Axis
        // Magnetometer value is currently in the range of
        // (-kMagnetometerXMax .. kMagnetometerXMax)
        // Convert to value in range
        // (0 .. 2*kMagnetometerXMax)
        float value = magnetometerData.magneticField.x + kAccelerometerXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kMagnetometerXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _devices.magnetometer.x.current = magnetometerData.magneticField.x;
        _devices.magnetometer.x.currentNormalized = value;
        
        
        // Y Axis
        value = magnetometerData.magneticField.y + kMagnetometerYMax;
        normalize = (float)2.0*kMagnetometerYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.magnetometer.y.current = magnetometerData.magneticField.y;
        _devices.magnetometer.y.currentNormalized = value;
        
        // Z Axis
        value = magnetometerData.magneticField.z + kMagnetometerZMax;
        normalize = (float)2.0*kMagnetometerZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.magnetometer.z.current = magnetometerData.magneticField.z;
        _devices.magnetometer.z.currentNormalized = value;
        
        
        
        // Set device min and max values
        if(magnetometerData.magneticField.x < _devices.magnetometer.x.min){
            _devices.magnetometer.x.min = magnetometerData.magneticField.x;
        }
        if(magnetometerData.magneticField.x > _devices.magnetometer.x.max){
            _devices.magnetometer.x.max = magnetometerData.magneticField.x;
        }
        if(magnetometerData.magneticField.y < _devices.magnetometer.y.min){
            _devices.magnetometer.y.min = magnetometerData.magneticField.y;
        }
        if(magnetometerData.magneticField.y > _devices.magnetometer.y.max){
            _devices.magnetometer.y.max = magnetometerData.magneticField.y;
        }
        if(magnetometerData.magneticField.z < _devices.magnetometer.z.min){
            _devices.magnetometer.z.min = magnetometerData.magneticField.z;
        }
        if(magnetometerData.magneticField.z > _devices.magnetometer.z.max){
            _devices.magnetometer.z.max = magnetometerData.magneticField.z;
        }
        
        // Send new frequencie to the synth channels
        VWWThereminInput* magnetometer = [VWWThereminInputs magnetometerInput];
        {
            float centerFreq = (magnetometer.x.frequencyMax - magnetometer.x.frequencyMin) / 2.0;
            float maxDrift = magnetometer.x.frequencyMax - centerFreq;
            float driftFactor = _devices.magnetometer.x.currentNormalized * magnetometer.x.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            magnetometer.x.frequency = newFrequency;
            NSLog(@"X normalized:%f newFreq:%f", _devices.magnetometer.x.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (magnetometer.y.frequencyMax - magnetometer.y.frequencyMin) / 2.0;
            float maxDrift = magnetometer.y.frequencyMax - centerFreq;
            float driftFactor = _devices.magnetometer.y.currentNormalized * magnetometer.y.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            magnetometer.y.frequency = newFrequency;
            NSLog(@"Y normalized:%f newFreq:%f", _devices.magnetometer.y.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (magnetometer.z.frequencyMax - magnetometer.z.frequencyMin) / 2.0;
            float maxDrift = magnetometer.z.frequencyMax - centerFreq;
            float driftFactor = _devices.magnetometer.z.currentNormalized * magnetometer.z.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            magnetometer.z.frequency = newFrequency;
            NSLog(@"Z normalized:%f newFreq:%f", _devices.magnetometer.z.currentNormalized, newFrequency);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self magnetometerUpdated:self.devices.magnetometer];
        });
    };
    
    [self.motion startMagnetometerUpdatesToQueue:magnetometerQueue withHandler:[[magnetometerHandler copy]autorelease]];
    self.magnetometerRunning = YES;
    NSLog(@"Started Magnetometer");
    
}
-(void)stopMagnetometer{
    if(self.magnetometerRunning == NO) return;
    
    [self.motion stopMagnetometerUpdates];
    memset(&_devices.magnetometer, 0, sizeof(MotionDevice));
    self.magnetometerRunning = NO;
    NSLog(@"Stopped Magnetometer");
}

-(void)startGyros{
    if(self.gyrosRunning == YES) return;
    
    self.motion.gyroUpdateInterval = 1/30.0f;
    
    NSOperationQueue* gyroQueue = [[NSOperationQueue alloc] init];
    
    CMGyroHandler gyroHandler = ^(CMGyroData *gyroData, NSError *error) {
        
        // X Axis
        // Gyro value is currently in the range of
        // (-kGyroXMax .. kGyroXMax)
        // Convert to value in range
        // (0 .. 2*kGyroXMax)
        float value = gyroData.rotationRate.x + kGyroXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kGyroXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _devices.gyro.x.current = gyroData.rotationRate.x;
        _devices.gyro.x.currentNormalized = value;
        
        
        // Y Axis
        value = gyroData.rotationRate.y + kGyroYMax;
        normalize = (float)2.0*kGyroYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.gyro.y.current = gyroData.rotationRate.y;
        _devices.gyro.y.currentNormalized = value;
        
        // Z Axis
        value = gyroData.rotationRate.z + kGyroZMax;
        normalize = (float)2.0*kGyroZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _devices.gyro.z.current = gyroData.rotationRate.z;
        _devices.gyro.z.currentNormalized = value;
        
        
        
        // Set device min and max values
        if(gyroData.rotationRate.x < _devices.gyro.x.min){
            _devices.gyro.x.min = gyroData.rotationRate.x;
        }
        if(gyroData.rotationRate.x > _devices.gyro.x.max){
            _devices.gyro.x.max = gyroData.rotationRate.x;
        }
        if(gyroData.rotationRate.y < _devices.gyro.y.min){
            _devices.gyro.y.min = gyroData.rotationRate.y;
        }
        if(gyroData.rotationRate.y > _devices.gyro.y.max){
            _devices.gyro.y.max = gyroData.rotationRate.y;
        }
        if(gyroData.rotationRate.z < _devices.gyro.z.min){
            _devices.gyro.z.min = gyroData.rotationRate.z;
        }
        if(gyroData.rotationRate.z > _devices.gyro.z.max){
            _devices.gyro.z.max = gyroData.rotationRate.z;
        }
        
        
        // Send new frequencie to the synth channels
        VWWThereminInput* gyroscope = [VWWThereminInputs gyroscopeInput];
        {
            float centerFreq = (gyroscope.x.frequencyMax - gyroscope.x.frequencyMin) / 2.0;
            float maxDrift = gyroscope.x.frequencyMax - centerFreq;
            float driftFactor = _devices.gyro.x.currentNormalized * gyroscope.x.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            gyroscope.x.frequency = newFrequency;
            NSLog(@"X normalized:%f newFreq:%f", _devices.gyro.x.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (gyroscope.y.frequencyMax - gyroscope.y.frequencyMin) / 2.0;
            float maxDrift = gyroscope.y.frequencyMax - centerFreq;
            float driftFactor = _devices.gyro.y.currentNormalized * gyroscope.y.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            gyroscope.y.frequency = newFrequency;
            NSLog(@"Y normalized:%f newFreq:%f", _devices.gyro.y.currentNormalized, newFrequency);
        }
        {
            float centerFreq = (gyroscope.z.frequencyMax - gyroscope.z.frequencyMin) / 2.0;
            float maxDrift = gyroscope.z.frequencyMax - centerFreq;
            float driftFactor = _devices.gyro.z.currentNormalized * gyroscope.z.sensitivity;
            float drift = maxDrift * driftFactor;
            float newFrequency = centerFreq + drift;
            gyroscope.z.frequency = newFrequency;
            NSLog(@"Z normalized:%f newFreq:%f", _devices.gyro.z.currentNormalized, newFrequency);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self gyroUpdated:self.devices.gyro];
        });
    };
    
    [self.motion startGyroUpdatesToQueue:gyroQueue withHandler:[[gyroHandler copy]autorelease]];
    self.gyrosRunning = YES;
    NSLog(@"Started Gyros");

}
-(void)stopGyros{
    if(self.gyrosRunning == NO) return;
    
    [self.motion stopGyroUpdates];
    memset(&_devices.gyro, 0, sizeof(MotionDevice));
    self.gyrosRunning = NO;
    NSLog(@"Stopped Gyros");
}

-(NSString*)description:(MotionDevice)device{
    return [NSString stringWithFormat:@"(min, current, max):\n"
         "X; %f < %f < %f\n"
         "Y; %f < %f < %f\n"
         "Z; %f < %f < %f\n",
         device.x.min,
         device.x.current,
         device.x.max,
         device.y.min,
         device.y.current,
         device.y.max,
         device.z.min,
         device.z.current,
         device.z.max];
}

@end


