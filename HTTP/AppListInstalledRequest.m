//
//  AppListInstalledRequest.m
//  SecCom
//
//  Created by libo on 4/21/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "AppListInstalledRequest.h"

@implementation AppListInstalledRequest

- (NSString *)requestURL{
    return [RequestURL urlWithTpye:UrlTypeApplistInstall];
}

+ (NSDictionary *)HTTPHeader{
    return nil;
}

#pragma mark ----- 将返回结果转换ViewController可以处理的model -----
- (id)assembleResponseModel:(id)responseObject{
    return responseObject;
}


@end
