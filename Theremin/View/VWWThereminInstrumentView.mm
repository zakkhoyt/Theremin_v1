//
//  VWWThereminInstrumentView.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInstrumentView.h"



@interface VWWThereminInstrumentView ()
@property CGPoint selectedPixel;
@end

@implementation VWWThereminInstrumentView
//@synthesize settings = _settings;
//@synthesize selectedPixel = _selectedPixel;
//@synthesize crosshairColor = _crosshairColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.crosshairColor = [UIColor greenColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Don't draw a crosshair if the user hasn't touched yet.
    if(self.selectedPixel.x == 0 && self.selectedPixel.y == 0){
        return;
    }
    
    const int kCrosshairLength = 100;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [self.crosshairColor getRed:&red green:&green blue:&blue alpha:&alpha];
     
     
    CGFloat color[4] = {red, green, blue, alpha};        // r,g,b,a
    CGContextSetStrokeColor(c, color);
    CGContextBeginPath(c);
   
    CGContextSetLineWidth(c, 5.0f);

    
    CGFloat startX = self.selectedPixel.x - (kCrosshairLength/2);
    if(startX < 0) startX = 0;
    
    CGFloat finishX = self.selectedPixel.x + (kCrosshairLength/2);
    if(finishX > self.bounds.size.width) finishX = self.bounds.size.width;
    
    CGFloat startY = self.selectedPixel.y - (kCrosshairLength/2);
    if(startY < 0) startY = 0;
    
    CGFloat finishY = self.selectedPixel.y + (kCrosshairLength/2);
    if(finishY > self.bounds.size.height) finishY = self.bounds.size.height;
    
    // draw horiontal hair
    CGContextMoveToPoint(c,
                         startX,
                         self.selectedPixel.y);
    
    CGContextAddLineToPoint(c,
                            finishX,
                            self.selectedPixel.y);
    
    // draw vertical hair
    CGContextMoveToPoint(c,
                         self.selectedPixel.x,
                         startY);
    CGContextAddLineToPoint(c,
                            self.selectedPixel.x,
                            finishY);
    
    CGContextStrokePath(c);
}

#pragma mark UIView touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(touch.tapCount == 2){
        // double tap
    }
    else if(touch.tapCount == 1){
        [self touchEvent:touches withEvent:event];
    }
    
    [self.settings start];
    [self.delegate VWWThereminInstrumentView:self touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(touch.tapCount == 2){
        // double tap
    }
    else if(touch.tapCount == 1){
        [self touchEvent:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // Set point to 0,0 and update UI
    // Does not affect sound
    self.selectedPixel = CGPointMake(0, 0);
    [self setNeedsDisplay];

    
//    [self.settings stop];
    
//    if(self.delegate){
////        [self.delegate touchEnded];
//    }
//    
//    if(self.delegate){
////        [self.delegate touchBegan];
//    }
}

#pragma mark Custom methods

- (void)touchEvent:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch* touch in [event allTouches]){
        CGPoint point = [touch locationInView:self];
        
        // This will catch if the user dragged their finger out of bounds of the UIImageView
        if (!CGRectContainsPoint(self.bounds, point)){
            return;
        }
        
        self.selectedPixel = point;
        [self setNeedsDisplay];
        

        float newTouchValue = (self.bounds.size.height - point.y) / self.bounds.size.height;
        self.settings.touchValue = newTouchValue;
//        NSLog(@"s.s.tv=%f ntv=%f", self.settings.touchValue, newTouchValue);

    }
}


@end
