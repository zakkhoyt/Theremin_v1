//
//  VWWCubeModel.h
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  When a new (this) object is allocated it will be in the solved state.
//
//  To invision a cube we will always go Front, Right, Back, Left, Top, Bottom.
//  Imagine setting the cube on a table an (looking straight down on it) rotate
//  it clockwise for the first 4 face. Leant it back for the t5th and lean it
//  back twice more for the bottom. The squares of each face will start in the upper
//  left and count just like you would read a page.
//
//  There are methods to manipulate the cube. There are pow(size, 3)*2 ways to rotate a cube,
//  Picture the front of a size 3 cube (3x3). You can
//  make the following rotations:
//  Rotate column 1 (left/right)
//  Rotate column 2 (left/right)
//  Rotate column 3 (left/right)
//  Rotate row 1 (up/down)
//  Rotate row 2 (up/down)
//  Rotate row 3 (up/down)
//  You can also rotate that entire front face (clockwise/anticlockwise
//  Next, the back face  (clockwise/anticlockwise
//  Also the middle face (clockwise/anticlockwise
//
//  Of course we can have cubes of different sizes as well, but the formula stays the same.
//
//  This class is a base class for cubes of different sizes. If a function really
//  relies on its size to determine data and operations, we will use a subclass.
//  For example VWWCubeModel3x3 will handle rotation operations. 



#import <Foundation/Foundation.h>
#import "VWWSquareModel.h"
@interface VWWCubeModel : NSObject


// Allocate a new cube with <size> cubes per side;
-(id)initWithSize:(NSUInteger)size;


// Checks if each side of the cube is a solid color. Doesn't matter which
-(bool)isSolved;


// Mess the cube up. Give it some random twists;
-(void)jumbleWithIntensity:(NSUInteger)intensity;

// Print the cube data to the console
-(void)printCube;
-(void)printCubeVerbose;

-(void)sortSquaresByFaceAndLocation;

@end
