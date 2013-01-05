//
//  VWWThereminAboutViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminAboutViewController.h"

@interface VWWThereminAboutViewController ()
- (IBAction)doneButtonHandler:(id)sender;
@property (retain, nonatomic) IBOutlet UITextView *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *aboutLabel;
@property (retain, nonatomic) IBOutlet UITextView *newsLabel;
@end

@implementation VWWThereminAboutViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load default labels from local string file
    NSString* localString = NSLocalizedStringFromTable (@"VWWThereminAboutViewController.titleLabel.text", @"custom", @"");
    self.titleLabel.text = localString;
    
    localString = NSLocalizedStringFromTable (@"VWWThereminAboutViewController.aboutLabel.text", @"custom", @"");
    self.aboutLabel.text = localString;
    
    localString = NSLocalizedStringFromTable (@"VWWThereminAboutViewController.newsLabel.text", @"custom", @"");
    self.newsLabel.text = localString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate vwwThereminAboutViewControllerUserIsDone:self];
}
- (void)dealloc {
    [_titleLabel release];
    [_aboutLabel release];
    [_newsLabel release];
    [super dealloc];
}
@end
