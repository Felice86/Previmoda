//
//  OperazioniView.m
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "OperazioniView.h"
#import "OperazioneTableViewCell.h"
#import "Contributo.h"

@implementation OperazioniView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    if ([user.contributi count] > 0) {
        _noDataLbl.hidden = true;
    } else {
        _noDataLbl.hidden = false;
    }
    return [user.contributi count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Operazione";
    OperazioneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (!cell) {
        NSString *frecciaStringImg = @"freccia.png";
        UIImage *frecciaImg = [UIImage imageNamed:frecciaStringImg];
        if (IS_IPHONE) {
            cell = (OperazioneTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"OperazioneTableViewCell" owner:self options:nil] objectAtIndex:0];
        } else {
            cell = (OperazioneTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"OperazioneTableViewCell-ipad" owner:self options:nil] objectAtIndex:0];
        }
        [cell.detailBtn setBackgroundImage:frecciaImg forState:UIControlStateNormal];
    }
    
    SpazioAderenteModel *user = [SpazioAderenteModel sharedInstance];
    Contributo *contributo = [user.contributi objectAtIndex:[indexPath row]];

    [cell.annoLbl setText:[NSString stringWithFormat:@"Anno %@",contributo.anno]];
    [cell.trimestreLbl setText:[NSString stringWithFormat:@"%@° trimestre",contributo.periodo]];
    [cell.detailBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailBtn.tag = indexPath.row;
    
    return cell;
}

- (IBAction)showDetail:(id)sender {
    UIButton *btn = (UIButton*)sender;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDetail" object:[NSNumber numberWithInt:btn.tag]];
}

@end
