//
//  CommentsViewController.m
//  AFNetworkingV2Client
//
//  Created by JK.PENG on 14-1-24.
//  Copyright (c) 2014年 njut. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsCell.h"
#import "AFHTTPClientV2.h"
#import "CommentView.h"

@interface CommentsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) QiuShi  *qiuShiContent;
@property (nonatomic, retain) UITableView   *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, retain) CommentView   *commentView;

@end

@implementation CommentsViewController

- (instancetype)initWithQiushi:(QiuShi *)qiushi;
{
    self = [super init];
    if (self) {
        self.qiuShiContent = qiushi;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表评论"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(showCommentView)];
    
    [self loadCommentsData];
}


- (void)sendCommentContent:(NSString *)content
{
    if ([content length]<=0) {
        return;
    }
    
    [self hideCommentView];
    
    //发表评论: POST Header:Qbtoken 参数：{"content" : "啊啊啊","anonymous" : false}
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:content forKey:@"content"];
    [params setObject:@"0" forKey:@"anonymous"];
    NSString  *urlStr = [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comment/create",self.qiuShiContent.qiushiID];
    [AFHTTPClientV2 requestWithBaseURLStr:urlStr params:params httpMethod:HttpMethodPost successBlock:^(id responseObject) {
        NSLog(@"POST responseObject: %@",responseObject);

        
    } failedBlock:^(NSError *error) {
        NSLog(@"POST error: %@",error);

    }];
}

- (void)showCommentView
{
    __weak CommentsViewController  *weakSelf = self;
    [self.commentView setSaveblock:^(NSString *content) {
        CommentsViewController  *strongSelf = weakSelf;
        [strongSelf sendCommentContent:content];
    }];
    [self.commentView show:YES];
}

- (void)hideCommentView
{
    [self.commentView hide:YES];
}

- (void)loadCommentsData
{
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:@"5" forKey:@"count"];
    [params setObject:@"1" forKey:@"page"];
    
    __weak CommentsViewController  *weakSelf = self;
    
    NSString  *urlStr = [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments",self.qiuShiContent.qiushiID];
    
    [AFHTTPClientV2 requestWithBaseURLStr:urlStr params:params httpMethod:HttpMethodGet successBlock:^(id responseObject) {
        
        NSLog(@"GET responseObject: %@",responseObject);
        CommentsViewController  *strongSelf = weakSelf;
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = [responseObject objectForKey:@"items"];
            NSMutableArray  *commentsArray = [NSMutableArray arrayWithCapacity:[array count]];
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *commentsDic = [array objectAtIndex:i];
                Comments *c = [[Comments alloc] initWithDictionary:commentsDic];
                [commentsArray addObject:c];
            }
            strongSelf.dataArray = commentsArray;
        }
        
        
    } failedBlock:^(NSError *error) {
        NSLog(@"GET error: %@",error);

    }];
}

#pragma mark - UITableView datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommentsCellIdentifier";
    CommentsCell *cell = (CommentsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CommentsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.comments = [self.dataArray objectAtIndex:[indexPath row]];
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
    Comments *comments =[self.dataArray objectAtIndex:row];
    // 显示的内容
    NSString *content = comments.content;
    // 计算出长宽
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:NSLineBreakByTruncatingTail];
    // 返回需要的高度
    return size.height +54;
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
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (CommentView *)commentView{
    if (!_commentView) {
        _commentView = [[CommentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _commentView;
}

@end
