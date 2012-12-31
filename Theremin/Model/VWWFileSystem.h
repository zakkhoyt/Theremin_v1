//
//  VWWFileSystem.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/30/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

//<!-- Example XML formatting -->
//<input type="accelerometer>
//    <axis name="x">
//        <fmax>2500</fmax>
//        <fmin>20</fmin>
//        <waveform>square</waveform>
//        <sensitivity>1.0</sensitivity>
//        <effect>none</effect>
//    </axis>
//    <axis name="y">
//        <fmax>2500</fmax>
//        <fmin>20</fmin>
//        <waveform>square</waveform>
//        <sensitivity>1.0</sensitivity>
//        <effect>none</effect>
//    </axis>
//    <axis name="z">
//        <fmax>2500</fmax>
//        <fmin>20</fmin>
//        <waveform>square</waveform>
//        <sensitivity>1.0</sensitivity>
//        <effect>none</effect>
//    </axis>
//</input>

////Example JSON formatting
//{
//    "type" : "touchscreen",
//    "y" : {
//        "fmax" : 300,
//        "sensitivity" : 1,
//        "effect" : "none",
//        "wavetype" : "sin",
//        "fmin" : 20
//    },
//    "z" : {
//        "fmax" : 300,
//        "sensitivity" : 1,
//        "effect" : "none",
//        "wavetype" : "sin",
//        "fmin" : 20
//    },
//    "x" : {
//        "fmax" : 300,
//        "sensitivity" : 1,
//        "effect" : "none",
//        "wavetype" : "sin",
//        "fmin" : 20
//    }
//}
#import <Foundation/Foundation.h>

@interface VWWFileSystem : NSObject
+(bool)configFileExists;
+(NSString*)readFile;
+(bool)writeFile:(NSString*)contents;

@end
