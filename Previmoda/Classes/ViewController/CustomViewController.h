//
//  CustomViewController.h
//  Previmoda
//
//  Created by Daniele on 22/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SpazioAderenteModel.h"

@interface CustomViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, retain) AppDelegate *appDelegate;
@property (nonatomic) float naviY;

- (UINavigationBar*) thirdNavigation;
- (UINavigationBar*) homeNavigation;

@end
