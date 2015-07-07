//
//  RendimentoDettaglio.m
//  Previmoda
//
//  Created by Daniele on 29/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "RendimentoDettaglio.h"

@implementation RendimentoDettaglio

- (id) init {
    if (self = [super init]) {
        self.anniContribuzione=@"";
        self.controvalore=@"";
        self.dataQuota=@"";
        self.mesiContribuzione=@"";
        self.nomeComparto=@"";
        self.quoteAcquistate=@"";
        self.valoreQuota=@"";
    }
    return self;
}
@end
