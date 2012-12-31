//
//  VWWThereminInput.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInput.h"


@interface VWWThereminInput ()

@end

@implementation VWWThereminInput

-(id)init{
    self = [super init];
    if(self){
        _inputType = VWW_INPUT_TYPE;
        _x = [[VWWThereminInputAxis alloc]init];
        _y = [[VWWThereminInputAxis alloc]init];
        _z = [[VWWThereminInputAxis alloc]init];
    }
    return self;
}



-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:self.x.jsonRepresentation forKey:@"x"];
    [jsonDict setValue:self.y.jsonRepresentation forKey:@"y"];
    [jsonDict setValue:self.z.jsonRepresentation forKey:@"z"];
    [jsonDict setValue:[self stringForInputType] forKey:@"type"];
    return jsonDict;
//
//    NSError* error = nil;
//    NSData* outData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONReadingMutableContainers error:&error];
//    NSString* outDataString = [[NSString alloc]initWithBytes:[outData bytes] length:outData.length encoding:NSUTF8StringEncoding];
//    //    NSLog(@"%@", outDataString);
//    return outDataString;
}

-(NSString*)stringForInputType{
    switch (self.inputType) {
        case kInputAccelerometer:
            return @"accelerometer";
        case kInputGyros:
            return @"gyroscope";
        case kInputMagnetometer:
            return @"magnetometer";
        case kInputTouch:
            return @"touchscreen";
        case kInputNone:
        default:
            return @"none";
    }
}


-(void)loadDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults string]
//    [defaults setObject:firstName forKey:@"firstName"];
//    [defaults setObject:lastName forKey:@"lastname"];
//    [defaults setInteger:age forKey:@"age"];
//    [defaults setObject:imageData forKey:@"image"];
    [defaults synchronize];
}

-(void)saveDefaults{
    
}




@end
