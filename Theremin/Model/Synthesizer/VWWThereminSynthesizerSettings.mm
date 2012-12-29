//
//  VWWThereminSynthesizerSettings.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSynthesizerSettings.h"
#import "VWWThereminSynthesizer.h"
#import "VWWThereminNotes.h"


@interface VWWThereminSynthesizerSettings ()
@property (nonatomic, retain) VWWThereminSynthesizer* synthesizer;
@property (nonatomic, retain) VWWThereminNotes* notes;
-(void)initializeClass;
-(void)monitorFrequencyThread;
@end


@implementation VWWThereminSynthesizerSettings

+(VWWThereminSynthesizerSettings *)sharedInstance{
    static VWWThereminSynthesizerSettings* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[VWWThereminSynthesizerSettings alloc]init]; });
    return instance;
}


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
    
    _frequencyMin = VWW_FREQUENCY_MIN;
    _frequencyMax = VWW_FREQUENCY_MAX;
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
    
    self.synthesizer = [[VWWThereminSynthesizer alloc]initWithVolume:self.volume andFrequency:self.frequency];
    [self.synthesizer initializeAUGraph];
    
    self.notes = [[VWWThereminNotes alloc]init];

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
    self.synthesizer = [[VWWThereminSynthesizer alloc]initWithVolume:self.volume andFrequency:self.frequency];
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
