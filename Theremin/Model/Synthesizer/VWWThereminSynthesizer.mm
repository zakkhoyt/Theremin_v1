//
//  VWWThereminSynthesizer.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminSynthesizer.h"

const float M_PI_3_4 = M_PI_2 + M_PI_4;

float square(const float phase){
    float p = 0;
    float r = 0;

    p = phase - floor(phase/M_PI) * M_PI;

    if(p >= 0 && p < M_PI_4){
        r = 1.0;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = 1.0;
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = -1.0;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = -1.0;
    }
    
    return r;
}


float triangle(const float phase){
    float p = 0;
    float r = 0;
    
    p = phase - floor(phase/M_PI) * M_PI;
    
    if(p >= 0 && p < M_PI_4){
        r = p / M_PI_4;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = 1.0 - ((p - M_PI_4) / M_PI_4);
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = -(p - M_PI_2) / M_PI_4;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = -1.0 - (-(p - M_PI_3_4) / M_PI_4);
    }
    return r;
}

float sawtooth(const float phase){
    float p = 0;
    float r = 0;
    
    p = phase - floor(phase/M_PI) * M_PI;
    
    if(p >= 0 && p < M_PI_4){
        r = p / M_PI_4 / 2.0 - 1.0;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = (p - M_PI_4) / M_PI_4 / 2.0 - 0.5;
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = (p - M_PI_2) / M_PI_4 / 2.0;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = (p - M_PI_3_4) / M_PI_4 / 2.0 + 0.5;
    }
    return r;
}


static OSStatus renderInput(void *inRefCon,
                            AudioUnitRenderActionFlags *ioActionFlags,
                            const AudioTimeStamp *inTimeStamp,
                            UInt32 inBusNumber,
                            UInt32 inNumberFrames,
                            AudioBufferList *ioData)
{
	// Get a reference to the object that was passed with the callback
	// In this case, the VWWThereminSynthesizer passed itself so
	// that you can access its data.
	VWWThereminSynthesizer* THIS = (VWWThereminSynthesizer*)inRefCon;
    
	// Get a pointer to the dataBuffer of the AudioBufferList
	AudioSampleType *outA = (AudioSampleType *)ioData->mBuffers[0].mData;
    
	// A constant frequency value.
    float freq = [THIS frequency];
    
	// The amount the phase changes in  single sample
	double phaseIncrement = 2 * M_PI * freq / kGraphSampleRate;
    
	// Pass in a reference to the phase value, you have to keep track of this
	// so that the sin resumes right where the last call left off
    //	float phase = THIS->sinPhase;
    float phase = THIS.sinPhase;
	float sinSignal;
	// Loop through the callback buffer, generating samples for a sine wave
	for (UInt32 i = 0; i < inNumberFrames; ++i) {
        switch(THIS.waveType){
            case kWaveSin:{
                sinSignal = sin(phase);
                break;
            }
            case kWaveSquare:{
                sinSignal = square(phase);
                break;
            }
            case kWaveSawtooth:{
                sinSignal = sawtooth(phase);
                break;
            }
            case kWaveTriangle:{
                sinSignal = triangle(phase);
                break;
            }
            default:
                break;
                
        }

        // Put the sample into the buffer
        // Scale the -1 to 1 values float to
        // -32767 to 32767 and then cast to an integer
        outA[i] = (SInt16)(sinSignal * 32767.0f);
 
        // calculate the phase for the next sample
        phase = phase + phaseIncrement;
        
        // Clip so we dont' overflow
        if (phase > 2 * M_PI * freq) {
            phase -= 2 * M_PI * freq;
        }
    }
    
	// Store the phase for the next callback.
  	THIS.sinPhase = phase;
	return noErr;
}



@interface VWWThereminSynthesizer ()

@property bool isRunning;
@property AUGraph   mGraph;
@property AudioUnit mMixer;
@property CAStreamBasicDescription outputCASBD;

@end




@implementation VWWThereminSynthesizer
@synthesize isRunning = _isRunning;
@synthesize volume = _volume;
@synthesize frequency = _frequency;
@synthesize mGraph = _mGraph;
@synthesize mMixer = _mMixer;
@synthesize outputCASBD = _outputCASBD;
@synthesize sinPhase = _sinPhase;
@synthesize waveType = _waveType;

-(id)initWithVolume:(float)volume andFrequency:(float)frequency{
    self = [super init];
    if(self){
        self.frequency = frequency;
        self.volume = volume;
        self.waveType = kWaveSin;
        self.isRunning = NO;
    }
    return self;
}

// Clean up memory
- (void)dealloc {
    
    DisposeAUGraph(_mGraph);
    [super dealloc];
}

#pragma mark - Custom methods

// starts render
- (void)startAUGraph
{
    // don't start twice
    if(self.isRunning) return;
    self.isRunning = YES;
    
	// Start the AUGraph
	OSStatus result = AUGraphStart(_mGraph);
	// Print the result
	if (result) { printf("AUGraphStart result %d %08X %4.4s\n", (int)result, (int)result, (char*)&result); return; }
}

// stops render
- (void)stopAUGraph
{
    if(!self.isRunning) return;
    self.isRunning = NO;
    
    Boolean isRunning = false;
    
    // Check to see if the graph is running.
    OSStatus result = AUGraphIsRunning(_mGraph, &isRunning);
    // If the graph is running, stop it.
    if (isRunning) {
        result = AUGraphStop(_mGraph);
    }
}

- (void)initializeAUGraph
{
	//************************************************************
	//*** Setup the AUGraph, add AUNodes, and make connections ***
	//************************************************************
	// Error checking result
	OSStatus result = noErr;
    
	// create a new AUGraph
	result = NewAUGraph(&_mGraph);
    
    // AUNodes represent AudioUnits on the AUGraph and provide an
	// easy means for connecting audioUnits together.
    AUNode outputNode;
	AUNode mixerNode;
    
    // Create AudioComponentDescriptions for the AUs we want in the graph
    // mixer component
	AudioComponentDescription mixer_desc;
	mixer_desc.componentType = kAudioUnitType_Mixer;
	mixer_desc.componentSubType = kAudioUnitSubType_MultiChannelMixer;
	mixer_desc.componentFlags = 0;
	mixer_desc.componentFlagsMask = 0;
	mixer_desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    
	//  output component
	AudioComponentDescription output_desc;
	output_desc.componentType = kAudioUnitType_Output;
	output_desc.componentSubType = kAudioUnitSubType_RemoteIO;
	output_desc.componentFlags = 0;
	output_desc.componentFlagsMask = 0;
	output_desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    
    // Add nodes to the graph to hold our AudioUnits,
	// You pass in a reference to the  AudioComponentDescription
	// and get back an  AudioUnit
	result = AUGraphAddNode(_mGraph, &output_desc, &outputNode);
	result = AUGraphAddNode(_mGraph, &mixer_desc, &mixerNode );
    
	// Now we can manage connections using nodes in the graph.
    // Connect the mixer node's output to the output node's input
	result = AUGraphConnectNodeInput(_mGraph, mixerNode, 0, outputNode, 0);
    
    // open the graph AudioUnits are open but not initialized (no resource allocation occurs here)
	result = AUGraphOpen(_mGraph);
    
	// Get a link to the mixer AU so we can talk to it later
	result = AUGraphNodeInfo(_mGraph, mixerNode, NULL, &_mMixer);
    
	//************************************************************
	//*** Make connections to the mixer unit's inputs ***
	//************************************************************
    // Set the number of input busses on the Mixer Unit
	// Right now we are only doing a single bus.
	UInt32 numbuses = 1;
	UInt32 size = sizeof(numbuses);
    result = AudioUnitSetProperty(_mMixer, kAudioUnitProperty_ElementCount, kAudioUnitScope_Input, 0, &numbuses, size);
    
	CAStreamBasicDescription desc;
    
	// Loop through and setup a callback for each source you want to send to the mixer.
	// Right now we are only doing a single bus so we could do without the loop.
	for (int i = 0; i < numbuses; ++i) {
        
		// Setup render callback struct
		// This struct describes the function that will be called
		// to provide a buffer of audio samples for the mixer unit.
		AURenderCallbackStruct renderCallbackStruct;
		renderCallbackStruct.inputProc = &renderInput;
		renderCallbackStruct.inputProcRefCon = self;
        
        // Set a callback for the specified node's specified input
        result = AUGraphSetNodeInputCallback(_mGraph, mixerNode, i, &renderCallbackStruct);
        
		// Get a CAStreamBasicDescription from the mixer bus.
        size = sizeof(desc);
		result = AudioUnitGetProperty(_mMixer,
                                      kAudioUnitProperty_StreamFormat,
                                      kAudioUnitScope_Input,
                                      i,
                                      &desc,
                                      &size);
		// Initializes the structure to 0 to ensure there are no spurious values.
		memset (&desc, 0, sizeof (desc));
        
		// Make modifications to the CAStreamBasicDescription
		// We're going to use 16 bit Signed Ints because they're easier to deal with
		// The Mixer unit will accept either 16 bit signed integers or
		// 32 bit 8.24 fixed point integers.
		desc.mSampleRate = kGraphSampleRate; // set sample rate
		desc.mFormatID = kAudioFormatLinearPCM;
		desc.mFormatFlags      = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
		desc.mBitsPerChannel = sizeof(AudioSampleType) * 8; // AudioSampleType == 16 bit signed ints
		desc.mChannelsPerFrame = 1;
		desc.mFramesPerPacket = 1;
		desc.mBytesPerFrame = ( desc.mBitsPerChannel / 8 ) * desc.mChannelsPerFrame;
		desc.mBytesPerPacket = desc.mBytesPerFrame * desc.mFramesPerPacket;
        
		printf("Mixer file format: "); desc.Print();
		// Apply the modified CAStreamBasicDescription to the mixer input bus
		result = AudioUnitSetProperty(_mMixer,
                                      kAudioUnitProperty_StreamFormat,
                                      kAudioUnitScope_Input,
                                      i,
                                      &desc,
                                      sizeof(desc));
	}
	// Apply the CAStreamBasicDescription to the mixer output bus
	result = AudioUnitSetProperty(_mMixer,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Output,
                                  0,
                                  &desc,
                                  sizeof(desc));
    
	//************************************************************
	//*** Setup the audio output stream ***
	//************************************************************
    
	// Get a CAStreamBasicDescription from the output Audio Unit
    result = AudioUnitGetProperty(_mMixer,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Output,
                                  0,
                                  &desc,
                                  &size);
    
	// Initializes the structure to 0 to ensure there are no spurious values.
	memset (&desc, 0, sizeof (desc));
    
	// Make modifications to the CAStreamBasicDescription
	// AUCanonical on the iPhone is the 8.24 integer format that is native to the iPhone.
	// The Mixer unit does the format shifting for you.
	desc.SetAUCanonical(1, true);
	desc.mSampleRate = kGraphSampleRate;
    
    // Apply the modified CAStreamBasicDescription to the output Audio Unit
	result = AudioUnitSetProperty(_mMixer,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Output,
                                  0,
                                  &desc,
                                  sizeof(desc));
    
    // Once everything is set up call initialize to validate connections
	result = AUGraphInitialize(_mGraph);
}


@end



