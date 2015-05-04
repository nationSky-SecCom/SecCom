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
#import "AppListCell.h"
#import "AppDetailsImageShowCell.h"

@interface AppDetailVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

/* 应用截图展示cell */
@property (nonatomic, strong) UINib *imageNib;

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
    _appModel = app;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- UITableViewDataSource -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            if (!self.cellNib) {
                self.cellNib = [UINib nibWithNibName:@"AppListCell" bundle:nil];
                [self.tableView registerNib:self.cellNib forCellReuseIdentifier:@"AppListCell"];
            }
            AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppListCell"];
            
            cell.name = _appModel.title;
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:_appModel.icon] placeholderImage:nil];
            if (cell) {
                return cell;
            }
        }

            break;
        case 1:
        {
            if (!self.imageNib) {
                self.imageNib = [UINib nibWithNibName:@"AppDetailsImageShowCell" bundle:nil];
                [self.tableView registerNib:self.imageNib forCellReuseIdentifier:@"AppDetailsImageShowCell"];
            }
            AppDetailsImageShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppDetailsImageShowCell"];

            [cell setCellModel:_appModel];
            if (cell) {
                return cell;
            }
        }
            
            break;
        default:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                return cell;
            }
            break;
    }
    
    UITableViewCell *cell0 = [[UITableViewCell alloc] init];
    return cell0;
    
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
    return 0;
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
