//
//  SpazioAderenteHomeViewController.m
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "SpazioAderenteHomeViewController.h"
#import "Contributo.h"

@interface SpazioAderenteHomeViewController ()

@end

@implementation SpazioAderenteHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetail:) name:@"ShowDetail" object:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //modifico l'altezza della vista centrale in base al dispositivo
    [self setHeightCenterView];
    
    //Inserisco nome cognome utente
    [self loadHeaderHomeView];
    
    //carico la vista del valore della posizione
    [self createValorePosizioneView];
    [self loadValorePosizioneView];
    
    //carico la vista delle operazioni
    [self createOperazioniView];
    [self loadOperazioniView];
    
    //carico la vista per il dettaglio di un operazione
    [self createOneDetailView];
    
    //carico la vista per la modifica dei dati
    [self createModificaView];
    [self loadModificaView];
    
    //mostro la home page (bottoni)
    _homeButtons.hidden = false;
    
    _modificaView.telefonoField.delegate = self;
    _modificaView.cellulareField.delegate = self;
    _modificaView.emailField.delegate = self;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) createTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:_modificaView action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadHeaderHomeView {
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    [_headerHomeView.usernameLbl setText:[NSString stringWithFormat:@"%@ %@",user.nome,user.cognome]];
    [user.dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *dataIscrizione = [user.dateFormatter stringFromDate:user.dataIscrizioneAderente];
    [_headerHomeView.dateLbl setText:[NSString stringWithFormat:@"%@",dataIscrizione]];
}

- (void) createValorePosizioneView {
    [self addViewInCenterView:_valorePosizioneView];
}

- (void) loadValorePosizioneView {
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    [_valorePosizioneView.compartoLbl setText:user.nomeCompartoAttuale];
    [_valorePosizioneView.numeroQuoteLbl setText:user.rendimentoDettaglio.quoteAcquistate];
    [_valorePosizioneView.valoreQuotaLbl setText:user.rendimentoDettaglio.valoreQuota];
    [user.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *date = [user.dateFormatter stringFromDate:user.rendimentoDettaglio.dataQuota];
    [_valorePosizioneView.dataUltimaPosizioneLbl setText:date];
    [_valorePosizioneView.valorePosizioneLbl setText:user.controvaloreTotale];
}

- (void) createOperazioniView {
    [self addViewInCenterView:_operazioniView];
    CGRect tableRect = _operazioniView.tableView.frame;
    tableRect.size.height = _operazioniView.frame.size.height - tableRect.origin.y;
    _operazioniView.tableView.frame = tableRect;
}

- (void) loadOperazioniView {
    _operazioniView.tableView.backgroundColor = [UIColor clearColor];
    _operazioniView.tableView.backgroundColor = nil;
}

- (void) createOneDetailView {
    [self addViewInCenterView:_dettaglioView];
    CGRect scrollRect = _dettaglioView.scrollView.frame;
    scrollRect.size.height = _operazioniView.frame.size.height - scrollRect.origin.y;
    _dettaglioView.scrollView.frame = scrollRect;
}

- (void) createModificaView {
    [self addViewInCenterView:_modificaView];
}

- (void) loadModificaView {
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    [_modificaView.telefonoField setText:user.telefono];
    [_modificaView.cellulareField setText:user.cellulare];
    [_modificaView.emailField setText:user.email];
    NSString *consenso = @"";
    if (user.esisteConsensoEcViaMail) {
        consenso = @"Sì";
    } else {
        consenso = @"No";
    }
    [_modificaView.consensoField setText:consenso];
}

- (void) addViewInCenterView:(UIView*)view {
    view.hidden = true;
    [self setOriginYForView:view];
    CGRect superRect = _centerView.frame;
    CGRect rect = view.frame;
    rect.size.height = superRect.size.height - rect.origin.y;
    view.frame = rect;
    [self.centerView addSubview:view];
}

- (void) setHeightCenterView {
    CGRect superRect = _centerView.frame;
    superRect.size.height = self.naviY-_centerView.frame.origin.y;
    _centerView.frame = superRect;
}

- (void) setOriginYForView:(UIView*)view {
    CGRect frame = _homeButtons.frame;
    CGRect viewFrame = view.frame;
    viewFrame.origin.y = frame.origin.y;
    view.frame = viewFrame;
}

- (void) back {
    if (self.showValore) {
        [self hide:_valorePosizioneView];
        self.showValore = false;
    }
    if (self.showOperazioni) {
        [self hide:_operazioniView];
        self.showOperazioni = false;
    }
    if (self.showDettaglio) {
        [self hideDettaglio];
        self.showDettaglio = false;
        self.showOperazioni = true;
    }
    if (self.showModifica) {
        [self hide:_modificaView];
        [_modificaView closeModifcaView];
        self.showModifica = false;
    }
    if (!self.showValore && !self.showOperazioni && !self.showModifica) {
        [NSTimer scheduledTimerWithTimeInterval:.8 target:self selector:@selector(changeNavigationBar:) userInfo:[self homeNavigation] repeats:NO];
//        [self changeNavigationBar:[self homeNavigation]];
    }
}

- (void) show:(UIView*)view {
    
    [self animationFrom:kCATransitionFromRight forView:view setHidden:false];
    [self animationFrom:kCATransitionFromRight forView:_homeButtons setHidden:true];

    [NSTimer scheduledTimerWithTimeInterval:.8 target:self selector:@selector(changeNavigationBar:) userInfo:[self thirdNavigation] repeats:NO];
}

- (void) showDettaglioView {
    [self animationFrom:kCATransitionFromRight forView:_dettaglioView setHidden:false];
    [self animationFrom:kCATransitionFromRight forView:_operazioniView setHidden:true];
}

- (void) hide:(UIView*)view {
    [self animationFrom:kCATransitionFromLeft forView:view setHidden:true];
    [self animationFrom:kCATransitionFromLeft forView:_homeButtons setHidden:false];
}

- (void) hideDettaglio {
    [self animationFrom:kCATransitionFromLeft forView:_dettaglioView setHidden:true];
    [self animationFrom:kCATransitionFromLeft forView:_operazioniView setHidden:false];
}

- (void) animationFrom:(NSString*)from forView:(UIView*)view setHidden:(BOOL)hidden {
    CATransition *animation = [CATransition animation];
    [animation setDuration:.8];
    [animation setType:kCATransitionPush];
    [animation setSubtype:from];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[view layer] addAnimation:animation forKey:@"SwitchToView"];
    view.hidden = hidden;
}

- (IBAction)showValore:(id)sender {
    [self show:_valorePosizioneView];
    self.showValore = true;
}

- (IBAction)showOperazioni:(id)sender {
    [_operazioniView.tableView reloadData];
    [self show:_operazioniView];
    self.showOperazioni = true;
}

- (IBAction)showModifica:(id)sender {
    [self createTapGesture];
    self.appDelegate.connectionHandler.delegate = self;
    [self show:_modificaView];
    self.showModifica = true;
}

- (void) loadOneDetailView:(int)contributoIndex {
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    Contributo *contributo = [user.contributi objectAtIndex:contributoIndex];
    [_dettaglioView.dettaglioLabelsView.annoLbl setText:[NSString stringWithFormat:@"Anno %@",contributo.anno]];
    [_dettaglioView.dettaglioLabelsView.periodoLbl setText:[NSString stringWithFormat:@"- %@° trimestre",contributo.periodo]];
    [_dettaglioView.dettaglioLabelsView.aziendaLbl setText:contributo.nomeAzienda];
    if (IS_IPHONE) {
        [_dettaglioView.dettaglioLabelsView calculateHeightOfNomeAzienda];
    }
    [_dettaglioView.dettaglioLabelsView.contrAderLbl setText:contributo.contributoAderente];
    [_dettaglioView.dettaglioLabelsView.contrAzLbl setText:contributo.contributoAzienda];
    [_dettaglioView.dettaglioLabelsView.contrTfrLbl setText:contributo.contributoTfr];
    [_dettaglioView.dettaglioLabelsView.contrVolontLbl setText:contributo.contributoVolontario];
    [_dettaglioView.dettaglioLabelsView.contrVolontAzLbl setText:contributo.contributoVolontarioAzienda];
    [_dettaglioView.dettaglioLabelsView.contrAssicLbl setText:contributo.contributoAssicurativo];
    [_dettaglioView.dettaglioLabelsView.contrIscrLbl setText:contributo.contributoIscrizione];
    [_dettaglioView.dettaglioLabelsView.contrTfrSilLbl setText:contributo.contributoTfrSilente];
    [_dettaglioView.dettaglioLabelsView.statoContrLbl setText:contributo.statoContributo];
}

- (void) showDetail:(NSNotification*) notification {
    int contributoIndex = [(NSNumber*)notification.object intValue];
    [self loadOneDetailView:contributoIndex];
    
    int y = 0;
    CGRect rect;
    /* DETTAGLIO */
    rect = _dettaglioView.dettaglioLabelsView.frame;
    rect.origin.y = y;
    _dettaglioView.dettaglioLabelsView.frame = rect;
    [_dettaglioView.scrollView addSubview:_dettaglioView.dettaglioLabelsView];
    y = rect.origin.y+rect.size.height+5;
    
    /* IMAGE */
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatore"]];
    rect = line.frame;
    rect.origin.x = _dettaglioView.scrollView.frame.size.width - _dettaglioView.frame.size.width;
    rect.origin.y = y;
    
    line.frame = rect;
    [_dettaglioView.scrollView addSubview:line];
    y = rect.origin.y+rect.size.height+5;
    
    /* LEGENDA */
    rect = _dettaglioView.legendaView.frame;
    rect.origin.y = y;
    _dettaglioView.legendaView.frame = rect;
    [_dettaglioView.scrollView addSubview:_dettaglioView.legendaView];
    y = rect.origin.y+rect.size.height+5;
    
    /* SCROLL */
    _dettaglioView.scrollView.contentSize = CGSizeMake(_dettaglioView.scrollView.frame.size.width, y);
    
    [self showDettaglioView];
    self.showDettaglio = true;
    self.showOperazioni = false;
    
    [_dettaglioView.scrollView setContentOffset:CGPointMake(0, -_dettaglioView.scrollView.contentInset.top) animated:true];
//    LOG(@"Screen view: %@",NSStringFromCGRect([UIScreen mainScreen].bounds));
//    LOG(@"Home view: %@",NSStringFromCGRect(self.view.frame));
//    LOG(@"Center view: %@",NSStringFromCGRect(_centerView.frame));
//    LOG(@"Dettaglio view: %@",NSStringFromCGRect(_dettaglioView.frame));
//    LOG(@"Scroll view: %@",NSStringFromCGRect(_dettaglioView.scrollView.frame));
//    LOG(@"Content view: %@",NSStringFromCGSize(_dettaglioView.scrollView.contentSize));
//    LOG(@"Informazioni view: %@",NSStringFromCGRect(_dettaglioView.dettaglioLabelsView.frame));
//    LOG(@"Legenda view: %@",NSStringFromCGRect(_dettaglioView.legendaView.frame));
}

- (void) changeNavigationBar:(NSTimer*)timer{
    UINavigationBar *navBar = (UINavigationBar*)timer.userInfo;
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:UINavigationBar.class]) {
            [v removeFromSuperview];
            [self.view addSubview:navBar];
        }
    }
}

- (void) closeModificaFieldsAndReload {
    [_modificaView closeModifcaView];
    _modificaView.showSalva = false;
    
    [self loadModificaView];
}

- (void) connectionHandlerAction:(ActionName)action didFailWithError:(NSString *)error {
    if (action == Modifica) {
        [self closeModificaFieldsAndReload];
    }
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(error, @"") delegate:self cancelButtonTitle:NSLocalizedString(@"ButtonDone", nil) otherButtonTitles:nil];
    [errorAlert show];
}

- (void) connectionHandlerDidFinishAction:(ActionName)action {
    if (action == Modifica) {
        [self closeModificaFieldsAndReload];
        UIAlertView *modificaAlert = [[UIAlertView alloc] initWithTitle:@"Modifica" message:NSLocalizedString(@"Modifica", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"ButtonDone", nil) otherButtonTitles:nil];
        [modificaAlert show];
    }
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShowDetail" object:nil];
}
@end
