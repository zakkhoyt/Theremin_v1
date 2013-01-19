//
//  VWWConfigInputFrequencyView.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigInputFrequencyView.h"

@interface VWWConfigInputFrequencyView ()
@property (nonatomic, strong) VWWLine* lineFrequencies;
@property (nonatomic, strong) VWWLine* lineXMax;
@property (nonatomic, strong) VWWLine* lineXMin;
@property (nonatomic, strong) VWWLine* lineYMax;
@property (nonatomic, strong) VWWLine* lineYMin;
@property (nonatomic, strong) VWWLine* lineZMax;
@property (nonatomic, strong) VWWLine* lineZMin;
@property (nonatomic) bool lineXMaxValid;
@property (nonatomic) bool lineXMinValid;
@property (nonatomic) bool lineYMaxValid;
@property (nonatomic) bool lineYMinValid;
@property (nonatomic) bool lineZMaxValid;
@property (nonatomic) bool lineZMinValid;
@end

@implementation VWWConfigInputFrequencyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineXMaxValid = NO;
        _lineXMinValid = NO;
        _lineYMaxValid = NO;
        _lineYMinValid = NO;
        _lineZMaxValid = NO;
        _lineZMinValid = NO;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{

    CGContextRef cgContext = UIGraphicsGetCurrentContext();

    CGContextBeginPath(cgContext);
    CGContextSetLineWidth(cgContext, 2.0f);
    
    CGFloat greenColor[4] = {0.0, 1.0, 0.0, 1.0};
    CGFloat yellowColor[4] = {1.0, 1.0, 0.0, 1.0};
    CGFloat redColor[4] = {1.0, 0.0, 0.0, 1.0};
    
    CGContextSetStrokeColor(cgContext, yellowColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineFrequencies.begin
                      toPoint:self.lineFrequencies.end];
    CGContextStrokePath(cgContext);
    
    
    
    self.lineXMaxValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineXMax.begin
                      toPoint:self.lineXMax.end];
    CGContextStrokePath(cgContext);
    
    self.lineXMinValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineXMin.begin
                      toPoint:self.lineXMin.end];
    CGContextStrokePath(cgContext);
    
    self.lineYMaxValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineYMax.begin
                      toPoint:self.lineYMax.end];
    CGContextStrokePath(cgContext);
    
    self.lineYMinValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineYMin.begin
                      toPoint:self.lineYMin.end];
    CGContextStrokePath(cgContext);
    
    self.lineZMaxValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineZMax.begin
                      toPoint:self.lineZMax.end];
    CGContextStrokePath(cgContext);
    
    self.lineZMinValid ? CGContextSetStrokeColor(cgContext, greenColor) : CGContextSetStrokeColor(cgContext, redColor);
    [self drawLineWithContext:cgContext
                    fromPoint:self.lineZMin.begin
                      toPoint:self.lineZMin.end];
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


-(void)setLineFrequencies:(VWWLine *)line{
    _lineFrequencies = line;
}
-(void)setLineXMax:(VWWLine *)line valid:(bool)valid{
    _lineXMax = line;
    _lineXMaxValid = valid;
}
-(void)setLineXMin:(VWWLine *)line valid:(bool)valid{
    _lineXMin = line;
    _lineXMinValid = valid;
}
-(void)setLineYMax:(VWWLine *)line valid:(bool)valid{
    _lineYMax = line;
    _lineYMaxValid = valid;
}
-(void)setLineYMin:(VWWLine *)line valid:(bool)valid{
    _lineYMin = line;
    _lineYMinValid = valid;
}
-(void)setLineZMax:(VWWLine *)line valid:(bool)valid{
    _lineZMax = line;
    _lineZMaxValid = valid;
}
-(void)setLineZMin:(VWWLine *)line valid:(bool)valid{
    _lineZMin = line;
    _lineZMinValid = valid;
}


@end











