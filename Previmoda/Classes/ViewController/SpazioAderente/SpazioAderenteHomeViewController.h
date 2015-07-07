//
//  SpazioAderenteHomeViewController.h
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderHomeView.h"
#import "ValorePosizioneView.h"
#import "OperazioniView.h"
#import "SpazioAderenteCustomViewController.h"
#import "DettaglioContributoView.h"
#import "ModificaView.h"

@interface SpazioAderenteHomeViewController : SpazioAderenteCustomViewController <ConnectionHandlerDelegate,UITextViewDelegate>

@property (retain,nonatomic) IBOutlet HeaderHomeView *headerHomeView;
@property (retain,nonatomic) IBOutlet UIView *centerView;
@property (retain,nonatomic) IBOutlet ValorePosizioneView *valorePosizioneView;
@property (retain,nonatomic) IBOutlet OperazioniView *operazioniView;
@property (retain,nonatomic) IBOutlet DettaglioContributoView *dettaglioView;
@property (retain,nonatomic) IBOutlet ModificaView *modificaView;
@property (retain, nonatomic) IBOutlet UIView *homeButtons;

@property (nonatomic) BOOL showValore;
@property (nonatomic) BOOL showOperazioni;
@property (nonatomic) BOOL showModifica;
@property (nonatomic) BOOL showDettaglio;

- (IBAction)showValore:(id)sender;
- (IBAction)showOperazioni:(id)sender;
- (IBAction)showModifica:(id)sender;
@end
