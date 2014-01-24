//
//  NewsCommentView.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-24.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import "CommentView.h"

@interface CommentView()<UIGestureRecognizerDelegate,UITextViewDelegate>{
    CommentViewBlock   _saveblock;
}

@property (nonatomic, retain) UIImageView   *containerView;
@property (nonatomic, retain) UITextView    *inputTextField;
@property (nonatomic, retain) UIButton      *sendBtn;
@property (nonatomic, retain) UILabel       *placeHoldLabel;

@end

@implementation CommentView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
        [self addSubview:self.containerView];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeButtonTapped)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    }
    return self;
}

#pragma mark keyboardNotification
- (void)keyboardWillShow:(NSNotification*)notification{
    CGRect  keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.containerView.bottom = [UIScreen mainScreen].bounds.size.height-keyboardRect.size.height;
    
}

- (void)setSaveblock:(CommentViewBlock)saveblock
{
    _saveblock = [saveblock copy];
}

- (void)show:(BOOL)animated
{
    [self.inputTextField becomeFirstResponder];
    if (animated){
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, [UIScreen mainScreen].bounds.size.height);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.frame = [UIScreen mainScreen].bounds;
                         }
                         completion:^(BOOL finished) {
                         }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}

- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    self.inputTextField.text = @"";
    self.placeHoldLabel.hidden = self.sendBtn.enabled = NO;

    if (animated){
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 320, [UIScreen mainScreen].bounds.size.height);
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
    else{
        [self removeFromSuperview];
    }

}

- (void)closeButtonTapped {
    [self hide:YES];
}

- (void)sendButtonTapped
{
    if (_saveblock) {
        _saveblock(self.inputTextField.text);
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([[touch view]isKindOfClass:[UIImageView class]] || [[touch view] isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
     _placeHoldLabel.hidden = _sendBtn.enabled = [textView.text length] != 0;
}

#pragma mark - getter
- (UIImageView *)containerView{
    if (!_containerView) {
        _containerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 320, 112)];
        _containerView.userInteractionEnabled = YES;
        _containerView.backgroundColor = [UIColor colorWithRed:0.9255 green:0.9255 blue:0.9255 alpha:1];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 6, 25, 25)];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"news_comment_close_btn"] forState:UIControlStateNormal];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"news_comment_close_btn_1"] forState:UIControlStateHighlighted];
        [closeBtn addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:closeBtn];
        
        
        UILabel *paneTitle = [[UILabel alloc] init];
        paneTitle.font = [UIFont boldSystemFontOfSize:18];
        paneTitle.textColor = [UIColor blackColor];
        paneTitle.backgroundColor = [UIColor clearColor];
        paneTitle.text = @"我来评论";
        [paneTitle sizeToFit];
        paneTitle.centerX = _containerView.width/2;
        paneTitle.centerY = closeBtn.centerY;
        [_containerView addSubview:paneTitle];
        
        self.sendBtn.enabled = NO;
        [_containerView addSubview:self.sendBtn];
        self.sendBtn.centerY = closeBtn.centerY;
        self.inputTextField.frame = CGRectMake(10, closeBtn.bottom + 6, 300, 62);
        [_containerView addSubview:self.inputTextField];
        
        self.placeHoldLabel.left = self.inputTextField.left + 6;
        self.placeHoldLabel.top = self.inputTextField.top + 7;
        [_containerView addSubview:self.placeHoldLabel];
        
    }
    return _containerView;
}

- (UITextView *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextView alloc] initWithFrame:CGRectZero];
        _inputTextField.delegate = self;
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.font = [UIFont systemFontOfSize:15];
        _inputTextField.textColor = [UIColor blackColor];
        _inputTextField.layer.borderColor = [UIColor colorWithRed:0.7647 green:0.7647 blue:0.7647 alpha:1].CGColor;
        _inputTextField.layer.borderWidth = 1;
    }
    return _inputTextField;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(self.bounds.size.width-24-10, 7, 24, 24);
        [_sendBtn setBackgroundImage:[UIImage imageNamed:@"news_comment_send_btn"] forState:UIControlStateNormal];
        [_sendBtn setBackgroundImage:[UIImage imageNamed:@"news_comment_send_btn_1"] forState:UIControlStateHighlighted];
        [_sendBtn setBackgroundImage:[UIImage imageNamed:@"news_comment_send_btn_disable"] forState:UIControlStateDisabled];
        [_sendBtn addTarget:self action:@selector(sendButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UILabel *)placeHoldLabel
{
    if (!_placeHoldLabel) {
        _placeHoldLabel = [[UILabel alloc] init];
        _placeHoldLabel.backgroundColor = [UIColor clearColor];
        _placeHoldLabel.font = [UIFont systemFontOfSize:18];

        _placeHoldLabel.textColor = [UIColor colorWithRed:0x99/255 green:0x99/255 blue:0x99/255 alpha:1.0];
        _placeHoldLabel.text = @"我来评论...";
        [_placeHoldLabel sizeToFit];
    }
    return _placeHoldLabel;
}

@end
