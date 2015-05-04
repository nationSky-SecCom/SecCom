//
//  AppListVC.m
//  SecCom
//
//  Created by libo on 4/21/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "AppListVC.h"

@interface AppListVC ()

@end

@implementation AppListVC


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"AppListVC";
    _appArray = [[NSMutableArray alloc] init];
    
    [self requestAppList];
    
}

- (void)requestAppList{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- UITableViewDataSource -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _appArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *leftVCCell = @"ApplistVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftVCCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:leftVCCell];
    }
    
    AppModel *model = _appArray[indexPath.row];
    cell.textLabel.text = model.title;

    return cell;
}

#pragma mark ----- UITableViewDelegate -----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDetailVC *detail = [[AppDetailVC alloc] initWithNibName:@"AppDetailVC" bundle:nil];
    detail.appModel = _appArray[indexPath.row];
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
