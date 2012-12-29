//
//  VWWThereminConfigSensor.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigSensor.h"
#import "VWWConfigSensorView.h"

@interface VWWThereminConfigSensor ()
@property (retain, nonatomic) IBOutlet VWWConfigSensorView *configView;
@property (retain, nonatomic) IBOutlet UILabel *frequencyMaxLabel;
@property (retain, nonatomic) IBOutlet UILabel *frequencyMinLabel;
- (IBAction)cancelButtonHandler:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigSensor

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeClass];
    }
    return self;
}

-(void)initializeClass{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGPoint begin = self.frequencyMaxLabel.center;
    begin.y += self.frequencyMaxLabel.frame.size.height/2.0;
    
    CGPoint end = self.frequencyMinLabel.center;
    end.y -= self.frequencyMinLabel.frame.size.height/2.0;
    
    VWWAxisFrequencies* frequenciesLine = [[VWWAxisFrequencies alloc]
                                           initWithBegin:begin
                                           andEnd:end];
    [self.configView setLineFrequencies:frequenciesLine];
    // TODO: axisFreq
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_frequencyMaxLabel release];
    [_frequencyMinLabel release];
    [super dealloc];
}



#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    // OpenGL
//    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
//    NSArray *touchesArray = [touches allObjects];
//    UITouch* touch = [touchesArray objectAtIndex:0];
//    self.touchBegan = [touch locationInView:nil];
//    
//    
//    // Synth
//    if(touch.tapCount == 2){
//        // double tap
//    }
//    else if(touch.tapCount == 1){
//        [self touchEvent:touches withEvent:event];
//    }
//    
//    [self.settings start];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.configView setNeedsDisplay];
//    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
//    NSArray *touchesArray = [touches allObjects];
//    UITouch* touch = [touchesArray objectAtIndex:0];
//    self.touchMoved = [touch locationInView:nil];
//    CGFloat rotateX = self.touchBegan.x - self.touchMoved.x;
//    CGFloat rotateY = self.touchBegan.y - self.touchMoved.y;
//    for(VWWCubeScene* cube in self.cubes){
//        cube.rotate = GLKVector3Make(rotateX, rotateY, 0);
//    }
//    
//    // Synth
//    if(touch.tapCount == 2){
//        // double tap
//    }
//    else if(touch.tapCount == 1){
//        [self touchEvent:touches withEvent:event];
//    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
//    
//    // Synth
//    self.selectedPixel = CGPointMake(0, 0);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
}


- (void)touchEvent:(NSSet *)touches withEvent:(UIEvent *)event{
//    for(UITouch* touch in [event allTouches]){
//        CGPoint point = [touch locationInView:self.view];
//        
//        // This will catch if the user dragged their finger out of bounds of the UIImageView
//        if (!CGRectContainsPoint(self.view.bounds, point)){
//            return;
//        }
//        
//        self.selectedPixel = point;
//        float newTouchValue = (self.view.bounds.size.height - point.y) / self.view.bounds.size.height;
//        self.settings.touchValue = newTouchValue;
//    }
}



- (IBAction)cancelButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigSensorUserDidCancel:self];
}

- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigSensorUserIsDone:self];
}
@end
