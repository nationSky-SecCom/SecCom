//
//  UserInfoViewController.h
//  SecCom
//
//  Created by duanran on 15/4/29.
//  Copyright (c) 2015年 LB. All rights reserved.
//

#import "BaseViewController.h"
#import "CTAssetsPickerController.h"
#import <AVFoundation/AVFoundation.h>



@interface UserInfoViewController : BaseViewController<UIAlertViewDelegate,CTAssetsPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)IBOutlet UIButton *userPortraitBtn;
@property(nonatomic,strong)IBOutlet UILabel *accountLabel;
@property(nonatomic,strong)IBOutlet UILabel *signLabel;
@property(nonatomic,strong)IBOutlet UILabel *phoneNumLabel;
@property(nonatomic,strong)IBOutlet UILabel *emailLable;

@end
