//
//  ThereminTests.m
//  ThereminTests
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "ThereminTests.h"
#import "VWWThereminNotes.h"

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

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in ThereminTests");
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
