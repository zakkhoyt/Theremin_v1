//
//  VWWConfigInputAmplitudeView.m
//  Theremin
//
//  Created by Zakk Hoyt on 1/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigInputAmplitudeView.h"

@interface VWWConfigInputAmplitudeView ()
@property (nonatomic, strong) VWWLine* lineAmplitude;
@property (nonatomic, strong) VWWLine* lineX;
@property (nonatomic, strong) VWWLine* lineY;
@property (nonatomic, strong) VWWLine* lineZ;
@property (nonatomic) bool lineXValid;
@property (nonatomic) bool lineYValid;
@property (nonatomic) bool lineZValid;
@end

@implementation VWWConfigInputAmplitudeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineXValid = NO;
        _lineYValid = NO;
        _lineZValid = NO;
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
                    fromPoint:self.lineAmplitude.begin
                      toPoint:self.lineAmplitude.end];
    CGContextStrokePath(cgContext);
    
    
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


-(void)setLineFrequencies:(VWWLine *)line{
    _lineAmplitude = line;
}
-(void)setLineX:(VWWLine *)line valid:(bool)valid{
    _lineX = line;
    _lineXValid = valid;
}
-(void)setLineY:(VWWLine *)line valid:(bool)valid{
    _lineY = line;
    _lineYValid = valid;
}
-(void)setLineZ:(VWWLine *)line valid:(bool)valid{
    _lineZ = line;
    _lineZValid = valid;
}

//#pragma mark - UIResponder touch events.
//// If we don't override these methods, the responder chain will end up at our
//// touch screen input
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//}


@end
