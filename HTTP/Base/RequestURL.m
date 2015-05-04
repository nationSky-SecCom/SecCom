//
//  RequestURL.m
//  SecCom
//
//  Created by libo on 4/20/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "RequestURL.h"
//开发服务器
#define BaseUrl @"http://192.168.1.140:8080/"
//田涛主机
//#define BaseUrl @"http://192.168.7.237:8080/"

#define Number(n) [NSNumber numberWithInteger:n]

@implementation RequestURL



+ (NSString *)urlWithTpye:(UrlType)urltype{
    
    static NSDictionary *urlDictionary = nil;
    if (!urlDictionary) {
        urlDictionary = @{Number(UrlTypeLogin)                      :     @"",
                          Number(UrlTypeApplistAll)                 :     @"mam/v1/getapplist",
                          Number(UrlTypeApplistInstall)             :     @"",
                          Number(UrlTypeApplistUnInstall)           :     @"",
                          Number(UrlTypeAppDetails)                 :     @"mam/v1/appdetail",
                          Number(UrlTypeUserInfo)                   :     @"",
                          Number(URLTypeActiveDevice)               :     @"mam/v2/userauth",
                         };
    }
    NSString *urlString = [urlDictionary objectForKey:Number(urltype)];
    NSAssert(urlString, @"URL 为空");

    return [BaseUrl stringByAppendingString:urlString];
}

@end
