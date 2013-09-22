//
//  VWWSettingsParametersViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsParametersViewController.h"
#import "VWWSettingsParametersTableViewCell.h"

@interface VWWSettingsParametersViewController () <VWWSettingsParametersTableViewCellDelegate>
@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableKeys;

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
}
@end
