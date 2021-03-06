//
//  LoginVC.m
//  SecCom
//
//  Created by duanran on 15/4/21.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "LoginVC.h"
#import "HomeViewController.h"
#import "ActiveDeviceRequest.h"
#import "JSONKit.h"
#import "DeviceInfoUtil.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.userNameField.placeholder=@"用户名";
    self.userPasswordField.placeholder=@"密码";
    self.navigationController.navigationBarHidden=YES;
    
    
}
-(BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}
-(IBAction)navi
{
    
    if (self.userNameField.text.length==0||self.userPasswordField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    

    NSString *idfa = [DeviceInfoUtil IDFA];
    NSString *clientOS=[DeviceInfoUtil getOS];
    NSString *modelType=[DeviceInfoUtil getModelType];
    NSString *jailed=[DeviceInfoUtil getJailBreakStatus];
    NSString *wifiMac=[DeviceInfoUtil macaddress];
    NSString *deviceName=[DeviceInfoUtil getName];
    NSString *model=[DeviceInfoUtil getModel];
    NSString *deviceVersion=[DeviceInfoUtil getOSVersion];

    
    NSLog(@"clientOS=%@",clientOS);
    NSLog(@"idfa=%@",idfa);
    NSLog(@"modelType=%@",modelType);
    NSLog(@"jailed=%@",jailed);
    NSLog(@"wifiMac=%@",wifiMac);
    NSLog(@"deviceName=%@",deviceName);
    NSLog(@"model=%@",model);
    NSLog(@"deviceVersion=%@",deviceVersion);

    ActiveDeviceRequest *activeRequest=[[ActiveDeviceRequest alloc]init];
    
    
    activeRequest.parameters=@{
                               @"request":@{
                                @"operId":@{
                                            @"tokenId":@"",
                                            @"userId":@"",
                                            @"deviceId":@"",
                                            @"requestId":@""
                                    },
                                @"requestData":@{
                                    @"userInfo":@{
                                            @"userName":@"test",
                                            @"password":@"RJKctynh0Ps="
                                            },
                               @"deviceInfo":@{
                                    @"OSVersion":deviceVersion,
                                    @"model":@"",
                                    @"modelType":@"23",
                                    @"deviceName":@"",
                                    @"clientOS":@"2",
                                    @"jailed":@"0",
                                    @"Idfa":@"D21F2394-CFCA-489F-AEC4-1AD341E4331D",
                                    @"SN":@"",
                                    @"WIFIMAC":@""}
                               }
                            }
                            };
    [activeRequest POSTRequest:^(id responseObject) {
        
        self.activeResponseDic=(NSDictionary *)responseObject;
        
        if (self.activeResponseDic.count>0) {
            NSString *profileUrl=[self.activeResponseDic objectForKey:@"profileUrl"];
            NSLog(@"profileUrl=%@",profileUrl);
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:profileUrl]];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"无下载地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
//        HomeViewController *home=[[HomeViewController alloc]init];
//        [self.navigationController pushViewController:home animated:YES];
    } Failure:^(NSString *errorMessage) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    
    
}

#pragma mark-关闭虚拟键盘
- (IBAction)backgroundTap:(id)sender {
    
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews) {
        if ([objInput isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder]) {
                NSTimeInterval animationDuration = 0.30f;
                [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
                [UIView setAnimationDuration:animationDuration];
                CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
                self.view.frame = rect;
                [UIView commitAnimations];
                [theTextField resignFirstResponder];
            }
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 256-25);//键盘高度256
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
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
