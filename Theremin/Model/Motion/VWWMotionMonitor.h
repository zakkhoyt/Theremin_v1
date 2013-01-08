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

@class VWWMotionMonitor;

@protocol VWWMotionMonitorDelegate <NSObject>
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device;
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device;
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device;
@end

@interface VWWMotionMonitor : NSObject
@property (nonatomic, assign) id <VWWMotionMonitorDelegate> delegate;
-(void)startAccelerometer;
-(void)stopAccelerometer;
-(void)startMagnetometer;
-(void)stopMagnetometer;
-(void)startGyros;
-(void)stopGyros;
-(NSString*)description:(MotionDevice)device;
@end
