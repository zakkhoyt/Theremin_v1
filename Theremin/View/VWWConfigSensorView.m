//
//  VWWConfigSensorView.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigSensorView.h"

@interface VWWConfigSensorView ()

@end

@implementation VWWConfigSensorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    
//    if(!(_pointBegin.x == 0 && _pointBegin.y == 0 &&
//         _pointEnd.x == 0 && _pointEnd.y == 0)){
//        // Draw line from axis to frequency line
//    }
    
    
    
    
//    c = UIGraphicsGetCurrentContext();
//    
//    CGFloat black[4] = {0, 0,
//        0, 1};
//    CGContextSetStrokeColor(c, black);
//    CGContextBeginPath(c);
//    CGContextMoveToPoint(c, 100, 100);
//    CGContextAddLineToPoint(c, 100, 200);
//    CGContextStrokePath(c);
    
    
    
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    
    CGFloat red = 1.0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 1.0;
    CGFloat color[4] = {red, green, blue, alpha};        // r,g,b,a
    CGContextSetStrokeColor(cgContext, color);
    CGContextBeginPath(cgContext);
    CGContextSetLineWidth(cgContext, 5.0f);
    
    CGPoint frequencyLineBegin = self.lineFrequenciesMax.begin;
    CGPoint frequencyLineEnd = self.lineFrequenciesMax.end;
    
    // draw horiontal hair
    CGContextMoveToPoint(cgContext,
                         frequencyLineBegin.x,
                         frequencyLineBegin.y);
    
    CGContextAddLineToPoint(cgContext,
                            frequencyLineEnd.x,
                            frequencyLineEnd.y);
    //
    //    // draw vertical hair
    //    CGContextMoveToPoint(cgContext,
    //                         self.selectedPixel.x,
    //                         startY);
    //    CGContextAddLineToPoint(cgContext,
    //                            self.selectedPixel.x,
    //                            finishY);
    
    CGContextStrokePath(cgContext);
}



@end
