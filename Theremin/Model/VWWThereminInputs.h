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
@property (nonatomic, retain) NSMutableDictionary* inputs;
+(VWWThereminInputs *)sharedInstance;
-(void)saveFile;


@end
