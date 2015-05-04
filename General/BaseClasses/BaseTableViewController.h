//
//  BaseTableViewController.h
//  SecCom
//
//  Created by libo on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINib *cellNib;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;



@end