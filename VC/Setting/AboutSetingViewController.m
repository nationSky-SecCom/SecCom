//
//  AboutSetingViewController.m
//  SecCom
//
//  Created by duanran on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "AboutSetingViewController.h"
#import "VendorMacro.h"
#import "FunctionSetingViewController.h"
#import "PermissionViewController.h"
#import "HelpAndFeedbackViewController.h"
@interface AboutSetingViewController ()
{
    NSArray *titleArr;
}
@end

@implementation AboutSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArr=@[@"功能介绍",@"许可协议",@"帮助与反馈"];
    setExtraCellLineHidden(self.tableView);
    self.tableView.scrollEnabled=NO;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idetifer=@"aboutSettingIdetifer";
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:idetifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifer];
    }
    
    cell.textLabel.text=[titleArr objectAtIndex:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger n=indexPath.row;
    if (n==0) {
        FunctionSetingViewController *function=[[FunctionSetingViewController alloc]init];
        function.titleName=@"功能介绍";
        [self.navigationController pushViewController:function animated:YES];
    }
    else if (n==1)
    {
        PermissionViewController *permiss=[[PermissionViewController alloc]init];
        permiss.titleName=@"许可协议";
        [self.navigationController pushViewController:permiss animated:YES];
    }
    else if (n==2)
    {
        HelpAndFeedbackViewController *helpAndFeedback=[[HelpAndFeedbackViewController alloc]init];
        helpAndFeedback.titleName=@"帮助与反馈";
        [self.navigationController pushViewController:helpAndFeedback animated:YES];
        
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
