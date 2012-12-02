//
//  VWWThereminSynthesizer.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See boilerplate code example here:
//  http://timbolstad.com/2010/03/14/core-audio-getting-started/
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "VWWThereminSynthesizerSettings.h"
#include "CAStreamBasicDescription.h"



const Float64 kGraphSampleRate = 44100.0;



@interface VWWThereminSynthesizer : NSObject

@property float volume;
@property float frequency;
@property double sinPhase;
@property WaveType waveType;

//@property (nonatomic, retain) VWWThereminSynthesizerSettings* settings;

-(id)initWithVolume:(float)volume andFrequency:(float)frequency;

- (void)initializeAUGraph;
- (void)startAUGraph;
- (void)stopAUGraph;

//  (2)1/12
//-(void)setNoteAndOctive

@end
