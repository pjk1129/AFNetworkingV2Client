//
//  AFHTTPClientV2.m
//  PAFNetClient
//
//  Created by JK.PENG on 14-1-22.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "AFHTTPClientV2.h"

#ifdef DEBUG
#define AFNSLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define AFNSLog(xx, ...)  ((void)0)
#endif

@implementation AFHTTPClientV2

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HttpMethod)httpMethod
                             successBlock:(HTTPRequestV2SuccessBlock)successReqBlock
                              failedBlock:(HTTPRequestV2FailedBlock)failedReqBlock
{
    AFHTTPClientV2   *httpClient = [[AFHTTPClientV2 alloc] initWithBaseURL:nil];
        
    if (httpMethod == HttpMethodGet) {

        NSString   *urlStr = URLString;
        if ([params count]>0) {
            NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:0];
            [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
            }];
            
            NSString  *paramsString = [pairs componentsJoinedByString:@"&"];
            NSInteger questLocation = [URLString rangeOfString:@"?"].location;
            if (questLocation != NSNotFound) {
                urlStr = [NSString stringWithFormat:@"%@&%@",URLString,paramsString];
            }else{
                urlStr = [NSString stringWithFormat:@"%@?%@",URLString,paramsString];
            }
        }
        
        AFNSLog(@"urlStr: %@",urlStr);

        
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && defined(VerIsiOS7_Or_Later))

        [httpClient GET:urlStr parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
#else
        
        [httpClient GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
        
#endif
        
    }else if (httpMethod == HttpMethodPost){
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && defined(VerIsiOS7_Or_Later))
        [httpClient POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
        
#else
        
        [httpClient POST:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
        
#endif
   
    }else if (httpMethod == HttpMethodDelete){
        
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && defined(VerIsiOS7_Or_Later))
        [httpClient DELETE:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
        
#else
        
        [httpClient DELETE:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (successReqBlock) {
                successReqBlock(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failedReqBlock) {
                failedReqBlock(error);
            }
        }];
        
#endif
   
    }
    
    return httpClient;
}


@end
