//
//  AFHTTPClientV2.h
//  PAFNetClient
//
//  Created by JK.PENG on 14-1-22.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum HttpMethod{
    HttpMethodGet      = 0,
    HttpMethodPost     = 1,
    HttpMethodDelete   = 2,
}HttpMethod;

@class AFHTTPClientV2;

typedef void (^HTTPRequestV2SuccessBlock)(AFHTTPClientV2 *request, id responseObject);
typedef void (^HTTPRequestV2FailedBlock)(AFHTTPClientV2 *request, NSError *error);


@interface AFHTTPClientV2 : NSObject<NSCopying>

@property (nonatomic, strong) NSDictionary *userInfo;

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                             successBlock:(HTTPRequestV2SuccessBlock)successReqBlock
                              failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock;

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                                 userInfo:(NSDictionary*)userInfo
                             successBlock:(HTTPRequestV2SuccessBlock)successReqBlock
                              failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock;


+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                                 userInfo:(NSDictionary*)userInfo
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;

@end
