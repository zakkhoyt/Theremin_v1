//
//  VWWThereminInputs.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWThereminInput.h"
#import "VWWThereminSynthesizerSettings.h"


@interface VWWThereminInputs : NSObject
@property (nonatomic, retain) VWWThereminInput* activeInput;
@property (nonatomic, retain) NSArray* inputs;

+(VWWThereminInputs *)sharedInstance;

-(void)saveDefaults;
-(NSDictionary*)jsonRepresentation;

@end
