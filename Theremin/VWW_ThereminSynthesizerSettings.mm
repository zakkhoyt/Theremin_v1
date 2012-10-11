//
//  VWW_ThereminSynthesizerSettings.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWW_ThereminSynthesizerSettings.h"
#import "VWW_ThereminSynthesizer.h"
#import "VWW_ThereminNotes.h"


@interface VWW_ThereminSynthesizerSettings ()
@property (nonatomic, retain) VWW_ThereminSynthesizer* synthesizer;
@property (nonatomic, retain) VWW_ThereminNotes* notes;
-(void)initializeClass;
-(void)monitorFrequencyThread;
@end


@implementation VWW_ThereminSynthesizerSettings
// private vars
@synthesize synthesizer = _synthesizer;
@synthesize notes = _notes;

// public vars
@synthesize running = _running;

@synthesize frequencyMin = _frequencyMin;
@synthesize frequencyMax = _frequencyMax;
@synthesize volumeMin = _volumeMin;
@synthesize volumeMax = _volumeMax;

@synthesize touchValue = _touchValue;
@synthesize accelerometerValue = _accelerometerValue;
@synthesize magnetometerValue = _magnetometerValue;
@synthesize gyroValue = _gyroValue;

@synthesize touchSensitivity = _touchSensitivity;
@synthesize accelerometerSensitivity = _accelerometerSensitivity;
@synthesize magnetometerSensitivity = _magnetometerSensitivity;
@synthesize gyroSensitivity = _gyroSensitivity;

-(id)init{
    self = [super init];
    if(self){
        [self initializeClass];
        [NSThread detachNewThreadSelector:@selector(monitorFrequencyThread) toTarget:self withObject:nil];
    }
    return self;
}



- (void)dealloc {
    
	[self.synthesizer stopAUGraph];
	[self.synthesizer release];

    [super dealloc];
}


#pragma mark Custom action methods
-(void)initializeClass{
    
    _volume = 100;
    _frequency = 440;
    _waveType = kWaveSin;
    _inputType = kInputTouch;
    _effectType = kEffectNone;
    
    _running = NO;
    
    _frequencyMin = 30.0;
    _frequencyMax = 2500.0;
    _volumeMin = 0.0;
    _volumeMax = 1.0;
    
    _touchValue = 1.0;
    _accelerometerValue = 0.0;
    _magnetometerValue = 0.0;
    _gyroValue = 0.0;
    
    _touchSensitivity = 1.0;
    _accelerometerSensitivity = 1.0;
    _magnetometerSensitivity = 1.0;
    _gyroSensitivity = 1.0;
    
    self.synthesizer = [[VWW_ThereminSynthesizer alloc]initWithVolume:self.volume andFrequency:self.frequency];
    [self.synthesizer initializeAUGraph];
    
    self.notes = [[VWW_ThereminNotes alloc]init];

}

// This method continuously runs in a thread and augments the frequency based on
// input methods and effects. 
-(void)monitorFrequencyThread{
    while(YES){
        @synchronized(self)
        {
            float newFrequency = ((_frequencyMax - _frequencyMin) * _touchValue) + _frequencyMin;
            self.frequency = newFrequency;
            if((_inputType & kInputAccelerometer) == kInputAccelerometer){
                self.frequency = self.frequency * _accelerometerValue;
            }
            
            if((_inputType & kInputMagnetometer) == kInputMagnetometer){
                self.frequency = self.frequency * _magnetometerValue;
            }
            
            if((_inputType & kInputGyros) == kInputGyros){
                self.frequency = self.frequency * _gyroValue;
            }
            
            if((_inputType * kInputTouch) == kInputTouch){
                self.frequency = self.frequency;
            }
        
            // Apply self.frequency to self.synthesizer.frequency
            if(_effectType == kEffectAutoTune){
                self.synthesizer.frequency = [self.notes getClosestNote:self.frequency];
            }
            // TODO implement cases for other effects
            else if(_effectType == kEffectNone){
                self.synthesizer.frequency = self.frequency;
            }
//            NSLog(@"frequency = %f", self.synthesizer.frequency);
        }
    }
}



-(void)restart{
    if(self.synthesizer){
        [self.synthesizer release];
    }
    self.synthesizer = [[VWW_ThereminSynthesizer alloc]initWithVolume:self.volume andFrequency:self.frequency];
    [self.synthesizer initializeAUGraph];
}
-(void)start{
    if(self.running == NO){
        [self.synthesizer startAUGraph];
        self.running = YES;
    }
}
-(void)stop{
    if(self.running == YES){
        [self.synthesizer stopAUGraph];
        self.running = NO;
    }
}


#pragma mark Setter/Getter implementation

// We are manually implementing this because it is a case of setting
// and clearing individual bits
-(u_int32_t)inputType{
    return _inputType;
}
-(void)setInputType:(InputType)newInputType{
    _inputType |= newInputType;
}
-(void)clearInputType:(InputType)newInputType{
    _inputType &= ~newInputType;
}


-(WaveType)waveType{
    return _waveType;
}

-(void)setWaveType:(WaveType)newWaveType{
    _waveType = newWaveType;
    self.synthesizer.waveType = _waveType;
}

@end
