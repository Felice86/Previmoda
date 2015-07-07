//
//  ChiSiamoViewController.m
//  PrevimodaApp
//
//  Created by Daniele on 02/10/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import "ChiSiamoViewController.h"

@interface ChiSiamoViewController ()

@end

@implementation ChiSiamoViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToVideoChiSiamo:(UIButton*)sender {
    if (![ConnectionHandler checkInternetConnection]) {
        return;
    }
    [MenuViewController openSite:[NSString stringWithFormat:url_video,url_video_channel] inViewController:self];
//    if (![ConnectionHandler checkInternetConnection]) {
//        return;
//    }
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *viewInducingVibrancy = [[UIVisualEffectView alloc] initWithEffect:effect];
//    viewInducingVibrancy.frame = self.view.frame;
//    [self.view addSubview:viewInducingVibrancy];
}

@end















