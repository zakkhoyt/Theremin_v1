//
//  VWWThereminViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See tutorial here: http://www.raywenderlich.com/5235/beginning-opengl-es-2-0-with-glkit-part-2
//  iOS6 book here: http://www.raywenderlich.com/store/ios-6-by-tutorials
//  Matrix info here: http://casualdistractiongames.wordpress.com/
//  About rendering multiple objects: http://games.ianterrell.com/2d-game-engine-tutorial/

#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "VWWCubeScene.h"
#import "VWWThereminViewController.h"
//#import "VWWCubeModel.h"
#import "VWWMotionMonitor.h"
#import "VWWThereminSynthesizerSettings.h"
#import "VWWThereminSettingsViewController.h"
#import "VWWThereminHelpViewController.h"

const CGFloat kRotateXSensitivity = 0.25f;
const CGFloat kRotateYSensitivity = 0.25f;
const CGFloat kRotateZSensitivity = 0.25f;

@interface VWWThereminViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate,
    VWWThereminHelpViewControllerDelegate,
    VWWThereminSettingsViewControllerDelegate>{
}
@property (nonatomic, retain) VWWThereminSynthesizerSettings* settings;
@property (nonatomic, retain) EAGLContext * context;
@property (nonatomic, retain) IBOutlet GLKView* view;
@property (nonatomic, retain) VWWMotionMonitor* motionMonitor;
@property (nonatomic) CGPoint touchBegan;
@property (nonatomic) CGPoint touchMoved;
@property (nonatomic) CGPoint touchEnded;
@property (nonatomic, retain) NSTimer* rotateTimer;
@property (nonatomic, retain) NSMutableArray* cubes;
@property CGPoint selectedPixel;


// UI components

@property (retain, nonatomic) IBOutlet UILabel *lblAccelerometer;
@property (retain, nonatomic) IBOutlet UILabel *lblGyros;
@property (retain, nonatomic) IBOutlet UILabel *lblMagnetometer;
@property (retain, nonatomic) IBOutlet UILabel *lblInfo;

- (IBAction)settingsButtonHandler:(id)sender;
- (IBAction)aboutButtonHandler:(id)sender;


@end

@implementation VWWThereminViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initializeClass];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Open GL stuff
    [self createGLView];
    [self createCubeScene];
    [self.cubes makeObjectsPerformSelector:@selector(setupGL)];

    
    // Theremin stuff
    UIColor* textColor = [UIColor greenColor];
    self.lblAccelerometer.textColor = textColor;
    self.lblGyros.textColor = textColor;
    self.lblMagnetometer.textColor = textColor;
}


-(void)viewDidUnload{
    [self.motionMonitor stopAccelerometer];
    [self.motionMonitor stopGyros];
    [self.motionMonitor stopMagnetometer];
    [super viewDidUnload];
    [self.cubes makeObjectsPerformSelector:@selector(tearDownGL)];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // TODO: Implement
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // A segue is about to be performed. This is our chance to send data to the
    // view controller that will be loaded.
	if ([segue.identifier isEqualToString:@"segueThereminToSettings"])
	{
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminSettingsViewController* viewController = (VWWThereminSettingsViewController*)[[navigationController viewControllers]objectAtIndex:0];
		viewController.delegate = self;
        viewController.settings = self.settings;
        viewController.motion = self.motionMonitor;
	}
    else if ([segue.identifier isEqualToString:@"segue_VWWThereminHelpViewController"]){
		UINavigationController* navigationController = segue.destinationViewController;
		VWWThereminHelpViewController* viewController = (VWWThereminHelpViewController*)[[navigationController viewControllers]objectAtIndex:0];
		viewController.delegate = self;
    }
}





#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // OpenGL
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    self.touchBegan = [touch locationInView:nil];
    

    // Synth
    if(touch.tapCount == 2){
        // double tap
    }
    else if(touch.tapCount == 1){
        [self touchEvent:touches withEvent:event];
    }
    
    [self.settings start];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    self.touchMoved = [touch locationInView:nil];
    CGFloat rotateX = self.touchBegan.x - self.touchMoved.x;
    CGFloat rotateY = self.touchBegan.y - self.touchMoved.y;
    for(VWWCubeScene* cube in self.cubes){
        cube.rotate = GLKVector3Make(rotateX, rotateY, 0);
    }
    
    // Synth
    if(touch.tapCount == 2){
        // double tap
    }
    else if(touch.tapCount == 1){
        [self touchEvent:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    
    // Synth
    self.selectedPixel = CGPointMake(0, 0);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
}


- (void)touchEvent:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch* touch in [event allTouches]){
        CGPoint point = [touch locationInView:self.view];
        
        // This will catch if the user dragged their finger out of bounds of the UIImageView
        if (!CGRectContainsPoint(self.view.bounds, point)){
            return;
        }
        
        self.selectedPixel = point;
        float newTouchValue = (self.view.bounds.size.height - point.y) / self.view.bounds.size.height;
        self.settings.touchValue = newTouchValue;
    }
}

-(void)printMethod:(char*)method withTouches:(NSSet*)touches withEvent:(UIEvent*)event{
    NSArray *touchesArray = [touches allObjects];
    NSMutableString* s = [NSMutableString new];
    for(int index = 0; index < touches.count; index++){
        UITouch *touch = (UITouch *)[touchesArray objectAtIndex:index];
        CGPoint point = [touch locationInView:nil];
        [s appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
//    NSLog(@"%s numTouches:%d %@", method, touches.count, s);
    if(touches.count > 2){
        self.paused = !self.paused;
    }
}

#pragma mark - Custom methods

-(void)initializeClass{
    
    // settings is a controller for the synthesizer.
    // We will use this single pointer throughout the app.
    // Occasionally shared with other controllers
    self.settings = [[VWWThereminSynthesizerSettings alloc]init];
    
    self.motionMonitor = [[VWWMotionMonitor alloc]init];
    self.motionMonitor.delegate = self;
}

-(void)createCubeScene{
    
    self.cubes = [[NSMutableArray alloc] init];

//    float cubeWidth = 4.0;
//    float z = 1;
    VWWCubeScene* cubes[1] = {};

    
    cubes[0] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
    cubes[0].translate = GLKVector3Make(0, 0, 13);
    [self.cubes addObject:cubes[0]];

    
  
    
}

-(void)createGLView{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view.context = self.context;
    self.view.delegate = self;
    self.view.drawableColorFormat = GLKViewDrawableColorFormatRGB565;   // consumes less resources than RGBA8888
    self.view.drawableDepthFormat = GLKViewDrawableDepthFormat16;       // probably need this for 3D
}


#pragma mark - Implements GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);
    [self.cubes makeObjectsPerformSelector:@selector(render)];
}

#pragma mark - Implements GLKViewControllerDelegate
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
//    NSLog(@"%s", __FUNCTION__);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller{
//    NSLog(@"%s", __FUNCTION__);
}

- (void)update{
    [self.cubes makeObjectsPerformSelector:@selector(update)];
}



- (IBAction)settingsButtonHandler:(id)sender {
    [self performSegueWithIdentifier:@"segueThereminToSettings" sender:self];
}

- (IBAction)aboutButtonHandler:(id)sender {
}

#pragma mark = Implements VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
    self.settings.accelerometerValue = device.x.currentNormalized;
    self.lblAccelerometer.text = [NSString stringWithFormat:@"Accelerometer\n"
                                  "(min, current, max):\n"
                                  "X; %f < %f < %f\n"
                                  "Y; %f < %f < %f\n"
                                  "Z; %f < %f < %f\n",
                                  device.x.min,
                                  device.x.current,
                                  device.x.max,
                                  device.y.min,
                                  device.y.current,
                                  device.y.max,
                                  device.z.min,
                                  device.z.current,
                                  device.z.max];
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
    self.settings.magnetometerValue = device.x.currentNormalized;
    self.lblMagnetometer.text = [NSString stringWithFormat:@"Magnetometer\n"
                                 "(min, current, max):\n"
                                 "X; %f < %f < %f\n"
                                 "Y; %f < %f < %f\n"
                                 "Z; %f < %f < %f\n",
                                 device.x.min,
                                 device.x.current,
                                 device.x.max,
                                 device.y.min,
                                 device.y.current,
                                 device.y.max,
                                 device.z.min,
                                 device.z.current,
                                 device.z.max];
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
    self.settings.gyroValue = device.x.currentNormalized;
    self.lblGyros.text = [NSString stringWithFormat:@"Gyro\n"
                          "(min, current, max):\n"
                          "X; %f < %f < %f\n"
                          "Y; %f < %f < %f\n"
                          "Z; %f < %f < %f\n",
                          device.x.min,
                          device.x.current,
                          device.x.max,
                          device.y.min,
                          device.y.current,
                          device.y.max,
                          device.z.min,
                          device.z.current,
                          device.z.max];
}

#pragma mark - Implements VWWThereminHelpViewControllerDelegate
-(void)userIsDoneWithHelp{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWThereminSettingsViewControllerDelegate
-(void)userIsDoneWithSettings{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userIsCancelledSettings{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userSetAccelerometerInput:(bool)enabled{
    self.lblAccelerometer.hidden = !enabled;
}
-(void)userSetMagnetometerInput:(bool)enabled{
    self.lblMagnetometer.hidden = !enabled;
}
-(void)userSetGyroInput:(bool)enabled{
    self.lblGyros.hidden = !enabled;
}
-(void)userSetTouchInput:(bool)enabled{
    // TODO: implement touch blocking?
}
@end
