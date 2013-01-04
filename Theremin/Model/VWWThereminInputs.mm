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
            NSString* type = [item valueForKey:@"type"];
            NSDictionary* x = [item valueForKey:@"x"];
            NSDictionary* y = [item valueForKey:@"y"];
            NSDictionary* z = [item valueForKey:@"z"];
//            VWWThereminInputAxis* x = [[VWWThereminInputAxis alloc]initWithDictionary:
            
            if([type isEqualToString:@"touchscreen"]){
//                [self populateInput:self.touchInput withJson:item];
            }
        }
    }
}

-(VWWThereminInputAxis*)inputAxisFromDictionary:(NSDictionary*)dictionary{
    VWWThereminInputAxis* axis = [[VWWThereminInputAxis alloc]init];
    axis.frequencyMin = ((NSNumber*)[dictionary valueForKey:@"fmin"]).floatValue;
    axis.frequencyMax = ((NSNumber*)[dictionary valueForKey:@"fmax"]).floatValue;
    axis.sensitivity = ((NSNumber*)[dictionary valueForKey:@"sensitivity"]).floatValue;
    
    
//    @property (nonatomic) NSUInteger frequencyMax;
//    @property (nonatomic) NSUInteger frequencyMin;
//    @property (nonatomic) WaveType waveType;
//    @property (nonatomic) float sensitivity;
//    @property (nonatomic) EffectType effectType;

}

-(EffectType)effectTypeFromString:(NSString*)effectString{
    if([effectString isEqualToString:@"autotune"]){
        return kEffectAutoTune;
    }
    else if([effectString isEqualToString:@"linearize"]){
        return kEffectLinearize;
    }
    else if([effectString isEqualToString:@"throttle"]){
        return kEffectThrottle;
    }
    else /* if([effectString isEqualToString:@"none"]) */ {
        return kEffectNone;
    }
}

-(WaveType)waveTypeForString:(NSString*)waveString{
    if([waveString isEqualToString:@"sin"]){
        return kWaveSin;
    }
    else if([waveString isEqualToString:@"square"]){
        return kWaveSquare;
    }
    else if([waveString isEqualToString:@"triangle"]){
        return kWaveTriangle;
    }
    else if([waveString isEqualToString:@"sawtooth"]){
        return kWaveSawtooth;
    }
    else /* if([waveString isEqualToString:@"none"]) */ {
        return kWaveNone;
    }
}


-(InputType)inputTypeForString:(NSString*)inputString{
//
//        typedef enum{
//            kInputNone = 0x00,
//            kInputTouch = 0x01,
//            kInputAccelerometer = 0x02,
//            kInputGyros = 0x04,
//            kInputMagnetometer = 0x08,
//        } InputType;
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
