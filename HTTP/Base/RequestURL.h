//
//  RequestURL.h
//  SecCom
//
//  Created by libo on 4/20/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UrlType){
    UrlTypeLogin,                   /* 登录 */
    UrlTypeApplistAll,              /* 所有应用列表 */
    UrlTypeApplistInstall,          /* 已安装应用列表 */
    UrlTypeApplistUnInstall,        /* 未安装应用列表 */
    UrlTypeAppDetails,              /* 应用详情 */
    UrlTypeUserInfo,                /* 用户信息 */
    UrlTypeAppInstall,              /* 安装应用 */
    URLTypeActiveDevice,            /* 激活设备 */
};

@interface RequestURL : NSObject





/*
 * 根据URL类型获取url
 */
+ (NSString *)urlWithTpye:(UrlType)urltype;




@end
