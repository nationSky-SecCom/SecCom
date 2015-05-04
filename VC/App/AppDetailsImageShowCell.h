//
//  AppDetailsImageShowCell.h
//  SecCom
//
//  Created by libo on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "BaseTableViewCell.h"

@interface AppDetailsImageShowCell : BaseTableViewCell


@property (strong, nonatomic) IBOutlet UILabel *topLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)setCellModel:(AppModel *)app;



@end
