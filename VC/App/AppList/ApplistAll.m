//
//  ApplistAll.m
//  SecCom
//
//  Created by libo on 4/22/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "ApplistAll.h"
#import "AppListAllRequest.h"

@interface ApplistAll ()

@end

@implementation ApplistAll

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"appStore", @"应用商店");

    self.tableView.tableFooterView=[[UIView alloc]init];
}

- (void)requestAppList{
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
        [self.appArray addObjectsFromArray:responseArr];
        [self.tableView reloadData];
    } Failure:^(NSString *errorMessage) {
        NSMutableArray *testArr = [[NSMutableArray alloc] init];
        for (int i=0; i<10; i++) {
            AppModel *model = [[AppModel alloc] init];
            model.title = [NSString stringWithFormat:@"第%d个app",i];
            [testArr addObject:model];
        }
        [self.appArray addObjectsFromArray:testArr];
        [self.tableView reloadData];
        NSLog(@"%@",errorMessage);
    }];
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
