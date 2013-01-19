//
//  VWWScene.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/20/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>

@protocol VWWSceneProtocol <NSObject>
-(id)initWithFrame:(CGRect)frame context:(EAGLContext *)context;
-(void)render;
-(void)update;
-(void)setupGL;
-(void)tearDownGL;
@end

@interface VWWScene : NSObject 
@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic) CGRect bounds;
-(id)initWithFrame:(CGRect)frame context:(EAGLContext *)context;
-(void)render;
-(void)update;
-(void)setupGL;
-(void)tearDownGL;
@end
