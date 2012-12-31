//
//  VWWConfigInputEffectsView.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigInputEffectsView.h"

@interface VWWConfigInputEffectsView ()
@property (nonatomic, retain) VWWLine* lineX;
@property (nonatomic, retain) VWWLine* lineY;
@property (nonatomic, retain) VWWLine* lineZ;
@property (nonatomic) bool lineXValid;
@property (nonatomic) bool lineYValid;
@property (nonatomic) bool lineZValid;

@end

@implementation VWWConfigInputEffectsView

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
    
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(cgContext);
    CGContextSetLineWidth(cgContext, 2.0f);
    
    CGFloat greenColor[4] = {0.0, 1.0, 0.0, 1.0};
    CGFloat redColor[4] = {1.0, 0.0, 0.0, 1.0};
    
    self.lineXValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineX.begin
                      toPoint:self.lineX.end];
    CGContextStrokePath(cgContext);
    
    
    self.lineYValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineY.begin
                      toPoint:self.lineY.end];
    CGContextStrokePath(cgContext);
    
    
    self.lineZValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineZ.begin
                      toPoint:self.lineZ.end];
    CGContextStrokePath(cgContext);
}


-(void)drawLineWithContext:(CGContextRef)cgContext fromPoint:(CGPoint)begin toPoint:(CGPoint)end{
    // Don't draw the line unless both points are not set.
    if((begin.x == 0 && begin.y == 0) ||
       (end.x == 0 && end.y == 0)){
        return;
    }
    CGContextMoveToPoint(cgContext,
                         begin.x,
                         begin.y);
    
    CGContextAddLineToPoint(cgContext,
                            end.x,
                            end.y);
}

-(void)setLineX:(VWWLine *)line valid:(bool)valid{
    if(_lineX)[_lineX release];
    _lineX = [line retain];
    _lineXValid = valid;
}
-(void)setLineY:(VWWLine *)line valid:(bool)valid{
    if(_lineY)[_lineY release];
    _lineY = [line retain];
    _lineYValid = valid;
}
-(void)setLineZ:(VWWLine *)line valid:(bool)valid{
    if(_lineZ)[_lineZ release];
    _lineZ = [line retain];
    _lineZValid = valid;
}

@end
