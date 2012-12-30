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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



-(void)setLineX:(VWWLine *)line valid:(bool)valid{
    
}
-(void)setLineY:(VWWLine *)line valid:(bool)valid{
    
}
-(void)setLineZ:(VWWLine *)line valid:(bool)valid{
    
}
@end
