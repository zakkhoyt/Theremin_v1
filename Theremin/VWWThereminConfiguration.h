
//
//  VWWThereminConfiguration.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWThereminConfiguration_h
#define Theremin_VWWThereminConfiguration_h

// Temporary in order to not render for release 1.0
#define VWW_SKIP_RENDERING_CALL     1


// Max/min frequency that can be reached by any channel
#define VWW_FREQUENCY_MAX           2500.0
#define VWW_FREQUENCY_MIN           20.0

// Default max/min for each channel
#define VWW_INPUT_FREQUENCY_MAX     2000.0
#define VWW_INPUT_FREQUENCY_MIN     30.0
#define VWW_WAVETYPE                kWaveSin
#define VWW_SENSITIVITY             1.0
#define VWW_EFFECT                  kEffectNone
#define VWW_INPUT_TYPE              kInputTouch
#define VWW_AMPLITUDE               1.0
#define VWW_NOTE_KEY                kNoteKeyChromatic
#define VWW_MUTED                   YES
#define VWW_SHOW_INFO_SCREENS       1
#define VWW_MAX_CHANNELS            1

#define VWW_DISMISS_INFO_DURATION   0.5
#endif
