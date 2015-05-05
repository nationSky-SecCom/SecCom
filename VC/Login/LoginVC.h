//
//  LoginVC.h
//  SecCom
//
//  Created by duanran on 15/4/21.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"

@interface LoginVC : BaseViewController<SlideNavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)SlideNavigationController *mySliderNavigationContorller;
//@property(nonatomic,strong)IBOutlet UITextField *serverAddressField;
@property(nonatomic,strong)IBOutlet UITextField *userNameField;
@property(nonatomic,strong)IBOutlet UITextField *userPasswordField;
@property(nonatomic,strong)NSDictionary *activeResponseDic;
@end
