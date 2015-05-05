//
//  SettingVC.m
//  SecCom
//
//  Created by libo on 4/21/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "SettingVC.h"
#import "UserInfoViewController.h"
#import "AboutSetingViewController.h"
#import "SettingHeaderCellTableViewCell.h"
#import "SettingSwitchCell.h"
#import "CheckForUpdatesVC.h"


@interface SettingVC ()

- (IBAction)logoutAction:(UIButton *)sender;

@property (nonatomic, strong) UINib *headNib;
@property (nonatomic, strong) UINib *switchNib;

@end

@implementation SettingVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    _headNib = [UINib nibWithNibName:@"SettingHeaderCellTableViewCell" bundle:nil];
    [_tableView registerNib:_headNib forCellReuseIdentifier:@"SettingHeaderCellTableViewCell"];
    _switchNib = [UINib nibWithNibName:@"SettingSwitchCell" bundle:nil];
    [_tableView registerNib:_switchNib forCellReuseIdentifier:@"SettingSwitchCell"];
    _tableView.showsVerticalScrollIndicator = NO;
}

-(IBAction)navitoUser:(id)sender
{
    UserInfoViewController *userInfo=[[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userInfo animated:YES];
}
-(IBAction)naviToAbout:(id)sender
{
    AboutSetingViewController *about=[[AboutSetingViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
}

#pragma mark ----- UITableViewDataSource -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 6;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SettingHeaderCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingHeaderCellTableViewCell"];
        [cell setUser:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = NSLocalizedString(@"关于信息", @"关于信息");
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if (indexPath.row == 1){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"检测新版本升级";
            cell.detailTextLabel.text = @"未检测";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if (indexPath.row == 2){
            SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingSwitchCell"];
            cell.textLabel.text = @"WiFi自动下载更新";
            return cell;
        }else if (indexPath.row == 3){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"消息通知设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if (indexPath.row == 4){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = @"24.9k";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if (indexPath.row == 5){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"应用密码设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }

    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark ----- UITableViewDelegate -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 80;
            break;
        case 1:
            return 60;
            break;
            
        default:
            return 0;
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0://头像
        {
            UserInfoViewController *userInfo=[[UserInfoViewController alloc]init];
            [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
            [self.navigationController pushViewController:userInfo animated:YES];
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0://关于信息
                {
                    AboutSetingViewController *about=[[AboutSetingViewController alloc]init];
                    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
                    [self.navigationController pushViewController:about animated:YES];
                }
                    break;
                case 1://检查更新
                {
                    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    CheckForUpdatesVC *vc = [main instantiateViewControllerWithIdentifier:@"CheckForUpdatesVC"];
                    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//                    [self.navigationController pushViewController:vc animated:YES];
                    [self performSegueWithIdentifier:@"CheckForUpdatesVC" sender:nil];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
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

- (IBAction)logoutAction:(UIButton *)sender {
}
@end
