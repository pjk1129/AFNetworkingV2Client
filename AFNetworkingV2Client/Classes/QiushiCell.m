//
//  QiushiCell.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-23.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "QiushiCell.h"

@implementation QiushiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self bgImageView];
        [self avatarImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setQiuShi:(QiuShi *)qiuShi{
    if (_qiuShi != qiuShi) {
        _qiuShi = qiuShi;
        
        [self.avatarImageView setImageWithURLString:_qiuShi.authorImageURL
                                   placeholderImage:[UIImage imageNamed:@"thumb_avatar"]];
        
        self.authorLabel.text = [_qiuShi.author length]<=0?@"匿名":_qiuShi.author;
        self.txtContent.text = _qiuShi.content;
        [self.txtContent sizeToFit];
        
        self.txtContent.frame = CGRectMake(20, CGRectGetMaxY(self.avatarImageView.frame)+10, 280, self.txtContent.frame.size.height);
        
        if (_qiuShi.imageURL==nil || [_qiuShi.imageURL length]<=0) {
            self.picImageView.hidden = YES;
            self.bgImageView.frame = CGRectMake(0, 0, 320, CGRectGetMaxY(self.txtContent.frame)+20);
        }else{
            self.picImageView.hidden = NO;
            self.picImageView.frame = CGRectMake(CGRectGetMinX(self.txtContent.frame), CGRectGetMaxY(self.txtContent.frame)+10, 125, 125);
            [self.picImageView setImageWithURLString:_qiuShi.imageMidURL
                                    placeholderImage:[UIImage imageNamed:@"thumb_pic"]];

            self.bgImageView.frame = CGRectMake(0, 0, 320, CGRectGetMaxY(self.picImageView.frame)+20);

        }

    }
}

#pragma mark - getter
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.image = [[UIImage imageNamed:@"bg_content"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 160, 15, 160) resizingMode:UIImageResizingModeStretch];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UILabel *)txtContent{
    if (!_txtContent) {
        _txtContent = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 220)];
        [_txtContent setBackgroundColor:[UIColor clearColor]];
        [_txtContent setFont:[UIFont fontWithName:@"Arial" size:14]];
        [_txtContent setLineBreakMode:NSLineBreakByTruncatingTail];
        _txtContent.numberOfLines = 0;
        [self.contentView addSubview:_txtContent];
    }
    return _txtContent;
}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 24, 24)];
        [_avatarImageView setImage:[UIImage imageNamed:@"thumb_avatar"]];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarImageView.clipsToBounds = YES;
        [self addSubview:_avatarImageView];
    }
    return _avatarImageView;
}

- (UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+10, CGRectGetMinY(self.avatarImageView.frame), 320-CGRectGetMaxX(self.avatarImageView.frame)-20, CGRectGetHeight(self.avatarImageView.frame))];
        [_authorLabel setText:@"匿名"];
        [_authorLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [_authorLabel setBackgroundColor:[UIColor clearColor]];
        [_authorLabel setTextColor:[UIColor brownColor]];
        [self.contentView addSubview:_authorLabel];
    }
    return _authorLabel;
}

- (UIImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 125, 125)];
        [_picImageView setImage:[UIImage imageNamed:@"thumb_pic"]];
        _picImageView.contentMode = UIViewContentModeScaleAspectFit;
        _picImageView.clipsToBounds = YES;
        [self addSubview:_picImageView];
    }
    return _picImageView;
}
@end
