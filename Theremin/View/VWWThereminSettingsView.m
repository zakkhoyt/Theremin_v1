//
//  VWWThereminSettingsView.m
//  Theremin
//
//  Created by Zakk Hoyt on 1/7/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSettingsView.h"

@implementation VWWThereminSettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UIResponder touch events.
// If we don't override these methods, the responder chain will end up at our
// touch screen input
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

@end
