//
//  Globals.h
//  PrevimodaApp
//
//  Created by Daniele on 05/09/14.
//  Copyright (c) 2014 ElpoEdizioni. All rights reserved.
//

#ifndef PrevimodaApp_Globals_h
#define PrevimodaApp_Globals_h

#if defined (DEBUG) || defined (ADHOC)
    #define LOG(x,...) NSLog(@"%s %d: " x,__FUNCTION__,__LINE__, ##__VA_ARGS__)
#else
    #define LOG NSLog
#endif

#define RED_COLOR [UIColor colorWithRed:216.0/255.0 green:27.0/255.0 blue:40/255.0 alpha:1.0]
#define BLUE_COLOR [UIColor colorWithRed:22.0/255.0 green:35.0/255.0 blue:104/255.0 alpha:1.0]

#define kOFFSET_FOR_KEYBOARD 60.0

#pragma mark define screen size
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#pragma mark FOR PARSE LIBRARY (push)
#define appID @"TXR7BVF5Mh6ZF4puJWxo0LjGU8i571MK9P32itba"
#define clKey @"I6Z5K3Ul15UqXbcaWks0CKTq9zo1LvPCZnazDwze"
#define dotNETKey @"45UnsEyNfp5nhIrs13JtYntcXvUWObq2IokWrLtO"
#define javaScriptKey @"zY8xksN3nottPkBu0YfglyxRrxujPx4dYzh2T6z1"
#define restAPIKey @"8mW5vNYG0tab729431trh8FCWh9tR4BumvfpKgLe"
#define masterKey @"psCsBSFAbTdQinlu3dj3wMSSzVlkFMpN73Xk2gym"

#pragma mark URL external
#define url_previmoda @"http://www.previmoda.it"
#define url_login @"https://www.fondimatica.it/Previmoda/aca.aspx"
#define url_notizie @"http://www.previmoda.it/news/notizie"
#define url_video @"https://www.youtube.com/channel/%@"
#define url_video_app @"youtube://user/%@"
#define url_video_channel @"UCQr-DY1zSorgCOoMwJCDIbQ"

#pragma mark link Fondimatica
#define fondimatica_login @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/abilitaUtente"
#define fondimatica_rendimento @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/rendimento"
#define fondimatica_recapiti @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/recapiti"
#define fondimatica_contributi @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/contributi"
#define fondimatica_anagrafica @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/anagrafica"
#define fondimatica_modifica @"https://www.fondimatica.it/previmodaSvc/Aderente2.svc/%@/recapiti"

#define fondimatica_post @"POST"
#define fondimatica_get @"GET"

#define fondimatica_credential_user @"prvmobile01"
#define fondimatica_credential_password @"295888JJOK"

typedef enum {
    Anagrafica = 1,
    Recapiti,
    Rendimento,
    Contributi,
    Modifica,
    Login
} ActionName;

#define kanniContribuzione @"anniContribuzione"
#define kcontrovalore @"controvalore"
#define kdataQuota @"dataQuota"
#define kmesiContribuzione @"mesiContribuzione"
#define knomeComparto @"nomeComparto"
#define kquoteAcquistate @"quoteAcquistate"
#define kvaloreQuota @"valoreQuota"
#define kanno @"anno"
#define kcontributoAderente @"contributoAderente"
#define kcontributoAssicurativo @"contributoAssicurativo"
#define kcontributoAzienda @"contributoAzienda"
#define kcontributoIscrizione @"contributoIscrizione"
#define kcontributoRivalutazioneTFR @"contributoRivalutazioneTFR"
#define kcontributoTfr @"contributoTfr"
#define kcontributoTfrSilente @"contributoTfrSilente"
#define kcontributoVolontario @"contributoVolontario"
#define kcontributoVolontarioAzienda @"contributoVolontarioAzienda"
#define knomeAzienda @"nomeAzienda"
#define kperiodo @"periodo"
#define kstatoContributo @"statoContributo"
#define kcodiceAderente @"codiceAderente"
#define kdataIscrizione @"dataIscrizione"
#define kpassword @"password"
#define knome @"nome"
#define kcognome @"cognome"
#define kcodiceFiscale @"codiceFiscale"
#define kcellulare @"cellulare"
#define kemail @"eMail"
#define kesisteConsensoEcViaMail @"esisteConsensoEcViaMail"
#define kfax @"fax"
#define ktelefono @"telefono"
#define kcontrovaloreTotale @"controvaloreTotale"
#define knomeCompartoAttuale @"nomeCompartoAttuale"
#define krendimentoAnnuo @"rendimentoAnnuo"
#define krendimentoDettaglio @"rendimentoDettaglio"
#define kRecapiti @"recapiti"
#define kRilevazioni @"rilevazioni"
#define kSuccesso @"successo"

#pragma mark ERROR
#define error_generic @"GenericError"
#define error_authentication @"AuthenticationError"
#define error_timeout @"TimeoutError"
#define error_empty @"EmptyResponseError"

#endif
