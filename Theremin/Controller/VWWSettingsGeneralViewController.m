//
//  VWWSettingsGeneralViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 9/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsGeneralViewController.h"
#import <MessageUI/MessageUI.h>
#import "VWWSettingsKeys.h"



@interface VWWSettingsGeneralViewController () <MFMailComposeViewControllerDelegate>
@property (nonatomic) BOOL hasLoaded;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@end

@implementation VWWSettingsGeneralViewController

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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(self.hasLoaded == NO){
        self.hasLoaded = YES;
        if (![MFMailComposeViewController canSendMail]){
            self.emailButton.enabled = NO;
        }
    }
    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailDefaultsButtonTouchUpInside:(id)sender {
    NSLog(@"%s", __func__);
    
    //Documents/theremin.json
    NSString *docsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    if (![MFMailComposeViewController canSendMail]) return;
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    [compose addAttachmentData:jsonData mimeType:@"application/xml" fileName:@"Theremin.json"];
    compose.mailComposeDelegate = self;
    compose.subject = @"Theremin Configuration";
    [compose setMessageBody:@"Theremin configuration file" isHTML:NO];
    [compose setToRecipients:@[@"vaporwarewolf@gmail.com"]];
    [self presentViewController:compose animated:YES completion:nil];
}



- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
