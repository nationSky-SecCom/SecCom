//
//  LBProgressView.h
//  ShaoNianPai
//
//  Created by libo on 11/17/14.
//  Copyright (c) 2014 LB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBProgressBarView : UIView

@property (nonatomic, assign) float progress;
@property (nonatomic, assign) NSInteger border;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *progressRemainingColor;
@property (nonatomic, strong) UIColor *progressColor;

@end
