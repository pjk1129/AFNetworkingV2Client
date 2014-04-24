//
//  PModelBase.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-2-14.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "PModelBase.h"

@interface PModelBase()

- (void)setupObjAttributeWithDict:(NSDictionary *)dict;
@end

@implementation PModelBase

#pragma mark - public
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        [self setupObjAttributeWithDict:dict];
    }
    return self;
}

#pragma mark - private
- (void)setupObjAttributeWithDict:(NSDictionary *)dict{
    if (dict==nil || ![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary *attrMapDic = [self attributedMappingsDictionary];
    if (nil==attrMapDic || [attrMapDic count] == 0) {
        return;
    }
    
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id jsonKey;
    while ((jsonKey = [keyEnum nextObject])) {
        id value = [dict objectForKey:jsonKey];
        id attributeContainer = [attrMapDic objectForKey:jsonKey];
        NSString *attributeName = nil;
        if ([attributeContainer isKindOfClass:[NSString class] ] ) {
            attributeName = attributeContainer;

        }else{
            attributeName = KEY_FROM_ATTRIBUTE_INFO(attributeContainer);
            NSString *classNameForSubobj = KEYCLASSNAME_FROM_ATTRIBUTE_INFO(attributeContainer);
            if ([value isKindOfClass:[NSDictionary class] ]) {
                Class class = NSClassFromString(classNameForSubobj);
                if ([class isSubclassOfClass:[PModelBase class] ]) {
                    value = [[class alloc] initWithDict:value];
                }
            }else if ([value isKindOfClass:[NSArray class] ]){
                Class class = NSClassFromString(classNameForSubobj);
                if ([class isSubclassOfClass:[PModelBase class] ]) {
                    NSMutableArray *rstArray = [NSMutableArray arrayWithCapacity:0];
                    for (NSDictionary *dict in value) {
                        PModelBase *aModel = [[class alloc] initWithDict:dict];
                        [rstArray addObject:aModel];
                    }
                    value = rstArray;
                }
            }
        }
        
        NSString *valueClassName = nil;
        if ([attributeContainer isKindOfClass:[NSDictionary class]]) {
            valueClassName = CLASSNAME_FROM_ATTRIBUTE_INFO(attributeContainer);
            if ([valueClassName isEqualToString:@"NSNull"]) {
                valueClassName = KEYCLASSNAME_FROM_ATTRIBUTE_INFO(attributeContainer);
            }
        }else{
            valueClassName = @"NSString";
        }
        
        if (![value isKindOfClass:NSClassFromString(valueClassName)]) {
            value = nil;
        }
        
        if ([valueClassName isEqualToString:@"NSString"]) {
            if (nil!=value && [value isEqualToString:@""]) {
                value = nil;
            }
        }
        
        if (nil!=value) {
            [self setValue:value forKey:attributeName];
        }
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

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
     ATTRIBUTE_INFO(@"intrestedApps", @"NSArray", @"MAppInfo")  @"intrested_app"
     value：intrestedApps MAppInfo类型
     key：intrested_app
     */
    return nil;
}

@end
