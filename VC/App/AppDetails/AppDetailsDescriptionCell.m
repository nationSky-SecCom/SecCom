//
//  AppDetailsDescription.m
//  SecCom
//
//  Created by libo on 15/5/5.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "AppDetailsDescriptionCell.h"

@implementation AppDetailsDescriptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setText:(NSString *)text{
    _text = text;
    self.frame = [_text boundingRectWithSize:CGSizeMake(self.frame.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
