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
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor=[UIColor grayColor];
    
    
}
-(BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}
-(IBAction)navi
{
    
    if (self.serverAddressField.text.length==0||self.userNameField.text.length==0||self.userPasswordField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名、密码、服务器地址不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    
    ActiveDeviceRequest *activeRequest=[[ActiveDeviceRequest alloc]init];
    activeRequest.parameters=@{
                                @"operId":@{
                                            @"tokenId":@"",
                                            @"userId":@"",
                                            @"deviceId":@"",
                                            @"requestId":@""
                                    },
                                @"requestData":@{
                                    @"userInfo":@{
                                            @"username":@"",
                                            @"password":@""
                                            },
                               @"deviceInfo":@{
                                    @"OSVersion":@"",
                                    @"model":@"",
                                    @"modelType":@"",
                                    @"deviceName":@"",
                                    @"clientOS":@"",
                                    @"jailed":@"",
                                    @"Idfa":@"",
                                    @"SN":@"",
                                    @"WIFIMAC":@""}
                               }
                            };
    [activeRequest POSTRequest:^(id responseObject) {
        HomeViewController *home=[[HomeViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
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
