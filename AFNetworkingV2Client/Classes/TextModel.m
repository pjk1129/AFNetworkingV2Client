//
//  TextModel.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-2-14.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

#pragma mark - override
- (NSDictionary *)attributedMappingsDictionary
{
    /*
     1、子类实现实现该方法:
     dict...
     [dict addEntriesFromDictionary:[super attributedMapDictionary]];
     
     2、键值说明
     value：对象属性名
     key：json键值
     
     带自定义类型的键值说明
     ATTRIBUTE_INFO(@"intrestedApps", @"MAppInfo"), @"intrested_app"
     value：intrestedApps MAppInfo类型
     key：intrested_app
     */
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"qiushiID",@"id", 
                           @"tag", @"tag",
                           @"content", @"content",
                           ATTRIBUTE_INFO_NUMBER(@"commentsCount"), @"comments_count",
                           ATTRIBUTE_INFO_NUMBER(@"published_at"), @"published_at",
                           ATTRIBUTE_INFO_NUMBER(@"downCount"), @"down",
                           ATTRIBUTE_INFO_NUMBER(@"upCount"), @"up",
                           nil];
    return dict;
}

@end
