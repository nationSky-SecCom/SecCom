//
//  AppStoreVC.m
//  SecCom
//
//  Created by libo on 15/4/30.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "AppStoreVC.h"
#import "AppListAllRequest.h"
#import "AppListCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface AppStoreVC ()

@end

@implementation AppStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self HTTPRequest];
    
}

- (void)HTTPRequest{
    AppListAllRequest *request = [[AppListAllRequest alloc] init];
    request.parameters = @{@"request":@{
                                   @"operId":@{
                                           @"tokenId":@"",
                                           @"userId":@"",
                                           @"deviceId":@"",
                                           @"requestId":@""
                                           }
                                   },
                           @"requestData":@{
                                   @"getApplist":@{
                                           @"clientOS":@"",
                                           @"appType":@"",
                                           @"cateId":@"",
                                           @"searchWord":@"",
                                           @"pageIndex":@"",
                                           @"itemCount":@""
                                           }
                                   }};
    [request POSTRequest:^(id responseObject) {
        NSArray *responseArr = responseObject;
        self.items = responseArr;
        [self.tableView reloadData];
    } Failure:^(NSString *errorMessage) {
        NSMutableArray *testArr = [[NSMutableArray alloc] init];
        for (int i=0; i<10; i++) {
            AppModel *model = [[AppModel alloc] init];
            model.title = [NSString stringWithFormat:@"第%d个app",i];
            [testArr addObject:model];
        }
        self.items = testArr;
        [self.tableView reloadData];
        NSLog(@"%@",errorMessage);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- UITableViewDataSource -----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.cellNib) {
        self.cellNib = [UINib nibWithNibName:@"AppListCell" bundle:nil];
        [self.tableView registerNib:self.cellNib forCellReuseIdentifier:@"AppListCell"];
    }
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppListCell"];
    
    AppModel *model = self.items[indexPath.row];
    cell.name = model.title;
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    return cell;
}

#pragma mark ----- UITableViewDelegate -----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AppDetailVC *detail = [mainStoryboard instantiateViewControllerWithIdentifier:@"AppDetailVC"];
    detail.appModel = self.items[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
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
