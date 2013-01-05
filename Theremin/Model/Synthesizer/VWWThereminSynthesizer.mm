//
//  VWWThereminSynthesizer.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSynthesizer.h"
#import "VWWThereminMath.h"

static float kSampleRate = 44100.0;

OSStatus RenderTone( void* inRefCon,
                       AudioUnitRenderActionFlags  *ioActionFlags,
                       const AudioTimeStamp        *inTimeStamp,
                       UInt32                      inBusNumber,
                       UInt32                      inNumberFrames,
                       AudioBufferList             *ioData){
    
    
	// Get the tone parameters out of the view controller
	VWWThereminSynthesizer *synth = (VWWThereminSynthesizer *)inRefCon;
	double theta = synth.theta;
	double theta_increment = 2.0 * M_PI * synth.frequency / kSampleRate;

	// This is a mono tone generator so we only need the first buffer
	const int channel = 0;
	Float32 *buffer = (Float32 *)ioData->mBuffers[channel].mData;

	// Generate the samples
	for (UInt32 frame = 0; frame < inNumberFrames; frame++)
	{
        switch(synth.waveType){
            case kWaveSin:{
                buffer[frame] = sin(theta) * synth.volume;
                break;
            }
            case kWaveSquare:{
                buffer[frame] = square(theta) * synth.volume;
                break;
            }
            case kWaveSawtooth:{
                buffer[frame] = sawtooth(theta) * synth.volume;
                break;
            }
            case kWaveTriangle:{
                buffer[frame] = triangle(theta) * synth.volume;
                break;
            }
            default:
                break;
                
        }
        
		theta += theta_increment;
		if (theta > 2.0 * M_PI)
		{
			theta -= 2.0 * M_PI;
		}
	}
	
	synth.theta = theta;
    
	return noErr;
}



@interface VWWThereminSynthesizer (){
    AudioComponentInstance _toneUnit;
}

@property bool isRunning;

@end




@implementation VWWThereminSynthesizer

-(id)initWithVolume:(float)volume andFrequency:(float)frequency{
    self = [super init];
    if(self){
        self.frequency = frequency;
        self.volume = volume;
        self.waveType = kWaveSin;
        self.isRunning = NO;
        self.theta = 0;
    }
    return self;
}

// Clean up memory
- (void)dealloc {
    
//    DisposeAUGraph(_mGraph);
    [super dealloc];
}

#pragma mark - Custom methods

// starts render
- (void)start
{
    // don't start twice
    if(self.isRunning) return;
    self.isRunning = YES;
    
    [self createToneUnit];
    
    // Stop changing parameters on the unit
    OSErr err = AudioUnitInitialize(_toneUnit);
    NSAssert1(err == noErr, @"Error initializing unit: %d", err);
    
    // Start playback
    err = AudioOutputUnitStart(_toneUnit);
    NSAssert1(err == noErr, @"Error starting unit: %d", err);
}

// stops render
- (void)stop
{
    if(!self.isRunning) return;
    self.isRunning = NO;

    AudioOutputUnitStop(_toneUnit);
    AudioUnitUninitialize(_toneUnit);
    AudioComponentInstanceDispose(_toneUnit);
    _toneUnit = nil;
}

- (void)createToneUnit
{
	// Configure the search parameters to find the default playback output unit
	// (called the kAudioUnitSubType_RemoteIO on iOS but
	// kAudioUnitSubType_DefaultOutput on Mac OS X)
	AudioComponentDescription defaultOutputDescription;
	defaultOutputDescription.componentType = kAudioUnitType_Output;
	defaultOutputDescription.componentSubType = kAudioUnitSubType_RemoteIO;
	defaultOutputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
	defaultOutputDescription.componentFlags = 0;
	defaultOutputDescription.componentFlagsMask = 0;
	
	// Get the default playback output unit
	AudioComponent defaultOutput = AudioComponentFindNext(NULL, &defaultOutputDescription);
	NSAssert(defaultOutput, @"Can't find default output");
	
	// Create a new unit based on this that we'll use for output
	OSErr err = AudioComponentInstanceNew(defaultOutput, &_toneUnit);
	NSAssert1(_toneUnit, @"Error creating unit: %d", err);
	
	// Set our tone rendering function on the unit
	AURenderCallbackStruct input;
	input.inputProc = RenderTone;
	input.inputProcRefCon = self;
	err = AudioUnitSetProperty(_toneUnit,
                               kAudioUnitProperty_SetRenderCallback,
                               kAudioUnitScope_Input,
                               0,
                               &input,
                               sizeof(input));
	NSAssert1(err == noErr, @"Error setting callback: %d", err);
	
	// Set the format to 32 bit, single channel, floating point, linear PCM
	const int four_bytes_per_float = 4;
	const int eight_bits_per_byte = 8;
	AudioStreamBasicDescription streamFormat;
	streamFormat.mSampleRate = kSampleRate;
	streamFormat.mFormatID = kAudioFormatLinearPCM;
	streamFormat.mFormatFlags =
    kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
	streamFormat.mBytesPerPacket = four_bytes_per_float;
	streamFormat.mFramesPerPacket = 1;
	streamFormat.mBytesPerFrame = four_bytes_per_float;
	streamFormat.mChannelsPerFrame = 1;
	streamFormat.mBitsPerChannel = four_bytes_per_float * eight_bits_per_byte;
	err = AudioUnitSetProperty (_toneUnit,
                                kAudioUnitProperty_StreamFormat,
                                kAudioUnitScope_Input,
                                0,
                                &streamFormat,
                                sizeof(AudioStreamBasicDescription));
	NSAssert1(err == noErr, @"Error setting stream format: %dd", err);
}


@end



