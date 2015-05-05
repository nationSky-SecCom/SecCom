//
//  BaseRequest.m
//  SecCom
//
//  Created by libo on 4/20/15.
//  Copyright (c) 2015 LB. All rights reserved.
//

#import "BaseRequest.h"


@interface BaseRequest ()

@property (nonatomic, strong) NSMutableDictionary *parameter;

@end

@implementation BaseRequest

-(id)init
{
    self=[super init];
    if (self) {
//        self.parameters=[[NSMutableDictionary alloc]init];
        _parameter = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

-(AFHTTPRequestOperation *)GETRequest:(successHandler)success Failure:(failureHandler)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (self.HTTPHeader) {
        [_HTTPHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSAssert(![key isKindOfClass:[NSString class]], @"key must be an string");
            NSAssert(![obj isKindOfClass:[NSString class]], @"key must be an string");
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

    if (self.parameters) {
        [_parameter addEntriesFromDictionary:self.parameters];
    }
    self.operation = [manager GET:self.requestURL
                       parameters:_parameter
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              responseModel *response = [[responseObject objectForKey:@"response"] objectForKey:@"result"];

                              if ([response.code isEqualToString:@"200"]) {
                                  success([self assembleResponseModel:responseObject]);
                              }else{
                                  failure([self handleErrorMessage:responseObject]);
                              }
                              
                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              failure([self handleErrorMessage:error]);
                          }];
    

    return self.operation;
}

-(AFHTTPRequestOperation *)POSTRequest:(successHandler)success Failure:(failureHandler)failure;
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (self.HTTPHeader) {
        [_HTTPHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSAssert(![key isKindOfClass:[NSString class]], @"key must be an string");
            NSAssert(![obj isKindOfClass:[NSString class]], @"key must be an string");
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    if (self.parameters) {
        [_parameter addEntriesFromDictionary:self.parameters];
    }
    NSLog(@"self.requestURL=%@",self.requestURL);
    self.operation = [manager POST:self.requestURL
                        parameters:_parameter
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               responseModel *response = [responseModel objectWithKeyValues: [[responseObject objectForKey:@"response"] objectForKey:@"result"]];
                               if ([response.code isEqualToString:@"200"]) {
                                   success([self assembleResponseModel:[[responseObject objectForKey:@"response"] objectForKey:@"resultData"]]);
                               }else{
                                   failure([self handleErrorMessage:responseObject]);
                               }
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure([self handleErrorMessage:error]);
                           }];
    
    
    return self.operation;
}


#pragma mark ----- 设置 HTTP 头 -----
- (NSDictionary *)HTTPHeader{
    return nil;
    
    //子类使用示例
    return @{@"Content-Type": @"application/json;charset=UTF-8"};
}

#pragma mark ----- 获取请求 URL -----
- (NSString *)requestURL{
    NSAssert(NO, @"请重载");
    return @"";
    
    //子类使用示例
    return [RequestURL urlWithTpye:UrlTypeLogin];
}

#pragma mark ----- 将返回结果转换ViewController可以处理的model -----
- (id)assembleResponseModel:(id)responseObject{
    return responseObject;
}

#pragma mark ----- 处理请求失败 -----
- (NSString *)handleRequestError:(id)responseObject{
    dispatch_async(dispatch_get_main_queue(), ^{
        //统一弹出提示框
    });
    return [responseObject objectForKey:@"return_type"];
}

#pragma mark -----  对请求失败进行处理 -----
- (NSString *)handleErrorMessage:(NSError *)error{
    return error.localizedDescription;
}


@end
