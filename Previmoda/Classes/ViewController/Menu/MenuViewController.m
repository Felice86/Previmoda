//
//  MenuViewController.m
//  PrevimodaApp
//
//  Created by Daniele on 05/08/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "ChiSiamoViewController.h"
#import "ContattiViewController.h"
#import "DefaultWebViewViewController.h"
#import "SpazioAderenteLoginViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    
//#if TARGET_IPHONE_SIMULATOR
    // Do any additional setup after loading the view from its nib.
//    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createSpazioAderenteLoginViewController)];
//    tripleTap.numberOfTapsRequired = 3;
//    [self.view addGestureRecognizer:tripleTap];
    
//    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openNewsReally)];
//    tapTwice.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:tapTwice];
//    
//    [tapTwice requireGestureRecognizerToFail:tripleTap];
//#endif
    
//    Reachability *reachabilityInfo;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:reachabilityInfo];
    
}

//- (void) reachabilityDidChange:(Reachability*)reachabilityInfo {
//    //    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus networkStatus = [reachabilityInfo currentReachabilityStatus];
//    if (networkStatus == NotReachable) {
//        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Connection is not stable. Try to reconnect..." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
//        [alertNetwork show];
//    }
//}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) openNewsReally {
    NSString *stringUrl = [@"http://www.previmoda.it/news/notizie" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringUrl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)openChiSiamo:(UIButton *)sender {
    ChiSiamoViewController *chiSiamoVC = [[ChiSiamoViewController alloc] initWithNibName:@"ChiSiamoViewController" bundle:nil];
    [self.navigationController pushViewController:chiSiamoVC animated:true];
}

- (IBAction)openNews:(UIButton *)sender {
    if (![ConnectionHandler checkInternetConnection]) {
        return;
    }
    [MenuViewController openSite:url_notizie inViewController:self];
}

- (IBAction)openContatti:(UIButton *)sender {
    ContattiViewController *contattiVC = [[ContattiViewController alloc] initWithNibName:@"ContattiViewController" bundle:nil];
    [self.navigationController pushViewController:contattiVC animated:true];
}

- (IBAction)openVideo:(UIButton *)sender {
    if (![ConnectionHandler checkInternetConnection]) {
        return;
    }
    [MenuViewController openSite:[NSString stringWithFormat:url_video,url_video_channel] inViewController:self];
}

- (IBAction)openSpazioAderente:(UIButton *)sender {
//    [MenuViewController openUrlInBrowser:url_login];
#ifdef NO_TEST_LOGIN
    SpazioAderenteHomeViewController *homeVC = [[SpazioAderenteHomeViewController alloc] init];
    [self.navigationController pushViewController:homeVC animated:true];
#else
    SpazioAderenteLoginViewController *loginVC = [[SpazioAderenteLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:true];
#endif
}

- (IBAction)goVaiAlSito:(UIButton *)sender {
    if (![ConnectionHandler checkInternetConnection]) {
        return;
    }
    [MenuViewController openSite:url_previmoda inViewController:self];
}

+ (void) openUrlInBrowser:(NSString*)stringURL {
    NSURL *linkToWebURL = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:linkToWebURL];
}

+ (void) openSite:(NSString*)stringURL inViewController:(UIViewController*)vc {
    NSURL *linkToWebURL = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DefaultWebViewViewController *defaultWVC = [[DefaultWebViewViewController alloc] initWithNibName:@"DefaultWebViewViewController" bundle:nil];
    [defaultWVC setUrlWebView:linkToWebURL];
    [[vc navigationController] pushViewController:defaultWVC animated:true];
}

@end
