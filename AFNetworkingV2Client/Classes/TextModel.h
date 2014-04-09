//
//  TextModel.h
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-2-14.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "PModelBase.h"

@interface TextModel : PModelBase

@property (nonatomic,copy) NSString *qiushiID;                  //糗事ID
@property (nonatomic,copy) NSString *tag;                       //标签
@property (nonatomic,copy) NSString *content;                   //糗事内容
@property (nonatomic,assign) NSTimeInterval published_at;       //发布时间
@property (nonatomic,assign) NSInteger commentsCount;           //评论数量
@property (nonatomic,assign) NSInteger downCount;               //顶的数量
@property (nonatomic,assign) NSInteger upCount;                 //踩的数量

@end
