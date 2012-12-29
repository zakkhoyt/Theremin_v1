//
//  VWWThereminConfigSensor.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWLine.h"

typedef enum{
    kVWWSensorTypeNone = 0,
    kVWWSensorTypeAccelerometer,
    kVWWSensorTypeGyro,
    kVWWSensorTypeMagnetometer,
    kVWWSensorTypeTouch,
} VWWSensorType;

@class VWWThereminConfigSensor;

@protocol VWWThereminConfigSensorDelegate <NSObject>
-(void)vwwThereminConfigSensorUserIsDone:(VWWThereminConfigSensor *)sender;
-(void)vwwThereminConfigSensorUserDidCancel:(VWWThereminConfigSensor*)sender;
@end

@interface VWWThereminConfigSensor : UIViewController
@property (nonatomic) VWWSensorType sensorType;
@property (nonatomic, retain) VWWLine* axisFrequenciesX;
@property (nonatomic, retain) VWWLine* axisFrequenciesY;
@property (nonatomic, retain) VWWLine* axisFrequenciesZ;
@property (nonatomic, assign) id <VWWThereminConfigSensorDelegate> delegate;
@end
