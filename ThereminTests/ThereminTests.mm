//
//  ThereminTests.m
//  ThereminTests
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "ThereminTests.h"
#import "VWWThereminNotes.h"
#import "VWWThereminInputs.h"

@implementation ThereminTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testInputs{
    VWWThereminInputs* inputs = [VWWThereminInputs sharedInstance];
    STAssertNotNil(inputs, @"Failed to create VWWThereminInputs");
    
    VWWThereminInput* accelerometer = [VWWThereminInputs accelerometerInput];
    STAssertNotNil(accelerometer, @"Failed to create VWWThereminInput for accelerometer");
    [self exmineInput:accelerometer];
    
    VWWThereminInput* gyroscope = [VWWThereminInputs gyroscopeInput];
    STAssertNotNil(gyroscope, @"Failed to create VWWThereminInput for gyroscope");

    VWWThereminInput* magnetometer = [VWWThereminInputs magnetometerInput];
    STAssertNotNil(magnetometer, @"Failed to create VWWThereminInput for magnetometer");

    VWWThereminInput* touchscreen = [VWWThereminInputs touchscreenInput];
    STAssertNotNil(touchscreen, @"Failed to create VWWThereminInput for touchscreen");
}

-(void)exmineInput:(VWWThereminInput*)input{
    VWWThereminInputAxis* x = input.x;
    STAssertNotNil(x, @"Failed to create VWWThereminInputAxis for %@", input.description);
    [self examineAxis:x];
    
    VWWThereminInputAxis* y = input.y;
    STAssertNotNil(y, @"Failed to create VWWThereminInputAxis for %@", input.description);
    [self examineAxis:y];
    
    VWWThereminInputAxis* z = input.z;
    STAssertNotNil(z, @"Failed to create VWWThereminInputAxis for %@", input.description);
    [self examineAxis:z];
}

-(void)examineAxis:(VWWThereminInputAxis*)axis{
    STAssertTrue(axis.frequencyMax >= VWW_FREQUENCY_MIN, @"Axis max frequency lower than global min");
    STAssertTrue(axis.frequencyMax <= VWW_FREQUENCY_MAX, @"Axis max frequency lower than global min");
    STAssertTrue(axis.frequencyMin >= VWW_FREQUENCY_MIN, @"Axis min frequency lower than global min");
    STAssertTrue(axis.frequencyMin <= VWW_FREQUENCY_MAX, @"Axis min frequency lower than global min");
    STAssertTrue(axis.sensitivity >= 0, @"Axis sensitivity out of bounds");
    STAssertTrue(axis.sensitivity <= VWW_SENSITIVITY, @"Axis sensitivity out of bounds");    
}

- (void)testAutoTune
{
    VWWThereminNotes* notes = [[VWWThereminNotes alloc]init];
    
    float frequency = 121.3;
    float nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);
    
    frequency = 243.2;
    nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);
    
    frequency = 1234;
    nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);
    
    frequency = 2343.2;
    nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);
    
    frequency = 4432.2;
    nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);

    frequency = 10243.2;
    nearest = [notes getClosestNote:frequency];
    NSLog(@"frequency=%f nearest=%f", frequency, nearest);

    
    [notes release];
}

@end
