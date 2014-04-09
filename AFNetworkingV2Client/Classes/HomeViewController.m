//
//  HomeViewController.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-22.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "HomeViewController.h"
#import "AFHTTPClientV2.h"
#import "UIImageView+WebCache.h"
#import "QiushiViewController.h"


@interface HomeViewController ()

@property (nonatomic, retain) UIImageView   *imageView;
@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"示例";

    UIButton   *button0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button0.frame = CGRectMake(0, 0, 100, 40);
    [button0 setTitle:@"测试图片" forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(imageRequest) forControlEvents:UIControlEventTouchUpInside];
    button0.center = CGPointMake(160, self.view.center.y-100);
    [self.view addSubview:button0];
    
    
    UIButton   *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 200, 40);
    [button setTitle:@"糗事嫩草" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(apiTestGet) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(160, self.view.center.y-40);
    [self.view addSubview:button];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)+10, CGRectGetWidth(button.frame), self.view.bounds.size.height-CGRectGetMaxY(button.frame)-40)];
    _imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_imageView];
}

- (void)apiTestGet
{
    QiushiViewController  *controller = [[QiushiViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)imageRequest
{
    id urlStr = @"http://img0.bdstatic.com/img/image/249b58f8c5494eef01f0c8570a8e2fe9925bd317dcd.jpg";
    urlStr = @"http://b1.hoopchina.com.cn/games/core/20140215_jeep.jpg#1#_640x1136.jpg";
    [_imageView setImageWithURLString:urlStr
                     placeholderImage:[UIImage imageNamed:@"Icon_120.png"]];
}



@end
