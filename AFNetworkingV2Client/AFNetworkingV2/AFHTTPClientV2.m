 //
//  AFHTTPClientV2.m
//  PAFNetClient
//
//  Created by JK.PENG on 14-1-22.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "AFHTTPClientV2.h"

@implementation AFHTTPClientV2

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                             successBlock:(HTTPRequestV2SuccessBlock)successReqBlock
                              failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock
{

    return [self requestWithBaseURLStr:URLString params:params httpMethod:httpMethod userInfo:nil successBlock:successReqBlock failedBlock:failedReqBlock];
}

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                                 userInfo:(NSDictionary*)userInfo
                             successBlock:(HTTPRequestV2SuccessBlock)successReqBlock
                              failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock
{
    AFHTTPClientV2 *httpV2 =  [[AFHTTPClientV2 alloc] init];
    httpV2.userInfo = userInfo;
        
    CGFloat  sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion < 7.0) {
        AFHTTPRequestOperationManager   *httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        if (httpMethod == HttpMethodGet) {
            
            [httpClient GET:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
        }else if (httpMethod == HttpMethodPost){
            
            
            [httpClient POST:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
        }else if (httpMethod == HttpMethodDelete){
            
            
            [httpClient DELETE:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
        }

    }else{
        AFHTTPSessionManager   *httpClient = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        if (httpMethod == HttpMethodGet) {
            
            [httpClient GET:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
        }else if (httpMethod == HttpMethodPost){
            
            [httpClient POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
        }else if (httpMethod == HttpMethodDelete){
            
            [httpClient DELETE:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (successReqBlock) {
                    successReqBlock(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failedReqBlock) {
                    failedReqBlock(httpV2, error);
                }
            }];
            
            
        }

    }
    
    return httpV2;
}

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                                 userInfo:(NSDictionary*)userInfo
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure
{
    AFHTTPClientV2 *httpV2 =  [[AFHTTPClientV2 alloc] init];
    httpV2.userInfo = userInfo;
    
    CGFloat  sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion < 7.0) {
        AFHTTPRequestOperationManager   *httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        [httpClient POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(httpV2, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(httpV2, error);
            }
        }];

    }else{
        AFHTTPSessionManager   *httpClient = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        [httpClient POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(httpV2, responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(httpV2, error);
            }
        }];
    }
    return httpV2;
}

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure
{
    return [self requestWithBaseURLStr:URLString parameters:parameters userInfo:nil constructingBodyWithBlock:block success:success failure:failure];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    AFHTTPClientV2  *clientV2 = [[self class] init];
    [clientV2 setUserInfo:[[self userInfo] copyWithZone:zone]];
    return clientV2;
}

@end
