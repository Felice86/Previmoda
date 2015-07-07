//
//  SpazioAderenteLoginViewController.h
//  PrevimodaApp
//
//  Created by Daniele on 05/09/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpazioAderenteHomeViewController.h"

@interface SpazioAderenteLoginViewController : SpazioAderenteCustomViewController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UITextField *userField;
@property (nonatomic, retain) IBOutlet UITextField *pswField;

- (IBAction)login:(UIButton*)sender;

@end
