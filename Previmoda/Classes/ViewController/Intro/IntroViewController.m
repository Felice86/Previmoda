//
//  IntroViewController.m
//  PrevimodaApp
//
//  Created by Daniele on 05/08/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import "IntroViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface IntroViewController ()

@end

@implementation IntroViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enter:(UIButton *)sender {

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    [UIView transitionWithView:appDelegate.window duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        [self.navigationController setViewControllers:@[menuVC] animated:NO];
        
    } completion:nil];
}

@end
