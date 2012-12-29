//
//  VWWConfigSensorView.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigSensorView.h"

@interface VWWConfigSensorView ()
@property (nonatomic, retain) VWWAxisFrequencies* lineFrequencies;
@property (nonatomic, retain) VWWAxisFrequencies* lineXMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineXMin;
@property (nonatomic, retain) VWWAxisFrequencies* lineYMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineYMin;
@property (nonatomic, retain) VWWAxisFrequencies* lineZMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineZMin;
@property (nonatomic) bool lineXMaxValid;
@property (nonatomic) bool lineXMinValid;
@property (nonatomic) bool lineYMaxValid;
@property (nonatomic) bool lineYMinValid;
@property (nonatomic) bool lineZMaxValid;
@property (nonatomic) bool lineZMinValid;
@end

@implementation VWWConfigSensorView

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
    CGFloat redColor[4] = {1.0, 0.0, 0.0, 1.0};
    
    CGContextSetStrokeColor(cgContext, greenColor);
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


-(void)setLineFrequencies:(VWWAxisFrequencies *)line{
    if(_lineFrequencies)[_lineFrequencies release];
    _lineFrequencies = [line retain];
}
-(void)setLineXMax:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineXMax)[_lineXMax release];
    _lineXMax = [line retain];
    _lineXMaxValid = valid;
}
-(void)setLineXMin:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineXMin)[_lineXMin release];
    _lineXMin = [line retain];
    _lineXMinValid = valid;
}
-(void)setLineYMax:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineYMax)[_lineYMax release];
    _lineYMax = [line retain];
    _lineYMaxValid = valid;
}
-(void)setLineYMin:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineYMin)[_lineYMin release];
    _lineYMin = [line retain];
    _lineYMinValid = valid;
}
-(void)setLineZMax:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineZMax)[_lineZMax release];
    _lineZMax = [line retain];
    _lineZMaxValid = valid;
}
-(void)setLineZMin:(VWWAxisFrequencies *)line valid:(bool)valid{
    if(_lineZMin)[_lineZMin release];
    _lineZMin = [line retain];
    _lineZMinValid = valid;
}



@end
