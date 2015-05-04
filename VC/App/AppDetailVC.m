//
//  AppDetailVC.m
//  SecCom
//
//  Created by libo on 4/21/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "AppDetailVC.h"
#import "AppDetailRequest.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface AppDetailVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"应用详情";
    
    AppDetailRequest *request = [[AppDetailRequest alloc] init];

    request.parameters = @{
                           @"request":@{
                               @"operId":@{
                                   @"tokenId":@"",
                                   @"userId":@"",
                                   @"deviceId":@"",
                                   @"requestId":@""
                               }
                           },
                           @"requestData":@{
                                @"appId":self.appModel.appId
                           }
                           };
    
    
    [request POSTRequest:^(id responseObject) {
        _appModel = responseObject;
        [self setAppInfo:_appModel];
    } Failure:^(NSString *errorMessage) {
        
    }];
}

/* 显示app详细信息 */
- (void)setAppInfo:(AppModel *)app{

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
        [self.tableView registerNib:self.cellNib forCellReuseIdentifier:self.cellIdentifier];
    }
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    AppModel *model = self.items[indexPath.row];
    cell.name = model.title;
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    return cell;
}

#pragma mark ----- UITableViewDelegate -----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 70;
            break;
        case 1:
            return 400;
            break;
            
        default:
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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
