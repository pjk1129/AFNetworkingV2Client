//
//  QiushiCell.h
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-23.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiuShi.h"

@interface QiushiCell : UITableViewCell

@property (nonatomic, retain) UIImageView   *bgImageView;
@property (nonatomic, retain) UIImageView   *avatarImageView;
@property (nonatomic, retain) UILabel       *authorLabel;
@property (nonatomic, retain) UILabel       *txtContent;
@property (nonatomic, retain) UIImageView   *picImageView;

@property (nonatomic, retain) QiuShi   *qiuShi;


@end
