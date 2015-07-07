//
//  ModificaView.m
//  Previmoda
//
//  Created by Daniele on 07/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "ModificaView.h"

@implementation ModificaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) openFields {
    _telefonoField.enabled = true;
    _telefonoField.borderStyle = UITextBorderStyleRoundedRect;
    _cellulareField.enabled = true;
    _cellulareField.borderStyle = UITextBorderStyleRoundedRect;
    _emailField.enabled = true;
    _emailField.borderStyle = UITextBorderStyleRoundedRect;
}

- (void) closeFields {
    _telefonoField.enabled = false;
    _telefonoField.borderStyle = UITextBorderStyleNone;
    _cellulareField.enabled = false;
    _cellulareField.borderStyle = UITextBorderStyleNone;
    _emailField.enabled = false;
    _emailField.borderStyle = UITextBorderStyleNone;
}

- (IBAction)modificaDati:(id)sender {
    [self openFields];
    _modificaBtn.hidden = true;
    _salvaBtn.hidden = false;
    self.showSalva = true;
}

- (IBAction)salvaDati:(id)sender {
    NSString *emailString =  _emailField.text;
    NSString *telefonoString = _telefonoField.text;
    NSString *cellulareString = _cellulareField.text;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (![self checkEmail:emailString]) {
        [appDelegate.connectionHandler cancelConnection];
        UIAlertView *mailError = [[UIAlertView alloc] initWithTitle:@"Errore" message:NSLocalizedString(@"EmailFormatWrong", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"ButtonDone", @"") otherButtonTitles:nil];
        [mailError show];
        return;
    }
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    NSMutableDictionary *recapitiDictModify = [[NSMutableDictionary alloc] initWithDictionary:user.recapitiDict];
    [recapitiDictModify setObject:telefonoString forKey:ktelefono];
    [recapitiDictModify setObject:cellulareString forKey:kcellulare];
    [recapitiDictModify setObject:emailString forKey:kemail];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:recapitiDictModify options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    [appDelegate.connectionHandler createRequestForAction:Modifica withHttpMethod:fondimatica_post andBody:jsonString];
    
}

- (BOOL) checkEmail:(NSString*)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void) closeModifcaView {
    if (self.showSalva) {
        [self closeFields];
        _salvaBtn.hidden = true;
        _modificaBtn.hidden = false;
    }
}

- (void) closeKeyboard {
    if ([self.telefonoField isFirstResponder]) {
        [self.telefonoField resignFirstResponder];
    }
    if ([self.cellulareField isFirstResponder]) {
        [self.cellulareField resignFirstResponder];
    }
    if ([self.emailField isFirstResponder]) {
        [self.emailField resignFirstResponder];
    }
}

@end
