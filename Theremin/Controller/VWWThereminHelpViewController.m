//
//  VWWThereminHelpViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminHelpViewController.h"

@interface VWWThereminHelpViewController ()
- (IBAction)handle_butDone:(id)sender;

@end

@implementation VWWThereminHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handle_butDone:(id)sender {
    if(self.delegate){
        [self.delegate userIsDoneWithHelp];
    }
}
@end
