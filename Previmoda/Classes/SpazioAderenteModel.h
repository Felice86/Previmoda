//
//  SpazioAderenteModel.h
//  Previmoda
//
//  Created by Daniele on 24/12/14.
//  Copyright (c) 2014 Previmoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RendimentoDettaglio.h"
#import "Contributo.h"

@interface SpazioAderenteModel : NSObject
//Anagrafica
@property (nonatomic, retain) NSString *codiceAderente;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *cognome;
@property (nonatomic, retain) NSString *codiceFiscale;
@property (nonatomic, retain) NSDate *dataIscrizioneAderente;

//Recapiti
@property (nonatomic, retain) NSMutableDictionary *recapitiDict;
@property (nonatomic, retain) NSString *cellulare;
@property (nonatomic, retain) NSString *email;
@property (nonatomic) BOOL esisteConsensoEcViaMail;
@property (nonatomic, retain) NSString *fax;
@property (nonatomic, retain) NSString *telefono;

//Rendimento
@property (nonatomic, retain) NSString *controvaloreTotale;
@property (nonatomic, retain) NSString *nomeCompartoAttuale;
@property (nonatomic, retain) NSString *rendimentoAnnuo;
@property (nonatomic, retain) RendimentoDettaglio *rendimentoDettaglio;

//Contributi
@property (nonatomic, retain) NSMutableArray *contributi;

//Rilevazioni?
@property (nonatomic, retain) NSMutableArray *rilevazioni;

//Check download contents
@property (nonatomic) BOOL checkLogin;
@property (nonatomic) BOOL checkDownloadAnagrafica;
@property (nonatomic) BOOL checkDownloadRecapiti;
@property (nonatomic) BOOL checkDownloadRendimento;
@property (nonatomic) BOOL checkDownloadContributi;

@property (nonatomic) BOOL logged;
@property (nonatomic) BOOL successoModifica;

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

+ (id)sharedInstance;
- (void) loadAnagraficaUtente:(NSDictionary*)resultDict;
- (void) loadRecapitiUtente:(NSDictionary*)resultDict;
- (void) loadRendimentoUtente:(NSDictionary*)resultDict;
- (void) loadContributiUtente:(NSDictionary*)resultDict;
- (void) loadModificaUtente:(NSDictionary*)resultDict;

- (void) doLogout;

@end