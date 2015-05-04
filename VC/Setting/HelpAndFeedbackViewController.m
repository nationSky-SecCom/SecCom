//
//  HelpAndFeedbackViewController.m
//  SecCom
//
//  Created by duanran on 15/5/4.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "HelpAndFeedbackViewController.h"

@interface HelpAndFeedbackViewController ()
{
    NSArray *titleArr;
}
@end

@implementation HelpAndFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titleName;
    titleArr=@[@"xxxxx功能问题?",@"xxxxx收不到提示消息?",@"消息提示没有体型问题?"];
    setExtraCellLineHidden(self.tableView);

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
    static NSString *idetifer=@"HelpAndFeedbackIdetifer";
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:idetifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifer];
    }
    
    cell.textLabel.text=[titleArr objectAtIndex:indexPath.row];
    return cell;
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
