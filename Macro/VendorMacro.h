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
/*
 获取私人图片路径
 */

//NS_INLINE id getPrivateImgPath(NSString *tenantsId,NSString *userName)
//{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSString  * TenantsPath=[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",tenantsId]];
//    NSFileManager *file=[NSFileManager defaultManager];
//    NSString *userPath;
//    NSString *imgPath;
//    if ([file fileExistsAtPath:TenantsPath]==YES) {
//        userPath=[TenantsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",userName]];
//        if ([file fileExistsAtPath:userPath]==YES) {
//            imgPath=[userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img"]];
//        }
//        else
//        {
//            [file createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:nil];
//            imgPath=[userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img"]];
//        }
//    }
//    else
//    {
//        [file createDirectoryAtPath:TenantsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        userPath=[TenantsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",userName]];
//        if ([file fileExistsAtPath:userPath]==YES) {
//            imgPath=[userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img"]];
//        }
//        else
//        {
//            [file createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:nil];
//            imgPath=[userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img"]];
//        }
//        
//    }
//    
//    
//    return imgPath;
//}
/*
 获得项目路径
 */
NS_INLINE id getProJectPath(NSString *proJectName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString  * TenantsPath=[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",proJectName]];
    
    NSFileManager *file=[NSFileManager defaultManager];
    if ([file fileExistsAtPath:TenantsPath]) {
        return TenantsPath;
    }
    else
    {
        [file createDirectoryAtPath:TenantsPath withIntermediateDirectories:YES attributes:nil error:nil];
        return TenantsPath;
    }
}
/*
获得用户路径
*/
NS_INLINE id getUserPath(NSString *projectPath,NSString *userName)
{
   NSString *userPath=[projectPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",userName]];
    NSFileManager *file=[NSFileManager defaultManager];
    if ([file fileExistsAtPath:userPath]) {
        return userPath;
    }
    else
    {
        [file createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:nil];
        return userPath;
    }
}
/*
 获得用户图片路径
 */
NS_INLINE id getUserImgPath(NSString *userPath)
{
    NSString *userImgPath=[userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img"]];
    NSFileManager *file=[NSFileManager defaultManager];
    if ([file fileExistsAtPath:userImgPath]) {
        return userImgPath;
    }
    else
    {
        [file createDirectoryAtPath:userImgPath withIntermediateDirectories:YES attributes:nil error:nil];
        return userImgPath;
    }
}




#endif
