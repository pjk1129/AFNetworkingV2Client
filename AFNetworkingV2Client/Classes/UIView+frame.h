//
//  UIView+frame.h
//  HupuGame
//
//  Created by JK.Peng on 13-11-26.
//  Copyright (c) 2013年 hupu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@end
