//
//  DettaglioContributoLabelsView.m
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "DettaglioContributoLabelsView.h"

@implementation DettaglioContributoLabelsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) calculateHeightOfNomeAzienda {
    
    _y = 0;
    
    CGSize maximumLabelSize = CGSizeMake(_aziendaLbl.frame.size.width, MAXFLOAT);
    
    CGRect expectedLabelRect = [_aziendaLbl.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_aziendaLbl.font} context:nil];
    
    [_aziendaLbl setNumberOfLines:0];
    
    CGRect aziendaFrame = _aziendaLbl.frame;
    aziendaFrame.size.height = expectedLabelRect.size.height;
    _aziendaLbl.frame = aziendaFrame;
    
    [self getYFromLabel:_aziendaLbl];
    [self resizezLabelT:_contrAderTLbl andLbl:_contrAderLbl];
    
    [self getYFromLabel:_contrAderLbl];
    [self resizezLabelT:_contrAzTLbl andLbl:_contrAzLbl];
    
    [self getYFromLabel:_contrAzLbl];
    [self resizezLabelT:_contrTfrTLbl andLbl:_contrTfrLbl];
    
    [self getYFromLabel:_contrTfrLbl];
    [self resizezLabelT:_contrVolontTLbl andLbl:_contrVolontLbl];
    
    [self getYFromLabel:_contrVolontLbl];
    [self resizezLabelT:_contrVolontAzTLbl andLbl:_contrVolontAzLbl];
    
    [self getYFromLabel:_contrVolontAzLbl];
    [self resizezLabelT:_contrAssicTLbl andLbl:_contrAssicLbl];
    
    [self getYFromLabel:_contrAssicLbl];
    [self resizezLabelT:_contrIscrTLbl andLbl:_contrIscrLbl];
    
    [self getYFromLabel:_contrIscrLbl];
    [self resizezLabelT:_contrTfrSilTLbl andLbl:_contrTfrSilLbl];
    
    [self getYFromLabel:_contrTfrSilLbl];
    [self resizezLabelT:_statoContrTLbl andLbl:_statoContrLbl];
    
    [self getYFromLabel:_statoContrLbl];
    
    CGRect viewFrame = self.frame;
    viewFrame.size.height = _y;
    self.frame = viewFrame;
    
}

- (void) resizezLabelT:(UILabel*)t andLbl:(UILabel*)lbl {
    CGRect frameT = t.frame;
    CGRect frameLbl = lbl.frame;
    frameT.origin.y = _y;
    frameLbl.origin.y = _y;
    t.frame = frameT;
    lbl.frame = frameLbl;
}

- (void) getYFromLabel:(UILabel*)lbl {
    _y = lbl.frame.origin.y + lbl.frame.size.height + 4;
}

@end





