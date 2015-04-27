//
//  LoginVC.m
//  SecCom
//
//  Created by duanran on 15/4/21.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "LoginVC.h"
#import "HomeViewController.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 100, 100, 100)];
    
    [btn addTarget:self action:@selector(navi) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];
    
    self.view.backgroundColor=[UIColor grayColor];
    NSLog(@"nskdjfklsjlkdfjkl");
}
-(BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}
-(void)navi
{
    HomeViewController *home=[[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:home animated:YES];
    
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
