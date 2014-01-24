//
//  QiuShi.m
//  XWQSBK
//
//  Created by Ren XinWei on 13-5-3.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import "QiuShi.h"

@implementation QiuShi

- (id)initWithQiuShiDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (((NSString *)[dictionary objectForKey:@"tag"]).length > 0) {
            self.tag = [dictionary objectForKey:@"tag"];
        }
        
        self.qiushiID = [dictionary objectForKey:@"id"];
        self.content = [dictionary objectForKey:@"content"];
        self.published_at = [[dictionary objectForKey:@"published_at"] doubleValue];
        self.commentsCount = [[dictionary objectForKey:@"comments_count"] integerValue];
        
        
        id image = [dictionary objectForKey:@"image"];
        if ((NSNull *)image != [NSNull null]) {
            self.imageURL = [dictionary objectForKey:@"image"];
            NSString *prefixQiuShiID = [_qiushiID substringWithRange:NSMakeRange(0, 4)];
            NSString *newImageURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/small/%@", prefixQiuShiID, _qiushiID, _imageURL];
            NSString *newImageMidURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/medium/%@", prefixQiuShiID, _qiushiID,_imageURL];
            self.imageURL = newImageURL;
            self.imageMidURL = newImageMidURL;
        }
        
        NSDictionary *vote = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"votes"]];
        self.downCount = [[vote objectForKey:@"down"] integerValue];
        self.upCount = [[vote objectForKey:@"up"] integerValue];
        
        id user = [dictionary objectForKey:@"user"];
        if ((NSNull *)user != [NSNull null]) {
            NSDictionary *user = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"user"]];
            self.author = [user objectForKey:@"login"];
            self.authorID = [user objectForKey:@"id"];
            self.authorImageURL = [user objectForKey:@"icon"];
            if ([self.authorID length] > 3) {
                NSString *prefixAuthorID = [_authorID substringWithRange:NSMakeRange(0, 3)];
                NSString *newAuthorImageURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/avtnew/%@/%@/thumb/%@", prefixAuthorID, _authorID, _authorImageURL];
                self.authorImageURL = newAuthorImageURL;
            }
        }
    }
    
    return self;
}

- (void)dealloc
{
    _imageURL = nil;
    _imageMidURL = nil;
    _authorImageURL = nil;
    _tag = nil;
    _author = nil;
    _authorID = nil;
    _qiushiID = nil;
    _content = nil;    
}

@end