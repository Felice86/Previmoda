//
//  ContattiViewController.h
//  PrevimodaApp
//
//  Created by Daniele on 02/10/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContattiViewController : CustomViewController

- (IBAction)goHome:(UIButton *)sender;
- (IBAction)goBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *telefonoView;

@end
