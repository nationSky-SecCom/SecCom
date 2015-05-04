//
//  HelpAndFeedbackViewController.h
//  SecCom
//
//  Created by duanran on 15/5/4.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "BaseViewController.h"

@interface HelpAndFeedbackViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)IBOutlet UITableView *tableView;
@end
