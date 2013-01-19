
//  VWWThereminInputs.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputs.h"
#import "VWWFileSystem.h"

@interface VWWThereminInputs ()
@property (nonatomic, strong) NSMutableDictionary* inputs;
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
+(void)saveConfigFile{
    [[self sharedInstance]saveFile];
}
+(void)resetConfigAndSave{
    VWWThereminInputs* vwwThereminInputs = [VWWThereminInputs sharedInstance];
    [vwwThereminInputs.inputs removeAllObjects];
    [vwwThereminInputs createAndSaveNewInputs];
    
    // Save the changes;
    [[self sharedInstance]saveFile];
}
+(VWWThereminInput*)accelerometerInput{
    return ([self sharedInstance].inputs)[kKeyAccelerometer];
}
+(VWWThereminInput*)gyroscopeInput{
    return ([self sharedInstance].inputs)[kKeyGyroscope];
}
+(VWWThereminInput*)magnetometerInput{
    return ([self sharedInstance].inputs)[kKeyMagnetometer];
}
+(VWWThereminInput*)touchscreenInput{
    return ([self sharedInstance].inputs)[kKeyTouchScreen];
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
        
    // If the config file exists, load it. If not, go ahead and write our default values as a file and move on.
    if([VWWFileSystem configFileExists]){
        [self loadFile];
    }
    else{
        [self createAndSaveNewInputs];
    }
}

-(void)createAndSaveNewInputs{
    VWWThereminInput* touchInput = [[VWWThereminInput alloc]initWithType:kInputTouch];
    VWWThereminInput* accelerometerInput = [[VWWThereminInput alloc]initWithType:kInputAccelerometer];
    VWWThereminInput* gyroscopeInput = [[VWWThereminInput alloc]initWithType:kInputGyros];
    VWWThereminInput* magnetometerInput = [[VWWThereminInput alloc]initWithType:kInputMagnetometer];
    
    (self.inputs)[touchInput.description] = touchInput;
    (self.inputs)[accelerometerInput.description] = accelerometerInput;
    (self.inputs)[gyroscopeInput.description] = gyroscopeInput;
    (self.inputs)[magnetometerInput.description] = magnetometerInput;
    
    [self saveFile];
}


-(NSString*)jsonRepresentation{
    NSMutableArray* inputs = [[NSMutableArray alloc]init];
    for(NSString* key in [self.inputs allKeys]){
        VWWThereminInput* input = (self.inputs)[key];
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
        if((self.inputs)[input.description]){
            [self.inputs removeObjectForKey:input.description];
        }
        (self.inputs)[input.description] = input;
    }

    NSLog(@"self json = %@", self.jsonRepresentation);
}

@end
