//
//  VWWThereminConfigInputEffectsViewController.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminConfigInputEffectsViewController.h"
#import "VWWConfigInputEffectsView.h"

@interface VWWThereminConfigInputEffectsViewController ()
@property (nonatomic, retain) IBOutlet UIView* infoView;
@property (nonatomic, retain) IBOutlet VWWConfigInputEffectsView* configView;
- (IBAction)dismissInfoViewButton:(id)sender;
- (IBAction)cancelButtonHandler:(id)sender;
- (IBAction)doneButtonHandler:(id)sender;
@end

@implementation VWWThereminConfigInputEffectsViewController

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

#if defined(VWW_SHOW_INFO_SCREENS)
    [self.view addSubview:self.infoView];
    [self.infoView setFrame:self.view.frame];
    [self.infoView setHidden:NO];
#endif
    
    // Set nav bar title
    switch(self.inputType){
        case kInputAccelerometer:
            self.navigationItem.title = @"Accelerometers";
            break;
        case kInputGyros:
            self.navigationItem.title = @"Gyroscopes";
            break;
        case kInputMagnetometer:
            self.navigationItem.title = @"Magnetometers";
            break;
        case kInputTouch:
            self.navigationItem.title = @"Touch Screen";
            break;
        case kInputNone:
            self.navigationItem.title = @"Invalid Input";
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissInfoViewButton:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        self.infoView.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.infoView removeFromSuperview];
    }];
}

- (IBAction)cancelButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigInputEffectsViewControllerUserCancelled:self];
}

- (IBAction)doneButtonHandler:(id)sender {
    [self.delegate vwwThereminConfigInputEffectsViewControllerUserIsDone:self];
}
- (void)dealloc {
    [super dealloc];
}
@end
