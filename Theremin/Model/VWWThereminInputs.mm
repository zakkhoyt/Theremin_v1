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

-(void)initializeClass{
    _inputs = [[NSMutableDictionary alloc]init];
        
    // Create default set of inputs, then either write them to a file, or overwrite them with the contents of the file.
    VWWThereminInput* touchInput = [[VWWThereminInput alloc]initWithType:kInputTouch];
    VWWThereminInput* accelerometerInput = [[VWWThereminInput alloc]initWithType:kInputAccelerometer];
    VWWThereminInput* gyroscopeInput = [[VWWThereminInput alloc]initWithType:kInputGyros];
    VWWThereminInput* magnetometerInput = [[VWWThereminInput alloc]initWithType:kInputMagnetometer];

    [self.inputs setObject:touchInput forKey:touchInput.description];
    [self.inputs setObject:accelerometerInput forKey:accelerometerInput.description];
    [self.inputs setObject:gyroscopeInput forKey:gyroscopeInput.description];
    [self.inputs setObject:magnetometerInput forKey:magnetometerInput.description];

    [touchInput release];
    [accelerometerInput release];
    [gyroscopeInput release];
    [magnetometerInput release];
    
    // If the config file exists, load it. If not, go ahead and write our default values as a file and move on.
    if([VWWFileSystem configFileExists]){
        [self loadFile];
    }
    else{
        [self saveFile];
    }
}

-(void)dealloc{
    [_inputs release];
    [super dealloc];
}

-(NSString*)jsonRepresentation{
    NSMutableArray* inputs = [[NSMutableArray alloc]init];
    for(NSString* key in [self.inputs allKeys]){
        VWWThereminInput* input = [self.inputs objectForKey:key];
        [inputs addObject:input.jsonRepresentation];
        
    }
    
    NSError* error = nil;
    NSData* outData = [NSJSONSerialization dataWithJSONObject:inputs options:NSJSONReadingMutableContainers error:&error];
    NSString* outDataString = [[NSString alloc]initWithBytes:[outData bytes] length:outData.length encoding:NSUTF8StringEncoding];
    return outDataString;
}



-(void)saveFile{
    NSString* fileString = self.jsonRepresentation;
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

    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (!jsonArray || jsonArray.count == 0) {
        NSLog(@"Error parsing JSON: %@", error);
        return;
    }
    
    for(NSDictionary* dict in jsonArray) {
        VWWThereminInput* input = [[VWWThereminInput alloc]initWithDictionary:dict];
        if([self.inputs objectForKey:input.description]){
            [self.inputs removeObjectForKey:input.description];
        }
        [self.inputs setObject:input forKey:input.description];
    }

    NSLog(@"self json = %@", self.jsonRepresentation);
}

@end
