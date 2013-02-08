//
//  VWWThereminEffectNoteKey.m
//  Theremin
//
//  Created by Zakk Hoyt on 1/7/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminEffectNoteKey.h"

static __attribute ((unused)) NSString* kKeyKey = @"key";
static __attribute ((unused)) NSString* kKeyAMinor = @"aminor";
static __attribute ((unused)) NSString* kKeyAMajor = @"amajor";
static __attribute ((unused)) NSString* kKeyBMinor = @"bminor";
static __attribute ((unused)) NSString* kKeyBMajor = @"bmajor";
static __attribute ((unused)) NSString* kKeyCMajor = @"cmajor";
static __attribute ((unused)) NSString* kKeyDMinor = @"dminor";
static __attribute ((unused)) NSString* kKeyDMajor = @"dmajor";
static __attribute ((unused)) NSString* kKeyEMinor = @"eminor";
static __attribute ((unused)) NSString* kKeyEMajor = @"emajor";
static __attribute ((unused)) NSString* kKeyFMajor = @"fmajor";
static __attribute ((unused)) NSString* kKeyGMinor = @"gminor";
static __attribute ((unused)) NSString* kKeyGMajor = @"gmajor";
static __attribute ((unused)) NSString* kKeyChromatic = @"chromatic";

@implementation VWWThereminEffectNoteKey
-(NSString*)stringForKey{
    switch(self.key){
        case kNoteKeyAMinor:
            return kKeyAMinor;
        case kNoteKeyAMajor:
            return kKeyAMajor;
        case kNoteKeyBMinor:
            return kKeyBMinor;
        case kNoteKeyBMajor:
            return kKeyBMajor;
        case kNoteKeyCMajor:
            return kKeyCMajor;
        case kNoteKeyDMinor:
            return kKeyDMinor;
        case kNoteKeyDMajor:
            return kKeyDMajor;
        case kNoteKeyEMinor:
            return kKeyEMinor;
        case kNoteKeyEMajor:
            return kKeyEMajor;
        case kNoteKeyFMajor:
            return kKeyFMajor;
        case kNoteKeyGMinor:
            return kKeyAMinor;
        case kNoteKeyGMajor:
            return kKeyAMajor;
        case kNoteKeyChromatic:
        default:
            return kKeyChromatic;
    }
}
-(NoteKey)keyFromString:(NSString*)keyString{
    if([keyString isEqualToString:kKeyAMinor]){
        return kNoteKeyAMinor;
    }
    else if([keyString isEqualToString:kKeyAMajor]){
        return kNoteKeyAMajor;
    }
    else if([keyString isEqualToString:kKeyBMinor]){
        return kNoteKeyBMinor;
    }
    else if([keyString isEqualToString:kKeyBMajor]){
        return kNoteKeyBMajor;
    }
    else if([keyString isEqualToString:kKeyCMajor]){
        return kNoteKeyCMajor;
    }
    else if([keyString isEqualToString:kKeyDMinor]){
        return kNoteKeyDMinor;
    }
    else if([keyString isEqualToString:kKeyDMajor]){
        return kNoteKeyDMajor;
    }
    else if([keyString isEqualToString:kKeyEMinor]){
        return kNoteKeyEMinor;
    }
    else if([keyString isEqualToString:kKeyEMajor]){
        return kNoteKeyEMajor;
    }
    else if([keyString isEqualToString:kKeyFMajor]){
        return kNoteKeyFMajor;
    }
    else if([keyString isEqualToString:kKeyGMinor]){
        return kNoteKeyGMinor;
    }
    else if([keyString isEqualToString:kKeyGMajor]){
        return kNoteKeyGMajor;
    }
    else /* if([keyString isEqualToString:kKeyChromatic]) */ {
        return kNoteKeyChromatic;
    }
}

@end
