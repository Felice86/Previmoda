//
//  DettaglioContributoLabelsView.h
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DettaglioContributoLabelsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *annoLbl;
@property (weak, nonatomic) IBOutlet UILabel *periodoLbl;
@property (weak, nonatomic) IBOutlet UILabel *aziendaLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAderLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAzLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrTfrLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrVolontLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrVolontAzLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAssicLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrIscrLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrTfrSilLbl;
@property (weak, nonatomic) IBOutlet UILabel *statoContrLbl;

@property (weak, nonatomic) IBOutlet UILabel *aziendaTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAderTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAzTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrTfrTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrVolontTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrVolontAzTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrAssicTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrIscrTLbl;
@property (weak, nonatomic) IBOutlet UILabel *contrTfrSilTLbl;
@property (weak, nonatomic) IBOutlet UILabel *statoContrTLbl;

@property (nonatomic) float y;

- (void) calculateHeightOfNomeAzienda;

@end
