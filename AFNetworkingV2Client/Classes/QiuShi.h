//
//  QiuShi.h
//  XWQSBK
//
//  Created by Ren XinWei on 13-5-3.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief 糗事
 */
@interface QiuShi : NSObject

@property (nonatomic,copy) NSString *imageURL;                  //小图片地址
@property (nonatomic,copy) NSString *imageMidURL;               //中等图片地址
@property (nonatomic,copy) NSString *authorImageURL;            //作者头像地址
@property (nonatomic,copy) NSString *tag;                       //标签
@property (nonatomic,copy) NSString *author;                    //作者
@property (nonatomic,copy) NSString *authorID;                  //作者ID
@property (nonatomic,copy) NSString *qiushiID;                  //糗事ID
@property (nonatomic,copy) NSString *content;                   //糗事内容
@property (nonatomic,assign) NSTimeInterval published_at;       //发布时间
@property (nonatomic,assign) NSInteger commentsCount;           //评论数量
@property (nonatomic,assign) NSInteger downCount;               //顶的数量
@property (nonatomic,assign) NSInteger upCount;                 //踩的数量


- (id)initWithQiuShiDictionary:(NSDictionary *)dictionary;

@end
