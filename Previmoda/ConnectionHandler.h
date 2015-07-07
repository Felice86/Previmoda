//
//  ConnectionHandler.h
//  Previmoda
//
//  Created by Daniele on 24/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionHandlerDelegate <NSObject>

@required
- (void) connectionHandlerDidFinishAction:(ActionName)action;
- (void) connectionHandlerAction:(ActionName)action didFailWithError:(NSString*)error;

@end

@interface ConnectionHandler : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (nonatomic, retain) id<ConnectionHandlerDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSString *error;

- (void) createRequestForAction:(ActionName)actionName withHttpMethod:(NSString*)httpMethod andBody:(NSString*)body;

+ (BOOL) checkInternetConnection;
- (void) cancelConnection;

@end
