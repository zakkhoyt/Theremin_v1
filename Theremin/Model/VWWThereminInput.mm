//
//  VWWThereminInput.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInput.h"

@implementation VWWThereminInput

-(id)init{
    self = [super init];
    if(self){
        [self loadDefaults];
    }
    return self;
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
