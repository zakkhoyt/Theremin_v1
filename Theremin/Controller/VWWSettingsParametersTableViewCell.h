//
//  VWWSettingsParametersTableViewCell.h
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kFrequencyKey = @"Frequency";
static NSString *kAmplitudeKey = @"Amplitude";
static NSString *kWaveformKey = @"Waveform";
static NSString *kSensitivityKey = @"Sensitivity";
static NSString *kEffectKey = @"Effect";


@class VWWSettingsParametersTableViewCell;

@protocol VWWSettingsParametersTableViewCellDelegate <NSObject>
-(void)settingsParametersTableViewCellSettingsButtonTouchUpInside:(VWWSettingsParametersTableViewCell*)sender;
@end

@interface VWWSettingsParametersTableViewCell : UITableViewCell
@property (nonatomic, weak) id <VWWSettingsParametersTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *key;
@end
