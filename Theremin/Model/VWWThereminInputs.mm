//
//  VWWThereminInputs.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputs.h"
#import "VWWFileSystem.h"

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
        [self initializeClass];
    }
    return self;
}

-(NSString*)jsonRepresentation{
    NSArray* inputs = [NSArray arrayWithObjects:_touchInput.jsonRepresentation,
              _accelerometerInput.jsonRepresentation,
              _gyroscopeInput.jsonRepresentation,
              _magnetometerInput.jsonRepresentation,
              nil];
    
    NSError* error = nil;
    NSData* outData = [NSJSONSerialization dataWithJSONObject:inputs options:NSJSONReadingMutableContainers error:&error];
    NSString* outDataString = [[NSString alloc]initWithBytes:[outData bytes] length:outData.length encoding:NSUTF8StringEncoding];
    return outDataString;
}

-(void)dealloc{

    [super dealloc];
}

-(void)saveFile{
    NSString* fileString = self.jsonRepresentation;
//    NSLog(@"%@", fileString);
    if([VWWFileSystem writeFile:fileString] == NO){
        NSLog(@"Error writing config file");
    }
}

// Read from file and populate data structures
-(void)loadFile{
    NSString* contents = [VWWFileSystem readFile];
    if(contents == nil){
        return;
    }
    
    
}

-(void)initializeClass{
    
    _touchInput = [[VWWThereminInput alloc]initWithType:kInputTouch];
    _accelerometerInput = [[VWWThereminInput alloc]initWithType:kInputAccelerometer];
    _gyroscopeInput = [[VWWThereminInput alloc]initWithType:kInputGyros];
    _magnetometerInput = [[VWWThereminInput alloc]initWithType:kInputMagnetometer];
    
    [self loadFile];
}



@end
