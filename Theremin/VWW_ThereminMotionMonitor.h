//
//  VWW_ThereminMotionMonitor.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct{
    float min;
    float current;
    float currentNormalized;
    float max;
    
} Values;

typedef struct{
    Values x;
    Values y;
    Values z;
} MotionDevice;

typedef struct{
    MotionDevice accelerometer;
    MotionDevice gyro;
    MotionDevice magnetometer;
} Devices;



@protocol VWW_MotionControlDelegate <NSObject>
-(void)accelerometerUpdated:(MotionDevice)device;
-(void)magnetometerUpdated:(MotionDevice)device;
-(void)gyroUpdated:(MotionDevice)device;
@end


@interface VWW_ThereminMotionMonitor : NSObject
@property (nonatomic, assign) id <VWW_MotionControlDelegate> delegate;


-(void)startAccelerometer;
-(void)stopAccelerometer;
-(void)startMagnetometer;
-(void)stopMagnetometer;
-(void)startGyros;
-(void)stopGyros;

@end
