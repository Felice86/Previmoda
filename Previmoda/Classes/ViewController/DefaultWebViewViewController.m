//
//  DefaultWebViewViewController.m
//  Previmoda
//
//  Created by Daniele on 03/11/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "DefaultWebViewViewController.h"
#import "SVProgressHUD.h"

@interface DefaultWebViewViewController ()

@end

@implementation DefaultWebViewViewController

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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_defaultWebView.scrollView addSubview:refreshControl];
    self.refreshControl = refreshControl;
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    self.refreshing = true;
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"RefreshingData",@"")];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *req = [NSURLRequest requestWithURL:_urlWebView];
            [_defaultWebView setScalesPageToFit:true];
            [_defaultWebView loadRequest:req];
        });
    });
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"LoadingWebView",@"") maskType:SVProgressHUDMaskTypeGradient];
    
    [_defaultWebView setDelegate:self];
    NSURLRequest *req = [NSURLRequest requestWithURL:_urlWebView];
    [_defaultWebView setScalesPageToFit:true];
    [_defaultWebView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    self.refreshing = false;
    [_refreshControl endRefreshing];
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
//    LOG(@"Start");
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    LOG(@"%@",error);
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    self.refreshing = false;
    [_refreshControl endRefreshing];
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
