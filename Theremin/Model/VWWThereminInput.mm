//
//  VWWThereminInput.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInput.h"

// Keys for read/writing hash sets
static __attribute ((unused)) NSString* kKeyAccelerometer = @"accelerometer";
static __attribute ((unused)) NSString* kKeyGyroscope = @"gyroscope";
static __attribute ((unused)) NSString* kKeyMagnetometer = @"magnetometer";
static __attribute ((unused)) NSString* kKeyTouchScreen = @"touchscreen";
static __attribute ((unused)) NSString* kKeyNone = @"none";
static __attribute ((unused)) NSString* kKeyType = @"type";
static __attribute ((unused)) NSString* kKeyX = @"x";
static __attribute ((unused)) NSString* kKeyY = @"y";
static __attribute ((unused)) NSString* kKeyZ = @"z";
static __attribute ((unused)) NSString* kKeyMuted = @"muted";

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
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        if(dictionary){
            NSString* type = dictionary[kKeyType];
            _inputType = [self inputTypeFromString:type];
            [self enableTouchScreenByDefault];
            NSDictionary* xDict = dictionary[kKeyX];
            _x = [[VWWThereminInputAxis alloc]initWithDictionary:xDict];
            NSDictionary* yDict = dictionary[kKeyY];
            _y = [[VWWThereminInputAxis alloc]initWithDictionary:yDict];
            NSDictionary* zDict = dictionary[kKeyZ];
            _z = [[VWWThereminInputAxis alloc]initWithDictionary:zDict];
            _muted = dictionary[kKeyMuted];
        }
        else{
            // Defaults
            _inputType = VWW_INPUT_TYPE;
            [self enableTouchScreenByDefault];
            _x = [[VWWThereminInputAxis alloc]init];
            _y = [[VWWThereminInputAxis alloc]init];
            _z = [[VWWThereminInputAxis alloc]init];
            
            // muted
            if(_inputType == kInputTouch){
                _muted = NO;
            }
            else{
                _muted = YES;
            }
            

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
    [jsonDict setValue:self.muted ? @"1" : @"0" forKey:kKeyMuted];
    return jsonDict;
}

-(void)enableTouchScreenByDefault{
    if(_inputType == kInputTouch){
        self.muted = NO;
    }
    else{
        self.muted = YES;
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


-(void)setMuted:(bool)newMuted{
    if(_muted == newMuted) return;

    _muted = newMuted;
    if(_muted){
        _x.muted = YES;
        _y.muted = YES;
        _z.muted = YES;
    }
    else{
        _x.muted = NO;
        _y.muted = NO;
        _z.muted = self.inputType == kInputTouch ? YES : NO; // Mute touch Z always
    }
}

//-(bool)muted{
//    if(_x.muted == NO ||
//        _y.muted == NO ||
//       _z.muted == NO){
//        return NO;
//    }
//    return YES;
//}

@end
