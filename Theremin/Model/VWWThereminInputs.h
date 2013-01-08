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
static NSString* kKeyAccelerometer = @"accelerometer";
static NSString* kKeyGyroscope = @"gyroscope";
static NSString* kKeyMagnetometer = @"magnetometer";
static NSString* kKeyTouchScreen = @"touchscreen";

@interface VWWThereminInputs : NSObject
+(VWWThereminInputs *)sharedInstance;
+(VWWThereminInput*)accelerometerInput;
+(VWWThereminInput*)gyroscopeInput;
+(VWWThereminInput*)magnetometerInput;
+(VWWThereminInput*)touchscreenInput;
+(void)resetConfigAndSave;
+(void)saveConfigFile;
@end
