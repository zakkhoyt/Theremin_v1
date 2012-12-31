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

    NSLog(@"parsing json...");

    // Example of how to go from json to an array
//    NSString* dataStr = @"[{\"id\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for(NSDictionary *item in jsonArray) {
            NSLog(@"Item: %@", item);
            NSString* typeString = [item valueForKey:@"type"];
            if([typeString isEqualToString:@"touchscreen"]){
                [self populateInput:self.touchInput withJson:item];
            }
        }
    }
}

-(void)populateInput:(VWWThereminInput*)input withDictionary:(NSDictionary*)dict{
//    input.inputType = [dict valueForKey:@"touchscreen"];
}

-(void)initializeClass{
    
    _touchInput = [[VWWThereminInput alloc]initWithType:kInputTouch];
    _accelerometerInput = [[VWWThereminInput alloc]initWithType:kInputAccelerometer];
    _gyroscopeInput = [[VWWThereminInput alloc]initWithType:kInputGyros];
    _magnetometerInput = [[VWWThereminInput alloc]initWithType:kInputMagnetometer];
    
    // If the config file exists, load it. If not, go ahead and write our default values as a file and move on. 
    if([VWWFileSystem configFileExists]){
        [self loadFile];
    }
    else{
        [self saveFile];
    }
}



@end
