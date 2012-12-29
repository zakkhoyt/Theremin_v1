//
//  VWWLine.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWLine : NSObject
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
-(id)initWithBegin:(CGPoint)begin andEnd:(CGPoint)end;
@end
