//
//  OperazioniView.h
//  Previmoda
//
//  Created by Daniele on 06/02/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperazioniView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noDataLbl;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end
