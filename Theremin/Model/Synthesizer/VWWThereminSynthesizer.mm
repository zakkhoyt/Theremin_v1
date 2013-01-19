//
//  VWWThereminSynthesizer.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSynthesizer.h"
#import "VWWThereminMath.h"
#import "VWWThereminNotes.h"

static float kSampleRate = 44100.0;

OSStatus RenderTone( void* inRefCon,
                       AudioUnitRenderActionFlags  *ioActionFlags,
                       const AudioTimeStamp        *inTimeStamp,
                       UInt32                      inBusNumber,
                       UInt32                      inNumberFrames,
                       AudioBufferList             *ioData){
    

    
	// Get the tone parameters out of the view controller
	VWWThereminSynthesizer *synth = (__bridge VWWThereminSynthesizer *)inRefCon;
	double theta = synth.theta;
	double theta_increment = 2.0 * M_PI * synth.frequency / kSampleRate;

//    // To see how many instances are being created
//    static NSMutableDictionary* d = [NSMutableDictionary new];
//    NSString* value = [NSString stringWithFormat:@"%p", synth];
//    if([d objectForKey:value] != nil){
//        NSLog(@"found %d channels", d.count);
//    }
//    else{
//        [d setObject:value forKey:value];
//    }
    
//    // Print out info, but makes audio choppy
//    static NSUInteger counter = 0;
//    const NSUInteger counterThreshold = 1;
//    if(counter++ >= counterThreshold){
//        int muted = synth.muted ? 1 : 0;
//        NSLog(@"muted:%d amplitude:%f freq:%f self=%x", muted, synth.amplitude,  synth.frequency, (NSUInteger)synth);
//        counter = 0;
//    }


	// This is a mono tone generator so we only need the first buffer
	const int channel = 0;
	Float32 *buffer = (Float32 *)ioData->mBuffers[channel].mData;

	// Generate the samples
	for (UInt32 frame = 0; frame < inNumberFrames; frame++)
	{
        if(synth.muted){
            buffer[frame] = 0;
        }
        else{
            switch(synth.waveType){
                case kWaveSin:{
                    buffer[frame] = sin(theta) * synth.amplitude;
                    break;
                }
                case kWaveSquare:{
                    buffer[frame] = square(theta) * synth.amplitude;
                    break;
                }
                case kWaveSawtooth:{
                    buffer[frame] = sawtooth(theta) * synth.amplitude;
                    break;
                }
                case kWaveTriangle:{
                    buffer[frame] = triangle(theta) * synth.amplitude;
                    break;
                }
                default:
                    break;
                    
            }
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
@property (nonatomic, strong) VWWThereminNotes* notes;
@end




@implementation VWWThereminSynthesizer

-(id)initWithAmplitude:(float)amplitude andFrequency:(float)frequency{
    self = [super init];
    if(self){
        _frequency = frequency;
        _amplitude = amplitude;
        _muted = NO;
        _waveType = kWaveSin;
        _isRunning = NO;
        _theta = 0;
        _notes = [[VWWThereminNotes alloc]init];
    }
    return self;
}

// Clean up memory

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
	input.inputProcRefCon = (__bridge void*)self;
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

-(void)setFrequency:(float)newFrequency{
    if(_effectType == kEffectAutoTune){
        _frequency = [VWWThereminNotes getClosestNoteForFrequency:newFrequency];
    }
    else{
        _frequency = newFrequency;
    }
}

@end



