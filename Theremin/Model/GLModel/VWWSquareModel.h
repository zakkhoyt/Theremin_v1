//
//  VWWSquareModel.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


// Indivicual square colors
typedef enum{
    kVWWColorBlue = 0,
    kVWWColorGreen,
    kVWWColorOrange,
    kVWWColorRed,
    kVWWColorWhite,
    kVWWColorYellow,
} VWWColor;

// Faces (sides) of the cube
typedef enum{
    kVWWFaceFront = 0,
    kVWWFaceBack,
    kVWWFaceTop,
    kVWWFaceBottom,
    kVWWFaceLeft,
    kVWWFaceRight,
} VWWFace;

@interface VWWSquareModel : NSObject
@property (nonatomic) VWWColor      color;
@property (nonatomic) VWWFace       face;
@property (nonatomic) NSUInteger    location;
-(id)initWithColor:(VWWColor)color atLocation:(NSUInteger)location onFace:(VWWFace)face;
-(char)charForColor;
-(NSString*)stringForFace;
-(NSUInteger)valueForColor;
-(NSUInteger)valueForFace;
@end
