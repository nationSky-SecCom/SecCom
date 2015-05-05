//
//  AppDetailsImageShowCell.m
//  SecCom
//
//  Created by libo on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "AppDetailsImageShowCell.h"
#import "imageUrlModel.h"
#import "AppMacro.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation AppDetailsImageShowCell

- (void)awakeFromNib {

    _scrollView.pagingEnabled = YES;
}

- (void)setCellModel:(AppModel *)app{
    for (UIView *aview in _scrollView.subviews) {
        [aview removeFromSuperview];
    }
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (imageUrlModel *imageModel in app.screenShots) {
        [imageArray addObject:imageModel];
    }
    
    CGSize size = _scrollView.contentSize;
    size.width = SCREEN_WIDTH*imageArray.count;
    _scrollView.contentSize = size;
    
    for (int i=0; i<imageArray.count; i++) {
        imageUrlModel *imageModel = imageArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl]];
        [_scrollView addSubview:imageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
