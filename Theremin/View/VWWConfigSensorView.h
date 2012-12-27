//
//  VWWConfigSensorView.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWAxisFrequencies.h"

@interface VWWConfigSensorView : UIView
@property (nonatomic, retain) VWWAxisFrequencies* lineFrequenciesMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineFrequenciesMin;
@property (nonatomic, retain) VWWAxisFrequencies* lineXMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineXMin;
@property (nonatomic, retain) VWWAxisFrequencies* lineYMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineYMin;
@property (nonatomic, retain) VWWAxisFrequencies* lineZMax;
@property (nonatomic, retain) VWWAxisFrequencies* lineZMin;
@end
