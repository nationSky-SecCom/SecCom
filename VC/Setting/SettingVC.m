//
//  SettingVC.m
//  SecCom
//
//  Created by libo on 4/21/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "SettingVC.h"
#import "UserInfoViewController.h"
#import "AboutSetingViewController.h"
@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}

-(IBAction)navitoUser:(id)sender
{
    UserInfoViewController *userInfo=[[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userInfo animated:YES];
}
-(IBAction)naviToAbout:(id)sender
{
    AboutSetingViewController *about=[[AboutSetingViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
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
