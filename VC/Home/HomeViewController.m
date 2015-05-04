//
//  HomeViewController.m
//  SecCom
//
//  Created by duanran on 15/4/21.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "HomeViewController.h"
#import "ApplistAll.h"
#import "AppListInstalled.h"
#import "AppListUnInstalled.h"
#import "UserInfoRequest.h"
#import "UserModel.h"
#import "HomeCollectionViewCell.h"

static NSString *HomeCollectionViewCellIdentifier = @"HomeCollectionViewCellIdentifier";

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.HeadPortrait.backgroundColor = [UIColor redColor];
    _HeadPortrait.layer.cornerRadius = _HeadPortrait.frame.size.width/2;
    _HeadPortrait.layer.masksToBounds = YES;


    self.view.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((SCREEN_WIDTH-20)/3-5, (SCREEN_WIDTH-20)/3-5)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flowLayout.headerReferenceSize = CGSizeZero;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 0;
    
    [_collectionView setCollectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:HomeCollectionViewCellIdentifier];
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:HomeCollectionViewCellIdentifier];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];


    UserInfoRequest *request = [[UserInfoRequest alloc] init];
    [request GETRequest:^(id responseObject) {
        [self showUserInfo:responseObject];
    } Failure:^(NSString *errorMessage) {
        
    }];
}

/* 显示用户信息 */
- (void)showUserInfo:(UserModel *)user{

}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- UICollectionViewDataSource -----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionViewCellIdentifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blueColor];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)showAllAppList:(UIButton *)sender {
    ApplistAll *vc = [[ApplistAll alloc] initWithNibName:@"ApplistAll" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showInstalledApps:(UIButton *)sender {
    AppListInstalled *vc = [[AppListInstalled alloc] initWithNibName:@"AppListInstalled" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showUnInstalledApps:(UIButton *)sender {
    AppListUnInstalled *vc = [[AppListUnInstalled alloc] initWithNibName:@"AppListUnInstalled" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
