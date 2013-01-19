//
//  VWWThereminInput.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWThereminInputAxis.h"

@interface VWWThereminInput : NSObject
@property (nonatomic, strong) VWWThereminInputAxis* x;
@property (nonatomic, strong) VWWThereminInputAxis* y;
@property (nonatomic, strong) VWWThereminInputAxis* z;
@property (nonatomic) InputType inputType;
@property (nonatomic) bool muted;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithType:(InputType)type;
-(NSDictionary*)jsonRepresentation;
-(NSString*)description;
@end
