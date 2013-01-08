//
//  VWWThereminInput.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInput.h"

// Keys for read/writing hash sets
static NSString* kKeyAccelerometer = @"accelerometer";
static NSString* kKeyGyroscope = @"gyroscope";
static NSString* kKeyMagnetometer = @"magnetometer";
static NSString* kKeyTouchScreen = @"touchscreen";
static NSString* kKeyNone = @"none";
static NSString* kKeyType = @"type";
static NSString* kKeyX = @"x";
static NSString* kKeyY = @"y";
static NSString* kKeyZ = @"z";

@interface VWWThereminInput ()

@end

@implementation VWWThereminInput

-(id)initWithType:(InputType)type{
    self = [super init];
    if(self){
        _inputType = type;
        [self enableTouchScreenByDefault];
        _x = [[VWWThereminInputAxis alloc]init];
        _y = [[VWWThereminInputAxis alloc]init];
        _z = [[VWWThereminInputAxis alloc]init];
        
//        // We will give our touch channels amplitude of 1, but leave others at 0 so they don't annoy
//        if(_inputType == kInputTouch){
//            self.x.amplitude = 1.0;
//            self.y.amplitude = 1.0;
//            //self.z.amplitude = 1.0;  // no z axis for touch
//        }
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        if(dictionary){
            NSString* type = [dictionary objectForKey:kKeyType];
            _inputType = [self inputTypeFromString:type];
            [self enableTouchScreenByDefault];
            NSDictionary* xDict = [dictionary objectForKey:kKeyX];
            _x = [[VWWThereminInputAxis alloc]initWithDictionary:xDict];
            NSDictionary* yDict = [dictionary objectForKey:kKeyY];
            _y = [[VWWThereminInputAxis alloc]initWithDictionary:yDict];
            NSDictionary* zDict = [dictionary objectForKey:kKeyZ];
            _z = [[VWWThereminInputAxis alloc]initWithDictionary:zDict];
        }
        else{
            // Defaults
            _inputType = VWW_INPUT_TYPE;
            [self enableTouchScreenByDefault];
            _x = [[VWWThereminInputAxis alloc]init];
            _y = [[VWWThereminInputAxis alloc]init];
            _z = [[VWWThereminInputAxis alloc]init];
            
//            // We will give our touch channels amplitude of 1, but leave others at 0 so they don't annoy
//            if(_inputType == kInputTouch){
//                self.x.amplitude = 1.0;
//                self.y.amplitude = 1.0;
//                //self.z.amplitude = 1.0;  // no z axis for touch
//            }
        }
    }
    return self;
}

-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:self.x.jsonRepresentation forKey:kKeyX];
    [jsonDict setValue:self.y.jsonRepresentation forKey:kKeyY];
    [jsonDict setValue:self.z.jsonRepresentation forKey:kKeyZ];
    [jsonDict setValue:[self stringForInputType] forKey:kKeyType];
    return jsonDict;
}

-(void)enableTouchScreenByDefault{
    if(_inputType == kInputTouch){
        _enabled = YES;
    }
    else{
        _enabled = NO;
    }
}

-(NSString*)stringForInputType{
    switch (self.inputType) {
        case kInputAccelerometer:
            return kKeyAccelerometer;
        case kInputGyros:
            return kKeyGyroscope;
        case kInputMagnetometer:
            return kKeyMagnetometer;
        case kInputTouch:
            return kKeyTouchScreen;
        case kInputNone:
        default:
            return kKeyNone;
    }
}

-(InputType)inputTypeFromString:(NSString*)typeString{
    if([typeString isEqualToString:kKeyAccelerometer]){
        return kInputAccelerometer;
    }
    else if([typeString isEqualToString:kKeyGyroscope]){
        return kInputGyros;
    }
    else if([typeString isEqualToString:kKeyMagnetometer]){
        return kInputMagnetometer;
    }
    else if([typeString isEqualToString:kKeyTouchScreen]){
        return kInputTouch;
    }
    else /* if([typeString isEqualToString:kKeyNone]) */ {
        return kInputNone;
    }
}

-(NSString*)description{
    return [self stringForInputType];
}


-(void)setEnabled:(bool)newEnabled{
    if(_enabled == newEnabled) return;

    _enabled = newEnabled;
    if(_enabled){
        _x.amplitude = 1.0;
        _y.amplitude = 1.0;
        _z.amplitude = 1.0;
    }
    else{
        _x.amplitude = 0.0;
        _y.amplitude = 0.0;
        _z.amplitude = 0.0;
    }
}

@end
