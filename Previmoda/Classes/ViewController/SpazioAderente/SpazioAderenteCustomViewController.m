
//  SpazioAderenteCustomViewController.m
//  Previmoda
//
//  Created by Daniele on 04/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "SpazioAderenteCustomViewController.h"
#import "SpazioAderenteHomeViewController.h"

@interface SpazioAderenteCustomViewController ()

@end

@implementation SpazioAderenteCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    self.appDelegate.connectionHandler.delegate = self;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setViewMovedUp:(BOOL)movedUp {
    //    if ([[UIScreen mainScreen] bounds].size.height != 568) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    
    if (movedUp) {
        if (!_keyboardShow) {
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
            rect.size.height += kOFFSET_FOR_KEYBOARD;
            if ([self isKindOfClass:[SpazioAderenteHomeViewController class]]) {
                if ([(SpazioAderenteHomeViewController*)self modificaView].showSalva) {
                    CGRect centerRect = [(SpazioAderenteHomeViewController*)self centerView].frame;
                    centerRect.origin.y -= kOFFSET_FOR_KEYBOARD;
                    centerRect.size.height += kOFFSET_FOR_KEYBOARD;
                    [(SpazioAderenteHomeViewController*)self centerView].frame = centerRect;
                }
            }
            _keyboardShow = true;
        }
    } else {
        if (_keyboardShow) {
            rect.origin.y += kOFFSET_FOR_KEYBOARD;
            rect.size.height -= kOFFSET_FOR_KEYBOARD;
            if ([self isKindOfClass:[SpazioAderenteHomeViewController class]]) {
                if ([(SpazioAderenteHomeViewController*)self modificaView].showSalva) {
                    CGRect centerRect = [(SpazioAderenteHomeViewController*)self centerView].frame;
                    centerRect.origin.y += kOFFSET_FOR_KEYBOARD;
                    centerRect.size.height -= kOFFSET_FOR_KEYBOARD;
                    [(SpazioAderenteHomeViewController*)self centerView].frame = centerRect;
                }
            }
            _keyboardShow = false;
        }
    }
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    //    }
}

- (void) keyboardWillShow {
    //    if (self.view.frame.origin.y >= 0) {
    [self setViewMovedUp:true];
    //    } else {
    //        [self setViewMovedUp:false];
    //    }
}

- (void) keyboardWillHide {
    //    if (self.view.frame.origin.y >= 0) {
    //        [self setViewMovedUp:true];
    //    } else {
    [self setViewMovedUp:false];
    //    }
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    self.currentField = textField;
    if (_keyboardShow) {
        [self setViewMovedUp:true];
    }
    return true;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    self.currentField = nil;
}

@end
