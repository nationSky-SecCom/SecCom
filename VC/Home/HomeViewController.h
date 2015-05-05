//
//  HomeViewController.h
//  SecCom
//
//  Created by duanran on 15/4/21.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *HeadPortrait;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;




- (IBAction)showAllAppList:(UIButton *)sender;
- (IBAction)showInstalledApps:(UIButton *)sender;
- (IBAction)showUnInstalledApps:(UIButton *)sender;




@end
