//
//  DefaultWebViewViewController.h
//  Previmoda
//
//  Created by Daniele on 03/11/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultWebViewViewController : CustomViewController <UIWebViewDelegate>
- (IBAction)goHome:(UIButton *)sender;
- (IBAction)goBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *defaultWebView;
@property (nonatomic, retain) NSURL *urlWebView;
@property (nonatomic) BOOL refreshing;
@property (nonatomic, retain) UIRefreshControl* refreshControl;
@end
