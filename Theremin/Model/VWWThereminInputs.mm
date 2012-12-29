//
//  VWWThereminInputs.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputs.h"

@interface VWWThereminInputs ()

@end

@implementation VWWThereminInputs

+(VWWThereminInputs *)sharedInstance{
    static VWWThereminInputs* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWThereminInputs alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        VWWThereminInput* touchInput = [[VWWThereminInput alloc]init];
        VWWThereminInput* accelerometerInput = [[VWWThereminInput alloc]init];
        VWWThereminInput* gyroscopeInput = [[VWWThereminInput alloc]init];
        VWWThereminInput* magnetometerInput = [[VWWThereminInput alloc]init];
        _inputs = [NSArray arrayWithObjects:touchInput,
                   accelerometerInput,
                   gyroscopeInput,
                   magnetometerInput,
                   nil];
    }
    return self;
}

-(void)dealloc{
    [_inputs release];
    [super dealloc];
}
-(void)saveDefaults{
    [self.inputs makeObjectsPerformSelector:@selector(saveDefaults:)];
}
@end
