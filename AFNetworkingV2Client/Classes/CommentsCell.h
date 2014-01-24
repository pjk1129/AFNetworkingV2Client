//
//  CommentsCell.h
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-24.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comments.h"

@interface CommentsCell : UITableViewCell

@property (nonatomic, retain) UIImageView   *bgImageView;
@property (nonatomic, retain) UIImageView   *lineImageView;

@property (nonatomic, retain) UIImageView   *avatarImageView;
@property (nonatomic, retain) UILabel       *authorLabel;
@property (nonatomic, retain) UILabel       *contentLabel;
@property (nonatomic, retain) UILabel       *floorLabel;   //楼层

@property (nonatomic, retain) Comments      *comments;

@end
