//
//  SpazioAderenteLoginViewController.m
//  PrevimodaApp
//
//  Created by Daniele on 05/09/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#import "SpazioAderenteLoginViewController.h"
#import "NSString+MD5.h"

@interface SpazioAderenteLoginViewController ()

@end

@implementation SpazioAderenteLoginViewController

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
    [self createTapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton*)sender {
    [self closeKeyboard];
    //Check internet connection
    if (![ConnectionHandler checkInternetConnection]) {
#if defined (DEBUG) || defined (ADHOC)
        [self createHomeView];
#else
        return;
#endif
    }
    NSString *codiceAderente = [self.userField text];
    NSString *password = [self.pswField text];
//    LOG(@"User: %@",codiceAderente);
//    LOG(@"Psw: %@",password);
    UIAlertView *errorField = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if (!codiceAderente || [codiceAderente isEqualToString:@""]) {
        [errorField setMessage:@"Inserire il codice aderente"];
        [errorField show];
        [self.userField becomeFirstResponder];
        return;
    }
    if (!password || [password isEqualToString:@""]) {
        [errorField setMessage:@"Inserire la password"];
        [errorField show];
        [self.pswField becomeFirstResponder];
        return;
    }
    
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    user.codiceAderente = codiceAderente;
    user.password = password;
    
    NSString *md5Password = [password MD5];
    [self.appDelegate.connectionHandler createRequestForAction:Login withHttpMethod:fondimatica_post andBody:md5Password];
}

- (void) connectionHandlerDidFinishAction:(ActionName)action {
//    LOG(@"Action: %d",action);
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    
    switch (action) {
        case Login:
            user.checkLogin = true;
            user.logged = true;
            [self.appDelegate.connectionHandler createRequestForAction:Anagrafica withHttpMethod:fondimatica_get andBody:nil];
            break;
        case Recapiti:
            user.checkDownloadRecapiti = true;
            [self.appDelegate.connectionHandler createRequestForAction:Rendimento withHttpMethod:fondimatica_get andBody:nil];
            break;
        case Rendimento:
            user.checkDownloadRendimento = true;
            [self.appDelegate.connectionHandler createRequestForAction:Contributi withHttpMethod:fondimatica_get andBody:nil];
            break;
        case Anagrafica:
            user.checkDownloadAnagrafica = true;
            
            [self.appDelegate.connectionHandler createRequestForAction:Recapiti withHttpMethod:fondimatica_get     andBody:nil];
            break;
        case Contributi:
            user.checkDownloadContributi = true;
            break;
        default:
            break;
    }
//    LOG(@"Actions: Anagrafica-%d Recapiti-%d Rendimento-%d Contributi-%d",user.checkDownloadAnagrafica,user.checkDownloadRecapiti,user.checkDownloadRendimento,user.checkDownloadContributi);
    if (user.checkLogin && user.checkDownloadAnagrafica && user.checkDownloadContributi && user.checkDownloadRecapiti && user.checkDownloadRendimento) {
        [self createHomeView];
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismiss];
        }
    }

}

- (void) connectionHandlerAction:(ActionName)action didFailWithError:(NSString*)error {
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(error, @"") delegate:self cancelButtonTitle:NSLocalizedString(@"ButtonDone", nil) otherButtonTitles:nil];
    [errorAlert show];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self closeKeyboard];
    [_userField setText:@""];
    [_pswField setText:@""];
}

- (void) createHomeView {
    SpazioAderenteHomeViewController *home = [[SpazioAderenteHomeViewController alloc] initWithNibName:@"SpazioAderenteHomeViewController" bundle:nil];
    [self.navigationController pushViewController:home animated:true];
}

- (void) createTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void) closeKeyboard {
    if ([self.userField isFirstResponder]) {
        
        [self.userField resignFirstResponder];
    }
    if ([self.pswField isFirstResponder]) {
        [self.pswField resignFirstResponder];
    }
}

@end
