//
//  VWWThereminNotes.h
//  Theremin
//
//  Created by Zakk Hoyt on 8/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum{
//    kNoteKeyChromatic = 0,
//    kNoteKeyAMinor,
//    kNoteKeyAMajor,
//    kNoteKeyBMinor,
//    kNoteKeyBMajor,
//    kNoteKeyCMajor,
//    kNoteKeyDMinor,
//    kNoteKeyDMajor,
//    kNoteKeyEMinor,
//    kNoteKeyEMajor,
//    kNoteKeyFMajor,
//    kNoteKeyGMinor,
//    kNoteKeyGMajor,
//} NoteKey;

@interface VWWThereminNotes : NSObject
+(VWWThereminNotes *)sharedInstance;
+(float)getClosestNoteForFrequency:(float)frequency;
+(float)getClosestNoteForFrequency:(float)frequency inKey:(NoteKey)key;
@end
