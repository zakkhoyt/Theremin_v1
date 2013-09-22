//
//  VWWSettingsAxisViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsAxisViewController.h"
#import "VWWSettingsAxisTableViewCell.h"
#import "VWWSettingsParametersViewController.h"

static NSString *kSegueSettingsInputToParameter = @"segueSettingsInputToParameter";

@interface VWWSettingsAxisViewController () <VWWSettingsAxisTableViewCellDelegate>
@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableKeys;
@end

@implementation VWWSettingsAxisViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableKeys = [@[]mutableCopy];
    [self.tableKeys addObject:kXAxisKey];
    [self.tableKeys addObject:kYAxisKey];
    [self.tableKeys addObject:kZAxisKey];

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
        
        
//        [self.navigationController setTitle:self.deviceKey];
        [self setTitle:self.deviceKey];
    }
    
    [self.view layoutSubviews];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kSegueSettingsInputToParameter]){
        VWWSettingsParametersViewController *vc = segue.destinationViewController;
        vc.axisKey = sender;
        vc.deviceKey = self.deviceKey;
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
    VWWSettingsAxisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWSettingsAxisTableViewCell"];
    cell.key = self.tableKeys[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark VWWSettingsAxisTableViewCellDelegate
-(void)settingsAxisTableViewCellSettingsButtonTouchUpInside:(VWWSettingsAxisTableViewCell*)sender{
    [self performSegueWithIdentifier:kSegueSettingsInputToParameter sender:sender.key];
}


@end
