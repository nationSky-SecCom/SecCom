//
//  AppListCell.h
//  SecCom
//
//  Created by libo on 4/22/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface AppListCell : BaseTableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSString *name;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSString *time;

@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (nonatomic, strong) NSString *className;


@property (strong, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonAction:(UIButton *)sender;




@end
