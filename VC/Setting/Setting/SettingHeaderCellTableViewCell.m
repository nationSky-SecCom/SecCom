//
//  SettingHeaderCellTableViewCell.m
//  SecCom
//
//  Created by libo on 15/5/4.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "SettingHeaderCellTableViewCell.h"

@implementation SettingHeaderCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(UserModel *)user{
    _user = user;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
