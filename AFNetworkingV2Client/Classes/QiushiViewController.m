//
//  QiushiViewController.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-23.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "QiushiViewController.h"
#import "AFHTTPClientV2.h"
#import "QiushiCell.h"
#import "CommentsViewController.h"
#import "TextModel.h"

@interface QiushiViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView   *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIActivityIndicatorView   *indicatorView;
@end

@implementation QiushiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"嫩草";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];

    [self loadData];
}



- (void)loadData
{
    [self.indicatorView startAnimating];
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:@"5" forKey:@"count"];
    [params setObject:@"1" forKey:@"page"];
    
    __weak QiushiViewController  *weakSelf = self;
    [AFHTTPClientV2 requestWithBaseURLStr:@"http://m2.qiushibaike.com/article/list/latest" params:params httpMethod:HttpMethodGet successBlock:^(AFHTTPClientV2 *request, id responseObject) {
        
        NSLog(@"GET responseObject: %@",responseObject);
        QiushiViewController  *strongSelf = weakSelf;
        [strongSelf.indicatorView stopAnimating];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = [responseObject objectForKey:@"items"];
            NSMutableArray  *strollArray = [NSMutableArray arrayWithCapacity:[array count]];
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *qiushiDic = [array objectAtIndex:i];
                TextModel  *model = [[TextModel alloc] initWithDict:qiushiDic];
                [strollArray addObject:model];
//                QiuShi *qs = [[QiuShi alloc] initWithQiuShiDictionary:qiushiDic];
//                [strollArray addObject:qs];
            }
            
//            strongSelf.dataArray = strollArray;
            NSLog(@"%@",strollArray);
        }

        
    } failedBlock:^(AFHTTPClientV2 *request, NSError *error) {
        NSLog(@"GET error: %@",error);
        QiushiViewController  *strongSelf = weakSelf;
        [strongSelf.indicatorView stopAnimating];
    }];
}

#pragma mark - UITableView datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"QiushiCellIdentifier";
    QiushiCell *cell = (QiushiCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QiushiCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.qiuShi = [self.dataArray objectAtIndex:[indexPath row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getTheHeight:indexPath.row];
}

-(CGFloat) getTheHeight:(NSInteger)row
{
    CGFloat contentWidth = 280;
    // 设置字体
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    
    QiuShi *qs =[self.dataArray objectAtIndex:row];
    // 显示的内容
    NSString *content = qs.content;
    // 计算出长宽
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:NSLineBreakByTruncatingTail];
    CGFloat height;
    if (qs.imageURL==nil || [qs.imageURL length]<=0) {
        height = size.height+64;
    }else
    {
        height = size.height+135+64;
    }
    // 返回需要的高度
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CommentsViewController  *comments = [[CommentsViewController alloc] initWithQiushi:[self.dataArray objectAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:comments animated:YES];
}

#pragma mark - getter
- (void)setDataArray:(NSMutableArray *)dataArray{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        
        [self.myTableView reloadData];
    }

}

#pragma mark - getter
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

@end
