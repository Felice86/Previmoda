//
//  Contributo.m
//  Previmoda
//
//  Created by Daniele on 29/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "Contributo.h"

@implementation Contributo
- (id) init {
    if (self = [super init]) {
        self.anno=@"";
        self.contributoAderente=@"";
        self.contributoAssicurativo=@"";
        self.contributoAzienda=@"";
        self.contributoIscrizione=@"";
        self.contributoRivalutazioneTFR=@"";
        self.contributoTfr=@"";
        self.contributoTfrSilente=@"";
        self.contributoVolontario=@"";
        self.contributoVolontarioAzienda=@"";
        self.nomeAzienda=@"";
        self.periodo=@"";
        self.statoContributo=@"";
    }
    return self;
}

@end
