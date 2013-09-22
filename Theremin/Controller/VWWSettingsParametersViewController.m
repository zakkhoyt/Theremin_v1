//
//  VWWSettingsParametersViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <iAd/iAd.h>
#import "VWWSettingsParametersViewController.h"
#import "VWWSettingsParametersTableViewCell.h"
#import "VWWThereminConfigInputAmplitudeViewController.h"
#import "VWWThereminConfigInputFrequencyViewController.h"
#import "VWWThereminConfigInputWaveformsViewController.h"
#import "VWWThereminConfigInputSensitivityViewController.h"
#import "VWWThereminConfigInputEffectsViewController.h"
#import "VWWThereminConfigInputKeyViewController.h"

static NSString* kSegueSettingsToConfigInputAmplitude = @"segueSettingsToConfigInputAmplitude";
static NSString* kSegueSettingsToConfigInputFrequency = @"segueSettingsToConfigInputFrequency";
static NSString* kSegueSettingsToConfigInputWaveform = @"segueSettingsToConfigInputWaveform";
static NSString* kSegueSettingsToConfigInputSensitivity = @"segueSettingsToConfigInputSensitivity";
static NSString* kSegueSettingsToConfigInputEffects = @"segueSettingsToConfigInputEffects";
static NSString* kSegueSettingsToConfigInputKey = @"segueSettingsToConfigInputKey";


@interface VWWSettingsParametersViewController () <VWWSettingsParametersTableViewCellDelegate,
VWWThereminConfigInputAmplitudeViewControllerDelegate,
VWWThereminConfigInputFrequencyViewControllerDelegate,
VWWThereminConfigInputWaveformsViewControllerDelegate,
VWWThereminConfigInputSensitivityViewControllerDelegate,
VWWThereminConfigInputEffectsViewControllerDelegate,
VWWThereminConfigInputKeyViewControllerDelegate,
ADBannerViewDelegate>


@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableKeys;
@property (nonatomic, strong) NSString *parameterKey;
@end

@implementation VWWSettingsParametersViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableKeys = [@[]mutableCopy];
    [self.tableKeys addObject:kFrequencyKey];
    [self.tableKeys addObject:kAmplitudeKey];
    [self.tableKeys addObject:kEffectKey];
    [self.tableKeys addObject:kSensitivityKey];
    [self.tableKeys addObject:kWaveformKey];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(self.hasLoaded == NO){
        self.hasLoaded = YES;
        [self.tableView reloadData];
        
        [self setTitle:self.axisKey];
//        [self.navigationController setTitle:self.deviceKey];
    }
    
    [self.view layoutSubviews];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VWWSettingsParametersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWSettingsParametersTableViewCell"];
    cell.key = self.tableKeys[indexPath.row];
    cell.delegate = self;
    return cell;
}


#pragma mark VWWSettingsParametersTableViewCellDelegate <NSObject>

-(void)settingsParametersTableViewCellSettingsButtonTouchUpInside:(VWWSettingsParametersTableViewCell*)sender{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ %@ %@", self.deviceKey, self.axisKey, sender.key]);
    
    self.parameterKey = sender.key;
    
    // Now we have deviceKey, axisKey, and parameterKey. Nav to the right form
    if([self.parameterKey isEqualToString:kFrequencyKey]){
        [self performSegueWithIdentifier:kSegueSettingsToConfigInputFrequency sender:self];
    }
    else if([self.parameterKey isEqualToString:kAmplitudeKey]){
        [self performSegueWithIdentifier:kSegueSettingsToConfigInputAmplitude sender:self];
    }
    else if([self.parameterKey isEqualToString:kSensitivityKey]){
        [self performSegueWithIdentifier:kSegueSettingsToConfigInputSensitivity sender:self];
    }
    else if([self.parameterKey isEqualToString:kWaveformKey]){
        [self performSegueWithIdentifier:kSegueSettingsToConfigInputWaveform sender:self];
    }
    else if([self.parameterKey isEqualToString:kEffectKey]){
        [self performSegueWithIdentifier:kSegueSettingsToConfigInputEffects sender:self];
    }
    
    
    
    
//    if([self.deviceKey isEqualToString:kTouchScreenKey]){
//        
//    }
//    else if([self.deviceKey isEqualToString:kAccelerometerKey]){
//    }
//    else if([self.deviceKey isEqualToString:kGyroscopesKey]){
//    }
//    else if([self.deviceKey isEqualToString:kMagnetometerKey]){
//    }
    
        
}



#pragma mark - Implements VWWThereminConfigInputFrequencyViewControllerDelegate
-(void)VWWThereminConfigInputFrequencyViewControllerUserIsDone:(VWWThereminConfigInputFrequencyViewController *)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)VWWThereminConfigInputFrequencyViewControllerUserDidCancel:(VWWThereminConfigInputFrequencyViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Implements VWWThereminConfigInputSensitivityViewControllerDelegate
-(void)vwwThereminConfigInputSensitivityViewControllerUserIsDone:(VWWThereminConfigInputSensitivityViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputSensitivityViewControllerUserCancelled:(VWWThereminConfigInputSensitivityViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Implements VWWThereminConfigInputWaveformsViewControllerDelegate
-(void)vwwThereminConfigInputWaveformsViewControllerUserIsDone:(VWWThereminConfigInputWaveformsViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputWaveformsViewControllerUserCancelled:(VWWThereminConfigInputWaveformsViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWThereminConfigInputEffectsViewControllerDelegate
-(void)vwwThereminConfigInputEffectsViewControllerUserIsDone:(VWWThereminConfigInputEffectsViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)vwwThereminConfigInputEffectsViewControllerUserCancelled:(VWWThereminConfigInputEffectsViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWThereminConfigInputAmplitudeViewControllerDelegate
-(void)vwwThereminConfigInputAmplitudeViewControllerUserIsDone:(VWWThereminConfigInputAmplitudeViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Implements VWWThereminConfigInputKeyViewControllerDelegate
-(void)vwwThereminConfigInputKeyViewControllerUserIsDone:(VWWThereminConfigInputKeyViewController*)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
