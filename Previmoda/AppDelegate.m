//
//  AppDelegate.m
//  Previmoda
//
//  Created by Daniele on 16/10/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroViewController.h"
#import <Parse/Parse.h>
#import "Reachability.h"
#import "SVProgressHUD.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.connectionHandler = [[ConnectionHandler alloc] init];
    
    //set Background for loading view
    [SVProgressHUD setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.8]];
    
    //Push Notification
    [Parse setApplicationId:appID clientKey:clKey];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil]];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    }
    
    //Check internet connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        //        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:@"Verify Connection" message:@"Your device is not connect to internet. Please check." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alertNetwork show];
//        LOG(@"There is NOT Internet connection");
    } else {
//        LOG(@"There is Internet connection");
    }
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    IntroViewController *introVC = [[IntroViewController alloc] init];
    
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:introVC];

    [navCtrl setNavigationBarHidden:true];
//    [navCtrl setToolbarHidden:false];
    
    [self.window setRootViewController:navCtrl];
    
    UIImage *imgBk = [UIImage imageNamed:@"Default.png"];
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:imgBk]];
    
    [self.window makeKeyAndVisible];
    
    //    // Create our Installation query
    //    PFQuery *pushQuery = [PFInstallation query];
    //    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    //
    //    // Send push notification to query
    //    [PFPush sendPushMessageToQueryInBackground:pushQuery withMessage:@"Hello World!"];
    
    return YES;
}

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    LOG(@"Device: %@ \n Token: %@",[[UIDevice currentDevice] model],[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    LOG(@"Failed to register for Push %@",error);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) back {
    //nil
}

@end
