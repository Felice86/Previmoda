//
//  MenuViewController.h
//  PrevimodaApp
//
//  Created by Daniele on 05/08/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
- (IBAction)openChiSiamo:(UIButton *)sender;
- (IBAction)openNews:(UIButton *)sender;
- (IBAction)openContatti:(UIButton *)sender;
- (IBAction)openVideo:(UIButton *)sender;
- (IBAction)openSpazioAderente:(UIButton *)sender;
- (IBAction)goVaiAlSito:(UIButton *)sender;

+ (void) openSite:(NSString*)stringURL inViewController:(UIViewController*)vc; 
//- (void) createViewControllerWithHeader:(NSString*)headerImage andContainer:(NSString*)container;

@end
