//
//  AppListCell.m
//  SecCom
//
//  Created by libo on 4/22/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "AppListCell.h"

@implementation AppListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name{
    _nameLabel.text = name;
}

- (void)setTime:(NSString *)time{
    _timeLabel.text = time;
}

- (void)setClassName:(NSString *)className{
    _classLabel.text = className;
}

- (IBAction)buttonAction:(UIButton *)sender {
}





@end
