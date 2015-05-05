//
//  SettingHeaderCellTableViewCell.h
//  SecCom
//
//  Created by libo on 15/5/4.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface SettingHeaderCellTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UIImageView *headPortraitImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *emailLabel;


@property (nonatomic, strong) UserModel *user;



@end
