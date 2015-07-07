//
//  IntroViewController.h
//  PrevimodaApp
//
//  Created by Daniele on 05/08/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sfondoImageView;

- (IBAction)enter:(UIButton *)sender;

@end
