//
//  CommentsCell.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-24.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "CommentsCell.h"

@implementation CommentsCell

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

#pragma mark - setter
- (void)setComments:(Comments *)comments{
    if (_comments != comments) {
        _comments = comments;
        
        self.authorLabel.text = [_comments.anchor length]<=0?@"匿名":_comments.anchor;
        self.floorLabel.text = [NSString stringWithFormat:@"%d",_comments.floor];

        self.contentLabel.text = _comments.content;
        [self.contentLabel sizeToFit];
        
        self.contentLabel.frame = CGRectMake(20, CGRectGetMaxY(self.authorLabel.frame)+10, 280, self.contentLabel.frame.size.height);
        
        self.bgImageView.frame = CGRectMake(0, 0, 320, CGRectGetMaxY(self.contentLabel.frame)+10);
        self.lineImageView.frame = CGRectMake(5, CGRectGetHeight(self.bgImageView.frame)-2, 310, 2);

    }
}


#pragma mark - getter
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.image = [[UIImage imageNamed:@"bg_cell_center"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 160, 15, 160) resizingMode:UIImageResizingModeStretch];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 220)];
        [_contentLabel setBackgroundColor:[UIColor clearColor]];
        [_contentLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [_contentLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
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

- (UIImageView *)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_cell_line"]];
        _lineImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lineImageView];
    }
    return _lineImageView;
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

- (UILabel *)floorLabel{
    if (!_floorLabel) {
        _floorLabel = [[UILabel alloc]initWithFrame:CGRectMake(290,4, 50, 30)];
        [_floorLabel setText:@"1"];
        [_floorLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [_floorLabel setBackgroundColor:[UIColor clearColor]];
        [_floorLabel setTextColor:[UIColor brownColor]];
        [self.contentView addSubview:_floorLabel];
    }
    return _floorLabel;
}


@end
