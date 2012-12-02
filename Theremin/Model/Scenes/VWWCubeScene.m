//
//  VWWCubeScene.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/20/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeScene.h"
#import "VWWCUbeModel.h"

#define VWWCUBE_SCENE_GL_ENABLE_TEXTURES 1
//#define VWWCUBE_SCENE_GL_ENABLE_LIGHTING 1
//#define VWWCUBE_SCENE_GL_ENABLE_COLORS 1

typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
    float Normal[3];
} Vertex;


const Vertex Vertices[] = {
    // Front
    {{1, -1, 1}, {1, 0, 0, 1}, {1, 0}, {0, 0, 1}},
    {{1, 1, 1}, {0, 1, 0, 1}, {1, 1}, {0, 0, 1}},
    {{-1, 1, 1}, {0, 0, 1, 1}, {0, 1}, {0, 0, 1}},
    {{-1, -1, 1}, {0, 0, 0, 1}, {0, 0}, {0, 0, 1}},
    // Back
    {{1, 1, -1}, {1, 0, 0, 1}, {0, 1}, {0, 0, -1}},
    {{-1, -1, -1}, {0, 1, 0, 1}, {1, 0}, {0, 0, -1}},
    {{1, -1, -1}, {0, 0, 1, 1}, {0, 0}, {0, 0, -1}},
    {{-1, 1, -1}, {0, 0, 0, 1}, {1, 1}, {0, 0, -1}},
    // Left
    {{-1, -1, 1}, {1, 0, 0, 1}, {1, 0}, {-1, 0, 0}},
    {{-1, 1, 1}, {0, 1, 0, 1}, {1, 1}, {-1, 0, 0}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1}, {-1, 0, 0}},
    {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}, {-1, 0, 0}},
    // Right
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}, {1, 0, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {1, 1}, {1, 0, 0}},
    {{1, 1, 1}, {0, 0, 1, 1}, {0, 1}, {1, 0, 0}},
    {{1, -1, 1}, {0, 0, 0, 1}, {0, 0}, {1, 0, 0}},
    // Top
    {{1, 1, 1}, {1, 0, 0, 1}, {1, 0}, {0, 1, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {1, 1}, {0, 1, 0}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1}, {0, 1, 0}},
    {{-1, 1, 1}, {0, 0, 0, 1}, {0, 0}, {0, 1, 0}},
    // Bottom
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}, {0, -1, 0}},
    {{1, -1, 1}, {0, 1, 0, 1}, {1, 1}, {0, -1, 0}},
    {{-1, -1, 1}, {0, 0, 1, 1}, {0, 1}, {0, -1, 0}},
    {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}, {0, -1, 0}}
};
const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    4, 5, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

@interface VWWCubeScene ()
@property (nonatomic) GLuint vertexArray;
@property (nonatomic) GLuint vertexBuffer;
@property (nonatomic) GLuint indexBuffer;
@property (nonatomic, retain) VWWCubeModel* cube;
@property (nonatomic, retain) GLKBaseEffect* effect;
@end

@implementation VWWCubeScene

-(void)update {
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -20.0);
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, self.translate.x, self.translate.y, self.translate.z);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(-self.rotate.y), 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(-self.rotate.x), 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(self.rotate.z), 0, 0, 1);
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}

-(void)render {
    // Important! Must call any time you change proper-
    // ties on a GLKBaseEffect, before you draw with it.
    [self.effect prepareToDraw];
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, Position));
#if defined(VWWCUBE_SCENE_GL_ENABLE_COLORS)
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)
                          offsetof(Vertex, Color));
#endif
    glBindVertexArrayOES(_vertexArray);
    glDrawElements(GL_TRIANGLES,
                   sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
}

#pragma mark - OpenGLES stuff
- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    self.effect = [[GLKBaseEffect alloc] init];
    
#if defined(VWWCUBE_SCENE_GL_ENABLE_TEXTURES)
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:YES],
                              GLKTextureLoaderOriginBottomLeft,
                              nil];
    NSError * error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"3x3_01" ofType:@"png"];
    GLKTextureInfo * info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", [error localizedDescription]);
    }
    self.effect.texture2d0.name = info.name;
    self.effect.texture2d0.enabled = true;
#endif
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          offsetof(Vertex, Position));
    
#if defined(VWWCUBE_SCENE_GL_ENABLE_COLORS)
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          offsetof(Vertex, Color));
#endif
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, Normal));
    
#if defined(VWWCUBE_SCENE_GL_ENABLE_TEXTURES)
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0,
                          2,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, TexCoord));
#endif
    
    glBindVertexArrayOES(0);
    
    // Enable texture winding
    glEnable(GL_CULL_FACE);
    
    // Setup a light (dont' forget the normals!)
#if defined(VWWCUBE_SCENE_GL_ENABLE_LIGHTING)
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(self.lightDiffuse, self.lightDiffuse, self.lightDiffuse, 1);
    self.effect.light0.ambientColor = GLKVector4Make(self.lightAmbient, self.lightAmbient, self.lightAmbient, 1);
    self.effect.light0.specularColor = GLKVector4Make(self.lightSpecular, self.lightSpecular, self.lightSpecular, 1);
    self.effect.light0.position = GLKVector4Make(10, 10, -8, 1);
    self.effect.lightingType = GLKLightingTypePerPixel;
#endif
 
    float aspect = fabsf(self.bounds.size.width / self.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.0f, 50.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    [self.effect release];
}
@end
