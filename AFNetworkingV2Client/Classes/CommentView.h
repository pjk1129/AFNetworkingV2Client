//
//  NewsCommentView.h
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-24.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CommentViewBlock)(NSString *content);

@interface CommentView : UIView

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

- (void)setSaveblock:(CommentViewBlock)saveblock;

@end
