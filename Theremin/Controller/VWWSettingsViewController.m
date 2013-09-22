//
//  VWWSettingsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsViewController.h"
#import "VWWSettingsTableViewCell.h"
#import "VWWSettingsAxisViewController.h"



static NSString* kSegueSettingsToConfigInputAmplitude = @"segueSettingsToConfigInputAmplitude";
static NSString* kSegueSettingsToConfigInputFrequency = @"segueSettingsToConfigInputFrequency";
static NSString* kSegueSettingsToConfigInputWaveform = @"segueSettingsToConfigInputWaveform";
static NSString* kSegueSettingsToConfigInputSensitivity = @"segueSettingsToConfigInputSensitivity";
static NSString* kSegueSettingsToConfigInputEffects = @"segueSettingsToConfigInputEffects";
static NSString* kSegueSettingsToConfigInputKey = @"segueSettingsToConfigInputKey";

static NSString* kSegueSettingsToInput = @"segueSettingsToInput";


@interface VWWSettingsViewController () <VWWSettingsTableViewCellDelegate>
@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableKeys;
@end

@implementation VWWSettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableKeys = [@[]mutableCopy];
    [self.tableKeys addObject:kTouchScreenKey];
    [self.tableKeys addObject:kAccelerometerKey];
    [self.tableKeys addObject:kGyroscopesKey];
    [self.tableKeys addObject:kMagnetometerKey];
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
        [self setTitle:@"Sensors"];
    }
    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueSettingsToInput]){
        VWWSettingsAxisViewController *vc = segue.destinationViewController;
        vc.deviceKey = sender;
    }
}




#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VWWSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWSettingsTableViewCell"];
    cell.key = self.tableKeys[indexPath.row];
    cell.delegate = self;
    return cell;
}



#pragma mark VWWSettingsTableViewCellDelegate
-(void)settingsTableViewCellSettingsButtonTouchUpInside:(VWWSettingsTableViewCell*)sender{
    if([sender.key isEqualToString:kTouchScreenKey]){
        
    }
    else if([sender.key isEqualToString:kAccelerometerKey]){
        
    }
    else if([sender.key isEqualToString:kGyroscopesKey]){
        
    }
    else if([sender.key isEqualToString:kMagnetometerKey]){
        
    }
    
    [self performSegueWithIdentifier:kSegueSettingsToInput sender:sender.key];
}
-(void)settingsTableViewCellEnableSwitchValueChanged:(VWWSettingsTableViewCell*)sender{
    
}




















@end
