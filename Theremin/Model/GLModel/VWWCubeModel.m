//
//  VWWCubeModel.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"
#define VWWDEFAULT_CUBE_SIZE 3

@interface VWWCubeModel ()
@property (nonatomic) NSUInteger cubeSize;
@property (nonatomic) NSUInteger squaresPerColor;
@property (nonatomic, retain) NSMutableArray* squares;

@end

@implementation VWWCubeModel

-(id)init{
    return [self initWithSize:VWWDEFAULT_CUBE_SIZE];
}


#pragma mark - Custom methods (public) 

// Allocate a new cube with <size> cubes per side;
-(id)initWithSize:(NSUInteger)size{
    self = [super init];
    if(self){
        _cubeSize = size;
        _squaresPerColor = _cubeSize * _cubeSize;
        [self initializeClass];
    }
    return self;
}


-(void)initializeClass{
    self.squares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor * 6];

    for(NSUInteger index = 0; index < self.squaresPerColor; index++){
        // one of each color
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorBlue atLocation:index onFace:kVWWFaceBack]];
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorGreen atLocation:index onFace:kVWWFaceBottom]];
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorOrange atLocation:index onFace:kVWWFaceFront]];
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorRed atLocation:index onFace:kVWWFaceLeft]];
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorWhite atLocation:index onFace:kVWWFaceRight]];
        [self.squares addObject:[[VWWSquareModel alloc]initWithColor:kVWWColorYellow atLocation:index onFace:kVWWFaceTop]];
    }
}

// Checks if each side of the cube is a solid color. Doesn't matter which
-(bool)isSolved{
    // sort by color
    [self.squares sortUsingComparator:^(id obj1, id obj2) {
        VWWSquareModel* square1 = (VWWSquareModel*)obj1;
        VWWSquareModel* square2 = (VWWSquareModel*)obj2;
        return square1.valueForColor < square2.valueForColor ? NSOrderedAscending : NSOrderedDescending;
    }];
    return YES;
}


// Mess the cube up. Give it some random twists;
-(void)jumbleWithIntensity:(NSUInteger)intensity{
    NSLog(@"ERROR occurred at %s:%s:%d", __FILE__, __FUNCTION__, __LINE__);
    NSLog(@"Child class must implement this method");
    assert(NO);
}

// Print a short representation of the cube
-(void)printCube{
    const NSUInteger kNumSides = 6;
    NSMutableString* cubeString = [NSMutableString new];
    NSMutableString* rowString = [NSMutableString new];
    [cubeString setString:@"Current cube state:\n"];
    [self sortSquaresByFaceAndLocation];
    VWWSquareModel* square = nil;
    NSUInteger squareIndex = 0;
    for(NSUInteger f = 0; f < kNumSides; f++){
        // Get the face name and print it
        squareIndex = f * self.squaresPerColor;
        square  = [self.squares objectAtIndex:squareIndex];
        [cubeString appendFormat:@"---- %@ ----\n", square.stringForFace];
        
        for(NSUInteger y = 0; y < self.cubeSize; y++){
            for(NSUInteger x = 0; x < self.cubeSize; x++){
                // Get the color of the square and append it to rowString
                squareIndex = f * self.squaresPerColor + y * self.cubeSize + x;
                square = [self.squares objectAtIndex:squareIndex];
                [rowString appendFormat:@"%c", square.charForColor];
            }
            [cubeString appendFormat:@"%@\n", rowString];
            [rowString setString:@""];
        }
    }
    [cubeString appendString:@"----------------"];
    NSLog(@"%@", cubeString);
}


// Print the cube data to the console
-(void)printCubeVerbose{
    for(NSUInteger index = 0; index < self.squaresPerColor * 6; index++){
        NSLog(@"%@", [self.squares objectAtIndex:index]);
    }
}

-(void)sortSquaresByFaceAndLocation{
    const NSUInteger kNumFaces = 6;
    NSMutableArray* faces[kNumFaces];

    [self breakSquaresIntoFaceArraysFront:&faces[0]
                                    right:&faces[1]
                                     back:&faces[2]
                                     left:&faces[3]
                                      top:&faces[4]
                                   bottom:&faces[5]];
    
    [self.squares removeAllObjects];
    for(NSUInteger index = 0; index < kNumFaces; index++){
        [faces[index] sortUsingComparator:^(id obj1, id obj2) {
            VWWSquareModel* square1 = (VWWSquareModel*)obj1;
            VWWSquareModel* square2 = (VWWSquareModel*)obj2;
            return square1.location < square2.location ? NSOrderedAscending : NSOrderedDescending;
        }];
        [self.squares addObjectsFromArray:faces[index]];
    }
}


#pragma mark - Custom methods (private) 
-(void)breakSquaresIntoColorArraysBlue:(NSMutableArray**)blue
                                 green:(NSMutableArray**)green
                                orange:(NSMutableArray**)orange
                                   red:(NSMutableArray**)red
                                 white:(NSMutableArray**)white
                                yellow:(NSMutableArray**)yellow{
    // sort by color
    [self.squares sortUsingComparator:^(id obj1, id obj2) {
        VWWSquareModel* square1 = (VWWSquareModel*)obj1;
        VWWSquareModel* square2 = (VWWSquareModel*)obj2;
        return square1.valueForColor < square2.valueForColor ? NSOrderedAscending : NSOrderedDescending;
    }];
    // Now that they are sorted by color we can sort by order
    
    *blue = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *green = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *orange = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *red = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *white = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *yellow = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    
    for(NSUInteger index = 0; index < self.squaresPerColor; index++){
        [*blue addObject:[self.squares objectAtIndex:0 * self.squaresPerColor + index]];
        [*green addObject:[self.squares objectAtIndex:1 * self.squaresPerColor + index]];
        [*orange addObject:[self.squares objectAtIndex:2 * self.squaresPerColor + index]];
        [*red addObject:[self.squares objectAtIndex:3 * self.squaresPerColor + index]];
        [*white addObject:[self.squares objectAtIndex:4 * self.squaresPerColor + index]];
        [*yellow addObject:[self.squares objectAtIndex:5 * self.squaresPerColor + index]];
    }
    

}



-(void)breakSquaresIntoFaceArraysFront:(NSMutableArray**)front
                                 right:(NSMutableArray**)right
                                  back:(NSMutableArray**)back
                                  left:(NSMutableArray**)left
                                   top:(NSMutableArray**)top
                                bottom:(NSMutableArray**)bottom{
    // sort by face
    [self.squares sortUsingComparator:^(id obj1, id obj2) {
        VWWSquareModel* square1 = (VWWSquareModel*)obj1;
        VWWSquareModel* square2 = (VWWSquareModel*)obj2;
        return square1.valueForFace < square2.valueForFace ? NSOrderedAscending : NSOrderedDescending;
    }];
    // Now that they are sorted by color we can sort by order
    
    *front = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *right = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *back = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *left = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *top = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    *bottom = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    
    for(NSUInteger index = 0; index < self.squaresPerColor; index++){
        [*front addObject:[self.squares objectAtIndex:0 * self.squaresPerColor + index]];
        [*right addObject:[self.squares objectAtIndex:1 * self.squaresPerColor + index]];
        [*back addObject:[self.squares objectAtIndex:2 * self.squaresPerColor + index]];
        [*left addObject:[self.squares objectAtIndex:3 * self.squaresPerColor + index]];
        [*top addObject:[self.squares objectAtIndex:4 * self.squaresPerColor + index]];
        [*bottom addObject:[self.squares objectAtIndex:5 * self.squaresPerColor + index]];
    }
}




@end
