//
//  AboutSetingViewController.h
//  SecCom
//
//  Created by duanran on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "BaseViewController.h"
@interface AboutSetingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView *tableView;

@end
