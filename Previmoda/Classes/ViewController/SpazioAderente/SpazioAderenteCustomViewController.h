//
//  SpazioAderenteCustomViewController.h
//  Previmoda
//
//  Created by Daniele on 04/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpazioAderenteCustomViewController : CustomViewController <ConnectionHandlerDelegate,UITextFieldDelegate>

@property (nonatomic) BOOL keyboardShow;
@property (nonatomic,retain) UITextField* currentField;

@end
