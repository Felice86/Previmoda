//
//  AppDelegate.h
//  Previmoda
//
//  Created by Daniele on 16/10/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"

#if defined (DEBUG) || defined(ADHOC)
//decommentare per rimuovere la login
//    #define NO_TEST_LOGIN
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL userIsLogged;
@property (nonatomic) BOOL hadAnswerToEmail;
@property (nonatomic, retain) ConnectionHandler *connectionHandler;

@end
