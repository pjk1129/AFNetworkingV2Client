//
//  PModelBase.h
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-2-14.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ATTRIBUTE_INFO(__key__, __className__, __keyClassName__) [NSDictionary dictionaryWithObjectsAndKeys:__key__, @"key",\
__className__, @"className",\
__keyClassName__, @"keyClassName",\
nil]

#define ATTRIBUTE_INFO_NUMBER(__key__) ATTRIBUTE_INFO(__key__, @"NSNull", @"NSNumber")

#define KEY_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"key"]
#define CLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"className"]
#define KEYCLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"keyClassName"]

@interface PModelBase : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

//属性映射字典
//属性名：json数据key
- (NSDictionary *)attributedMappingsDictionary;

@end
