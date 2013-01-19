//
//  VWWThereminAboutViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminAboutViewController.h"
#import "VWWThereminAboutView.h"

@interface VWWThereminAboutViewController ()
- (IBAction)doneButtonHandler:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *aboutLabel;
@property (strong, nonatomic) IBOutlet UITextView *newsLabel;
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
    self.navigationItem.title = @"About";
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


//#pragma mark - UIResponder touch events
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//}




- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate vwwThereminAboutViewControllerUserIsDone:self];
}
@end
