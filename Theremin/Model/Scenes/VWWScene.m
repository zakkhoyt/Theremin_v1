//
//  VWWScene.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/20/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWScene.h"

@interface VWWScene ()

@end

@implementation VWWScene


-(id)initWithFrame:(CGRect)frame context:(EAGLContext *)context{
    self = [super init];
    if(self){
        self.bounds = frame;
        self.context = context;
    }
    return self;
}


-(void)update {
    NSLog(@"ERROR! Child class to implement");
    assert(NO);
}

-(void)render {
    NSLog(@"ERROR! Child class to implement");
    assert(NO);
}

- (void)setupGL{
    NSLog(@"ERROR! Child class to implement");
    assert(NO);
}

- (void)tearDownGL{
    NSLog(@"ERROR! Child class to implement");
    assert(NO);
}

@end
