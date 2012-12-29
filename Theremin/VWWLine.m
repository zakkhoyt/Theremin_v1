//
//  VWWLine.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWLine.h"

@implementation VWWLine
-(id)initWithBegin:(CGPoint)begin andEnd:(CGPoint)end{
    self = [super init];
    if(self){
        _begin = begin;
        _end = end;
    }
    return self;
}
@end

