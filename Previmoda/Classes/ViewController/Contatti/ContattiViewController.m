//
//  ContattiViewController.m
//  PrevimodaApp
//
//  Created by Daniele on 02/10/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import "ContattiViewController.h"

@interface ContattiViewController ()

@end

@implementation ContattiViewController

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

- (void) viewWillAppear:(BOOL)animated {
    [_telefonoView setTextColor:[UIColor darkGrayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(UIButton *)sender {
//    [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [self.navigationController popToRootViewControllerAnimated:true];
//    } completion:nil];
}

- (IBAction)goBack:(UIButton *)sender {
//    [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [self.navigationController popViewControllerAnimated:true];
//    } completion:nil];
    
}

@end
