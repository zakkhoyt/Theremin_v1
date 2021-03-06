//
//  VWWThereminInputs.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWThereminInput.h"


// TODO: These are defined elsewhere in the app.
// We really don't want two instances 
static __attribute ((unused)) NSString* kKeyAccelerometer = @"accelerometer";
static __attribute ((unused)) NSString* kKeyGyroscope = @"gyroscope";
static __attribute ((unused)) NSString* kKeyMagnetometer = @"magnetometer";
static __attribute ((unused)) NSString* kKeyTouchScreen = @"touchscreen";

@interface VWWThereminInputs : NSObject
+(VWWThereminInputs *)sharedInstance;
+(VWWThereminInput*)accelerometerInput;
+(VWWThereminInput*)gyroscopeInput;
+(VWWThereminInput*)magnetometerInput;
+(VWWThereminInput*)touchscreenInput;
+(void)resetConfigAndSave;
+(void)saveConfigFile;
@end
