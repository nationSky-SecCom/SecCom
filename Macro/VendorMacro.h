//
//  VendorMacro.h
//  NQYoungCloud
//
//  Created by libo on 14-6-13.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#ifndef NQYoungCloud_VendorMacro_h
#define NQYoungCloud_VendorMacro_h

//QQ


//数据库


// dock 宽度


// 用户状态


//后台返回唯一确定用户
#define SessionID           @"sessionId"
#define SessionIDInfo       [[NSUserDefaults standardUserDefaults] objectForKey:SessionID]
#define USER_ID             @"userId"
#define USER_IDInfo         [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]


//用户名密码
#define userNmae @"userName";
#define userPassword @"userPassword";

//是否登录
#define  USER_LOGIN         @"user_login"

#endif
