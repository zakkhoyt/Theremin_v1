//
//  VWWSquareModel.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSquareModel.h"

@interface VWWSquareModel ()


@end

@implementation VWWSquareModel
-(id)initWithColor:(VWWColor)color atLocation:(NSUInteger)location onFace:(VWWFace)face{
    self = [super init];
    if(self){
        _color = color;
        _location = location;
        _face = face;
    }
    return self;
}


-(char)charForColor{
    switch(self.color){
        case kVWWColorBlue:
            return 'B';
        case kVWWColorGreen:
            return 'G';
        case kVWWColorOrange:
            return 'O';
        case kVWWColorRed:
            return 'R';
        case kVWWColorWhite:
            return 'W';
        case kVWWColorYellow:
            return 'Y';
        default:
            return '!';
    }
}


-(NSString*)description{
    NSMutableString* r = [[NSMutableString alloc]init];
    if(self.color == kVWWColorBlue){
        [r appendFormat:@"color=blue "];
    }
    else if(self.color == kVWWColorGreen){
        [r appendFormat:@"color=green "];
    }
    else if(self.color == kVWWColorRed){
        [r appendFormat:@"color=red "];
    }
    else if(self.color == kVWWColorYellow){
        [r appendFormat:@"color=yellow "];
    }
    else if(self.color == kVWWColorWhite){
        [r appendFormat:@"color=white "];
    }
    else if(self.color == kVWWColorOrange){
        [r appendFormat:@"color=orange "];
    }
    else{
        [r appendFormat:@"color=????? "];
    }

    if(self.face == kVWWFaceBack){
        [r appendFormat:@"face=back "];
    }
    else if(self.face == kVWWFaceBottom){
        [r appendFormat:@"face=bottom "];
    }
    else if(self.face == kVWWFaceFront){
        [r appendFormat:@"face=front "];
    }
    else if(self.face == kVWWFaceLeft){
        [r appendFormat:@"face=left "];
    }
    else if(self.face == kVWWFaceRight){
        [r appendFormat:@"face=right "];
    }
    else if(self.face == kVWWFaceTop){
        [r appendFormat:@"face=top "];
    }
    else{
        [r appendFormat:@"face=???? "];
    }

    [r appendFormat:@"location=%d ", self.location];
//    [r appendFormat:@"address=%p", self];
    
    return r;

}


-(NSString*)stringForFace{
    switch(self.face){
        case kVWWFaceFront:
            return @"Front";
        case kVWWFaceRight:
            return @"Right";
        case kVWWFaceBack:
            return @"Back";
        case kVWWFaceLeft:
            return @"Left";
        case kVWWFaceTop:
            return @"Top";
        case kVWWFaceBottom:
            return @"Bottom";
        default:
            return @"Error";
    }
}

-(NSUInteger)valueForColor{
    switch(self.color){
        case kVWWColorBlue:
            return 1;
        case kVWWColorGreen:
            return 2;
        case kVWWColorOrange:
            return 3;
        case kVWWColorRed:
            return 4;
        case kVWWColorWhite:
            return 5;
        case kVWWColorYellow:
            return 6;
        default:
            return 666;
    }
}
-(NSUInteger)valueForFace{
    switch(self.face){
        case kVWWFaceFront:
            return 1;
        case kVWWFaceRight:
            return 2;
        case kVWWFaceBack:
            return 3;
        case kVWWFaceLeft:
            return 4;
        case kVWWFaceTop:
            return 5;
        case kVWWFaceBottom:
            return 6;
        default:
            return 666;
    }
}
@end
