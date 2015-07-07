//
//  ModificaView.h
//  Previmoda
//
//  Created by Daniele on 07/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModificaView : UIView
@property (weak,nonatomic) IBOutlet UITextField *telefonoField;
@property (weak,nonatomic) IBOutlet UITextField *cellulareField;
@property (weak,nonatomic) IBOutlet UITextField *emailField;
@property (weak,nonatomic) IBOutlet UILabel *consensoField;
@property (weak,nonatomic) IBOutlet UIButton *modificaBtn;
@property (weak,nonatomic) IBOutlet UIButton *salvaBtn;

@property (nonatomic) BOOL showSalva;

- (IBAction)modificaDati:(id)sender;
- (IBAction)salvaDati:(id)sender;

- (void) closeModifcaView;
- (void) closeFields;
- (void) closeKeyboard;

@end
