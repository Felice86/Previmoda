//
//  DettaglioContributoView.h
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DettaglioContributoLabelsView.h"

@interface DettaglioContributoView : UIView

@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain,nonatomic) IBOutlet DettaglioContributoLabelsView *dettaglioLabelsView;
@property (retain,nonatomic) IBOutlet UIView *legendaView;

@end
