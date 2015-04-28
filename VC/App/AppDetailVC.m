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

@end

@implementation AppDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"应用详情";
    _nameLabel.text = _appModel.title;
    
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
    _nameLabel.text = app.title;
    [_icon sd_setImageWithURL:[NSURL URLWithString:app.icon]];
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
