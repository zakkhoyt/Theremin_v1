//
//  VWWThereminInput.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWThereminInputAxis.h"
#import "VWWThereminSynthesizerSettings.h"

@interface VWWThereminInput : NSObject
@property (nonatomic, retain) VWWThereminInputAxis* x;
@property (nonatomic, retain) VWWThereminInputAxis* y;
@property (nonatomic, retain) VWWThereminInputAxis* z;
@property (nonatomic) InputType inputType;
-(NSDictionary*)jsonRepresentation;
-(id)initWithType:(InputType)type;
@end
