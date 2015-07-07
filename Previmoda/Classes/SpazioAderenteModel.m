//
//  SpazioAderenteModel.m
//  Previmoda
//
//  Created by Daniele on 24/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import "SpazioAderenteModel.h"

@implementation SpazioAderenteModel

+ (id)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init {
    if (self = [super init]) {
        [self inizializeAll];
    }
    return self;
}

- (void) inizializeCheck {
    self.checkLogin = false;
    self.checkDownloadAnagrafica = false;
    self.checkDownloadContributi = false;
    self.checkDownloadRecapiti = false;
    self.checkDownloadRendimento = false;
}

- (void) inizializeAll {
    [self inizializeCheck];
    self.codiceAderente = @"";
    self.codiceFiscale = @"";
    self.nome = @"";
    self.cognome = @"";
    self.cellulare = @"";
    self.email = @"";
    self.esisteConsensoEcViaMail = false;
    self.fax = @"";
    self.telefono = @"";
    self.controvaloreTotale = @"";
    self.nomeCompartoAttuale = @"";
    self.rendimentoAnnuo = @"";
    self.rendimentoDettaglio = nil;
    self.contributi = nil;
    self.recapitiDict = nil;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"it"]];
}

- (void) doLogout {
    [self inizializeAll];
}

- (void) loadAnagraficaUtente:(NSDictionary *)resultDict {
    for (NSString *key in resultDict) {
        NSString *value = [self loadValueFromKey:key ofDictionary:resultDict];
        if ([key isEqualToString:knome]) {
            self.nome = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([key isEqualToString:kcognome]) {
            self.cognome = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([key isEqualToString:kcodiceFiscale]) {
            self.codiceFiscale = [value uppercaseString];
            continue;
        }
        if ([key isEqualToString:kcodiceAderente]) {
//            self.codiceAderente = value;
            continue;
        }
        if ([key isEqualToString:kdataIscrizione]) {
            NSString *dateFromJSON = value;
            NSDate *dataIscrizione = nil;
            if (![dateFromJSON isEqualToString:@""]) {
                dataIscrizione = [self getJSONDate:dateFromJSON];
            }
            self.dataIscrizioneAderente = dataIscrizione;
        }
    }
}

- (void) loadContributiUtente:(NSDictionary *)resultDict {
    if ([resultDict isKindOfClass:NSArray.class]) {
        NSArray *contributi = (NSArray*)resultDict;
        
        NSMutableArray *notSorted = [[NSMutableArray alloc] init];
        
        for (NSDictionary *contrDict in contributi) {
            Contributo *contributoToInsert = [self createContributoToInsert:contrDict];
            [notSorted addObject:contributoToInsert];
        }
        
        NSArray *sorted = [self sortArrayOfContributi:notSorted];
        
        self.contributi = [[NSMutableArray alloc] initWithArray:sorted];
    }
}

- (Contributo*) createContributoToInsert:(NSDictionary*)contrDict {
    Contributo *contributo = [[Contributo alloc] init];
    
    for (NSString *key in contrDict) {
        NSString *value = [self loadValueFromKey:key ofDictionary:contrDict];
        if ([key isEqualToString:kanno]) {
            contributo.anno = value;
            continue;
        }
        if ([key isEqualToString:knomeAzienda]) {
            contributo.nomeAzienda = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([key isEqualToString:kperiodo]) {
            contributo.periodo = value;
            continue;
        }
        if ([key isEqualToString:kstatoContributo]) {
            contributo.statoContributo = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([value isEqualToString:@""]) {
            value = [self setZeroForStringWithKey:key andValue:[NSNumber numberWithInt:0]];
        }
        if ([key isEqualToString:kcontributoAderente]) {
            contributo.contributoAderente = value;
            continue;
        }
        if ([key isEqualToString:kcontributoAssicurativo]) {
            contributo.contributoAssicurativo = value;
            continue;
        }
        if ([key isEqualToString:kcontributoAzienda]) {
            contributo.contributoAzienda = value;
            continue;
        }
        if ([key isEqualToString:kcontributoIscrizione]) {
            contributo.contributoIscrizione = value;
            continue;
        }
        if ([key isEqualToString:kcontributoRivalutazioneTFR]) {
            contributo.contributoRivalutazioneTFR = value;
            continue;
        }
        if ([key isEqualToString:kcontributoTfr]) {
            contributo.contributoTfr = value;
            continue;
        }
        if ([key isEqualToString:kcontributoTfrSilente]) {
            contributo.contributoTfrSilente = value;
            continue;
        }
        if ([key isEqualToString:kcontributoVolontario]) {
            contributo.contributoVolontario = value;
            continue;
        }
        if ([key isEqualToString:kcontributoVolontarioAzienda]) {
            contributo.contributoVolontarioAzienda = value;
            continue;
        }
    }
    
    return contributo;
}

- (void) loadRecapitiUtente:(NSDictionary *)resultDict {
    if (_recapitiDict) {
        _recapitiDict = nil;
    }
    self.recapitiDict = [[NSMutableDictionary alloc] initWithDictionary:resultDict];
    for (NSString *key in resultDict) {
        if ([[resultDict objectForKey:key] isKindOfClass:NSArray.class]) {
            continue;
        }
        NSString *value = [self loadValueFromKey:key ofDictionary:resultDict];
        if ([key isEqualToString:kcellulare]) {
            self.cellulare = value;
            continue;
        }
        if ([key isEqualToString:kemail]) {
            self.email = [value lowercaseString];
            continue;
        }
        if ([key isEqualToString:kesisteConsensoEcViaMail]) {
            self.esisteConsensoEcViaMail = [value boolValue];
            continue;
        }
        if ([key isEqualToString:kfax]) {
            self.fax = value;
            continue;
        }
        if ([key isEqualToString:ktelefono]) {
            self.telefono = value;
            continue;
        }
    }
}

- (RendimentoDettaglio*) createRendimentoDettaglio:(NSDictionary*)dettaglioDict {
    RendimentoDettaglio *dettaglio = [[RendimentoDettaglio alloc] init];
    for (NSString *key in dettaglioDict) {
        NSString *value = [self loadValueFromKey:key ofDictionary:dettaglioDict];
        if ([key isEqualToString:kanniContribuzione]) {
            dettaglio.anniContribuzione = value;
            continue;
        }
        if ([key isEqualToString:kcontrovalore]) {
            dettaglio.controvalore = value;
            continue;
        }
        if ([key isEqualToString:kdataQuota]) {
            NSString *dateFromJSON = value;
            NSDate *dateQuota = nil;
            if (![dateFromJSON isEqualToString:@""]) {
                dateQuota = [self getJSONDate:dateFromJSON];
            }

            dettaglio.dataQuota = dateQuota;
            continue;
        }
        if ([key isEqualToString:kmesiContribuzione]) {
            dettaglio.mesiContribuzione = value;
            continue;
        }
        if ([key isEqualToString:knomeComparto]) {
            dettaglio.nomeComparto = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([key isEqualToString:kquoteAcquistate]) {
            dettaglio.quoteAcquistate = value;
            continue;
        }
        if ([key isEqualToString:kvaloreQuota]) {
            dettaglio.valoreQuota = value;
            continue;
        }
    }
    
    return dettaglio;
}

- (void) loadRendimentoUtente:(NSDictionary *)resultDict {
    for (NSString *key in resultDict) {
        if ([[resultDict objectForKey:key] isKindOfClass:NSArray.class] && [key isEqualToString:krendimentoDettaglio]) {
            NSDictionary *dettaglioDict = [[resultDict objectForKey:krendimentoDettaglio] objectAtIndex:0];
            RendimentoDettaglio *dettaglio = [self createRendimentoDettaglio:dettaglioDict];
            self.rendimentoDettaglio = dettaglio;
            continue;
        }
        NSString *value = [self loadValueFromKey:key ofDictionary:resultDict];
        if ([key isEqualToString:kcontrovaloreTotale]) {
            self.controvaloreTotale = value;
            continue;
        }
        if ([key isEqualToString:knomeCompartoAttuale]) {
            self.nomeCompartoAttuale = [[value lowercaseString] capitalizedString];
            continue;
        }
        if ([key isEqualToString:krendimentoAnnuo]) {
            self.rendimentoAnnuo = [NSString stringWithFormat:@"%@ %%",value];
            continue;
        }
        if ([key isEqualToString:kcontrovaloreTotale]) {
            self.controvaloreTotale = value;
            continue;
        }
    }
}

- (void) loadModificaUtente:(NSDictionary *)resultDict {
     for (NSString *key in resultDict) {
         if ([key isEqualToString:kRecapiti]) {
             if ([resultDict objectForKey:key] && [[resultDict objectForKey:key] isKindOfClass:NSDictionary.class]) {
                 [self loadRecapitiUtente:[resultDict objectForKey:key]];
             }
             continue;
         } else if ([key isEqualToString:kRilevazioni]) {
             if ([resultDict objectForKey:key] && [[resultDict objectForKey:key] isKindOfClass:NSArray.class]) {
                 _rilevazioni = nil;
                 _rilevazioni = [[NSMutableArray alloc] initWithArray:[resultDict objectForKey:key]];
             }
             continue;
         } else if ([key isEqualToString:kSuccesso]) {
             if ([resultDict objectForKey:key]) {
                 _successoModifica = [[resultDict objectForKey:key] boolValue];
             }
             continue;
         }
     }
}

- (NSString*) loadValueFromKey:(NSString*)key ofDictionary:(NSDictionary*)resultDict {
//    LOG(@"Key: %@ - Value: %@ - Classe: %@",key,[resultDict objectForKey:key],[[resultDict objectForKey:key] class]);
    NSString *valueString = @"";
    if ([[resultDict objectForKey:key] isKindOfClass:NSNull.class]) {
        //do nothing @""
    } else if ([[resultDict objectForKey:key] isKindOfClass:NSNumber.class]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];
        [formatter setLocale:locale];
        if (!([key isEqualToString:kanno] || [key isEqualToString:kperiodo])) {
            if (![key isEqualToString:kquoteAcquistate]) {
                [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            } else {
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            }
        }
        if ([key isEqualToString:kquoteAcquistate] || [key isEqualToString:kvaloreQuota]) {
            [formatter setPositiveFormat:@"0,###"];
        } else {
            [formatter setPositiveFormat:@"0,##"];
        }
        valueString = [formatter stringFromNumber:[resultDict objectForKey:key]];
    } else {
        valueString = (NSString*)[resultDict objectForKey:key];
    }
    
//    if ([valueString isEqualToString:@""]) {
//        
//        valueString = @"-";
//    }
    return valueString;
}

- (NSString*) setZeroForStringWithKey:(NSString*)key andValue:(NSNumber*)value {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];
    [formatter setLocale:locale];
    if (!([key isEqualToString:kanno] || [key isEqualToString:kperiodo])) {
        if (![key isEqualToString:kquoteAcquistate]) {
            [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        } else {
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        }
    }
    if ([key isEqualToString:kquoteAcquistate] || [key isEqualToString:kvaloreQuota]) {
        [formatter setPositiveFormat:@"0,###"];
    } else {
        [formatter setPositiveFormat:@"0,##"];
    }
    return [formatter stringFromNumber:value];
}

- (NSArray*) sortArrayOfContributi:(NSMutableArray*)notSorted {
    NSArray *sorted = [notSorted sortedArrayUsingComparator:^NSComparisonResult(Contributo* contr1,Contributo *contr2) {
        int anno1 = [contr1.anno intValue];
        int anno2 = [contr2.anno intValue];
        int period1 = [contr1.periodo intValue];
        int period2 = [contr2.periodo intValue];
        
        if (anno1 > anno2) {
            return NSOrderedAscending;
        } else if (anno1 < anno2) {
            return NSOrderedDescending;
        } else {
            if (period1 > period2) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }
        return NSOrderedSame;
    }];
    return sorted;
}

- (NSDate *) getJSONDate:(NSString*)dateFromJSON {
    NSString* header = @"/Date(";
    int headerLength = (int)[header length];
    
    NSString*  timestampString;
    
    NSScanner* scanner = [[NSScanner alloc] initWithString:dateFromJSON];
    [scanner setScanLocation:headerLength];
    [scanner scanUpToString:@")" intoString:&timestampString];
    
    NSCharacterSet* timezoneDelimiter = [NSCharacterSet characterSetWithCharactersInString:@"+-"];
    NSRange rangeOfTimezoneSymbol = [timestampString rangeOfCharacterFromSet:timezoneDelimiter];
    
    if (rangeOfTimezoneSymbol.length!=0) {
        scanner = [[NSScanner alloc] initWithString:timestampString];
        
        NSRange rangeOfFirstNumber;
        rangeOfFirstNumber.location = 0;
        rangeOfFirstNumber.length = rangeOfTimezoneSymbol.location;
        
        NSRange rangeOfSecondNumber;
        rangeOfSecondNumber.location = rangeOfTimezoneSymbol.location + 1;
        rangeOfSecondNumber.length = [timestampString length] - rangeOfSecondNumber.location;
        
        NSString* firstNumberString = [timestampString substringWithRange:rangeOfFirstNumber];
        NSString* secondNumberString = [timestampString substringWithRange:rangeOfSecondNumber];
        
        unsigned long long firstNumber = [firstNumberString longLongValue];
        int secondNumber = [secondNumberString intValue];
        
        NSTimeInterval interval = firstNumber/1000;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    unsigned long long firstNumber = [timestampString longLongValue];
    NSTimeInterval interval = firstNumber/1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end
