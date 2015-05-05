//
//  CheckForUpdatesVC.m
//  SecCom
//
//  Created by libo on 15/5/5.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "CheckForUpdatesVC.h"

@interface CheckForUpdatesVC ()

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkUpdatesButton;
- (IBAction)checkForUpdatesAction:(UIButton *)sender;


@end

@implementation CheckForUpdatesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)checkForUpdatesAction:(UIButton *)sender {
}
@end
