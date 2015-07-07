//
//  CustomViewController.m
//  Previmoda
//
//  Created by Daniele on 22/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "CustomViewController.h"
#import "SpazioAderenteCustomViewController.h"
#import "SpazioAderenteLoginViewController.h"
#import "SpazioAderenteHomeViewController.h"

enum AlertType: NSInteger {
    AlertType_logout = 1,
    AlertType_home = 2
};

enum BarButtonType: NSInteger {
    BarButtonType_logout = 1,
    BarButtonType_back = 2
};

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self styleNavBar];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) styleNavBar {
    UINavigationBar *navBar = nil;
    
    if ([self isKindOfClass:[SpazioAderenteHomeViewController class]]) {
        navBar = [self homeNavigation];
    } else {
        navBar = [self simpleNavigation];
    }
    
    
    [self.view addSubview:navBar];
}

- (UINavigationBar*) defaultNavigation:(NSString*)backgroundImage withOtherButtons:(NSArray*)buttons {
    float widthBtnHome = IS_IPAD?190.0f:80.0f;
    float widthBtnBack = IS_IPAD?260.0f:110.0f;
    float widthBtnLogout = IS_IPAD?170.0f:70.0f;
    
    UIImage *backgroundNavImage = [UIImage imageNamed:backgroundImage];
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-backgroundNavImage.size.height, CGRectGetWidth(self.view.bounds), backgroundNavImage.size.height)];
    CGRect navRect = newNavBar.frame;
    navRect.origin.y = SCREEN_HEIGHT-navRect.size.height;
    newNavBar.frame = navRect;
    self.naviY = navRect.origin.y;
    [newNavBar setBackgroundImage:backgroundNavImage forBarMetrics:UIBarMetricsDefault];
    
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    /* HOME */
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, widthBtnHome, newNavBar.frame.size.height)];
    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
//    [homeButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:.25]];
    UIBarButtonItem *homeBarButton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
    
    for (NSNumber *type in buttons) {

        UIBarButtonItem *defaultBarButton = nil;
        UIButton *defaultButton = nil;
        switch ([type intValue]) {
            case BarButtonType_back:
                defaultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, widthBtnBack, newNavBar.frame.size.height)];
                [defaultButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
                break;
            case BarButtonType_logout:
                defaultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, widthBtnLogout, newNavBar.frame.size.height)];
                [defaultButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        
//        [defaultButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:.25]];
        defaultBarButton = [[UIBarButtonItem alloc] initWithCustomView:defaultButton];
        
        [rightButtons addObject:defaultBarButton];
    }

    [newItem setLeftBarButtonItem:homeBarButton];
    [newItem setRightBarButtonItems:rightButtons];
    
    [newNavBar setItems:@[newItem]];

    return newNavBar;
}

- (UINavigationBar*) homeNavigation {
    UINavigationBar *newNavBar = [self defaultNavigation:@"navigatore_2.png" withOtherButtons:@[[NSNumber numberWithInt:BarButtonType_logout]]];
    
    return newNavBar;
}

- (UINavigationBar*) thirdNavigation {
    UINavigationBar *newNavBar = [self defaultNavigation:@"navigatore_3.png" withOtherButtons:@[[NSNumber numberWithInt:BarButtonType_logout],[NSNumber numberWithInt:BarButtonType_back]]];
    
    return newNavBar;
}

- (UINavigationBar*) simpleNavigation {
    UINavigationBar *newNavBar = [self defaultNavigation:@"Navigatore.png" withOtherButtons:@[[NSNumber numberWithInt:BarButtonType_back]]];
    
    return newNavBar;
}

- (void) back {
    [self.navigationController popViewControllerAnimated:true];
}

- (void) home {
    if ([self isKindOfClass:[SpazioAderenteCustomViewController class]]) {
        UIAlertView *alertHome = [[UIAlertView alloc] initWithTitle:@"Home" message:@"Sarà effettuato il logout. Proseguire?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
        alertHome.tag = AlertType_home;
        [alertHome show];
    } else {
        [self.navigationController popToRootViewControllerAnimated:true];
    }
}

- (void) logout {
    UIAlertView *alertLogout = [[UIAlertView alloc] initWithTitle:@"Esci" message:@"Confermi di voler uscire dal tuo account?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
    alertLogout.tag = AlertType_logout;
    [alertLogout show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[SpazioAderenteModel sharedInstance] doLogout];
        switch (alertView.tag) {
            case AlertType_home:
                [self.navigationController popToRootViewControllerAnimated:true];
                break;
            case AlertType_logout:
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:SpazioAderenteLoginViewController.class]) {
                        [self.navigationController popToViewController:vc animated:true];
                        break;
                    }
                }
                break;
            default:
                break;
        }
    } else {
        //do nothing
    }
}

@end
