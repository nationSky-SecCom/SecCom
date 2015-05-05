//
//  LBTabBarController.m
//  SecCom
//
//  Created by libo on 15/4/29.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "LBTabBarController.h"
#import "HomeViewController.h"
#import "AppStoreVC.h"
#import "SettingVC.h"
#import "LBTabBar.h"
#import "RDVTabBarItem.h"

@interface LBTabBarController ()

@end

@implementation LBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.hidesBackButton = YES;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HomeViewController *home = [mainStoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:home];
    
    AppStoreVC *appStore = [mainStoryboard instantiateViewControllerWithIdentifier:@"AppStoreVC"];
    UINavigationController *navAppStore = [[UINavigationController alloc] initWithRootViewController:appStore];
    
//    SettingVC *setting = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
    SettingVC *setting = [mainStoryboard instantiateViewControllerWithIdentifier:@"SettingVC"];
    UINavigationController *navSetting = [[UINavigationController alloc] initWithRootViewController:setting];
    
    [self setViewControllers:@[navHome,navAppStore,navSetting]];
    
    
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    NSArray *tabBarTitle = @[NSLocalizedString(@"Home", @"主页"),
                             NSLocalizedString(@"appStore", @"应用商店"),
                             NSLocalizedString(@"setting", @"设置")];
    

    [self.tabBar setFrame:CGRectMake(CGRectGetMinX(self.tabBar.frame), CGRectGetMinY(self.tabBar.frame), CGRectGetWidth(self.tabBar.frame), 63)];
    NSInteger index = 0;
    for (RDVTabBarItem *item in self.tabBar.items) {

        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarTitle objectAtIndex:index]];
        
        index++;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
