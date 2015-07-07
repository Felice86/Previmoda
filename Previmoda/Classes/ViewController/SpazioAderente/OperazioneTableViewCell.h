//
//  OperazioneTableViewCell.h
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperazioneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *annoLbl;
@property (weak, nonatomic) IBOutlet UILabel *trimestreLbl;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

- (IBAction)showDetail:(id)sender;

@end
