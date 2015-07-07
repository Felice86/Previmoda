//
//  ConnectionHandler.m
//  Previmoda
//
//  Created by Daniele on 24/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "ConnectionHandler.h"
#import "SVProgressHUD.h"
#import <Foundation/NSString.h>
#import "Contributo.h"
#import "Reachability.h"

@implementation ConnectionHandler

+ (BOOL) checkInternetConnection {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alertConnection = [[UIAlertView alloc] initWithTitle:@"Nessuna Connessione" message:@"Per accedere a questa sezione devi avere una connessione ad internet attiva." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertConnection show];
        return false;
    }
    return true;
}

- (void) cancelConnection {
    [_connection cancel];
    _connection = nil;
    [SVProgressHUD dismiss];
}

- (void)hudTapped:(NSNotification *)notification
{
    NSLog(@"They tapped the HUD");
    // Cancel logic goes here
    if (_connection) {
        [self cancelConnection];
    }
}

#pragma mark Methods for Controller calls
- (void) createRequestForAction:(ActionName)actionName withHttpMethod:(NSString*)httpMethod andBody:(NSString *)body {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudTapped:) name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
    
    NSMutableURLRequest *urlRequest = nil;
    NSURL *url = nil;
    
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    NSString *codiceAderente = [user codiceAderente];
    
    switch (actionName) {
        case Login:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_login,codiceAderente]];
            LOG(@"User: %@ & Pass: %@",user.codiceAderente,user.password);
            break;
        case Recapiti:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_recapiti,codiceAderente]];
            break;
        case Rendimento:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_rendimento,codiceAderente]];
            break;
        case Anagrafica:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_anagrafica,codiceAderente]];
            break;
        case Contributi:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_contributi,codiceAderente]];
            break;
        case Modifica:
            url = [NSURL URLWithString:[NSString stringWithFormat:fondimatica_modifica,codiceAderente]];
            break;
        default:
            //none
            break;
    }
    
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    
    NSString *credentials = nil;
    
    credentials = [NSString stringWithFormat:@"%@:%@",fondimatica_credential_user,fondimatica_credential_password];
    
    NSString *encodeCredential = [[credentials dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    [urlRequest addValue:[NSString stringWithFormat:@"Basic %@",encodeCredential] forHTTPHeaderField:@"Authorization"];
    [urlRequest addValue:[NSString stringWithFormat:@"%d",actionName] forHTTPHeaderField:@"action"];
    [urlRequest setHTTPMethod:httpMethod];
    [urlRequest setTimeoutInterval:20.0];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (body && ![body isEqualToString:@""]) {
        [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    _connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [_connection start];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", nil) maskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark Response For Controller
- (void) responseFondimatica:(NSData*)data forAction:(ActionName)action {
    NSError *error = nil;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error == nil) {
        SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
        switch (action) {
            case Login: {
                break;
            }
            case Recapiti: {
                [user loadRecapitiUtente:resultDict];
                break;
            }
            case Rendimento: {
                [user loadRendimentoUtente:resultDict];
                break;
            }
            case Anagrafica: {
                [user loadAnagraficaUtente:resultDict];
                break;
            }
            case Contributi: {
                [user loadContributiUtente:resultDict];
                break;
            }
            case Modifica: {
                [user loadModificaUtente:resultDict];
                break;
            }
            default:
                break;
        }
        
        [self.delegate connectionHandlerDidFinishAction:action];
    } else {
        [self responseToDelegate:error.code action:action error:true];
    }
}

#pragma mark Connection Delegate Methods
- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialWithUser:fondimatica_credential_user
                                                                     password:fondimatica_credential_password
                                                                  persistence:NSURLCredentialPersistenceForSession];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            LOG (@"failed authentication");
            ActionName action = [self findActionName:[connection.currentRequest.allHTTPHeaderFields valueForKey:@"action"]];
            [self responseToDelegate:0 action:action error:true];
            [[challenge sender] cancelAuthenticationChallenge:challenge];

        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        int statusCode = (int)[(NSHTTPURLResponse *)response statusCode];
        LOG(@"%s success code %li", __FUNCTION__,(long)statusCode);
        if (statusCode != 200) {
            ActionName action = [self findActionName:[connection.currentRequest.allHTTPHeaderFields valueForKey:@"action"]];
            LOG(@"%s failed status code %d for action %d", __FUNCTION__, statusCode,action);
            [self responseToDelegate:statusCode action:action error:true];
            [connection cancel];
        }
    }
}

- (ActionName) findActionName:(NSString*)action {
    return [action intValue];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
//    LOG(@"%s success; data = %@", __FUNCTION__, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    ActionName action = [self findActionName:[connection.currentRequest.allHTTPHeaderFields valueForKey:@"action"]];
    if (action == Login) {
        NSError *error = nil;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        LOG(@"didReceiveData - resultDict: %@",resultDict);
    }
    if ([data length] > 0) {
        [self responseFondimatica:data forAction:action];
    } else if ([data length] == 0) {
        
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    ActionName action = (ActionName)[connection.currentRequest.allHTTPHeaderFields valueForKey:@"action"];
    if (error != nil) {
        [self responseToDelegate:error.code action:action error:true];
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {

}

- (void) responseToDelegate:(NSInteger)code action:(ActionName)action error:(BOOL)isError {
    LOG(@"%s success code %li", __FUNCTION__,(long)code);
    NSString *errorString = @"";
    if (isError) {
        errorString = [self catchConnectionError:code];
    } else {
        errorString =  [[NSHTTPURLResponse localizedStringForStatusCode:code] capitalizedString];
    }
    
    [self.delegate connectionHandlerAction:action didFailWithError:errorString];
}

- (NSString*) catchConnectionError:(NSInteger)code {
    LOG(@"%s failed errorcode %li", __FUNCTION__,(long)code);
    switch (code) {
        case NSURLErrorTimedOut:
            return NSLocalizedString(@"TimeoutError", @"");
            break;
        case NSURLErrorNetworkConnectionLost:
            return NSLocalizedString(@"ConnectionLost", @"");
            break;
        default:
            return NSLocalizedString(@"GenericError", @"");
            break;
    }
}
@end
