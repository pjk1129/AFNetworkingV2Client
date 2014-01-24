AFNetworkingV2Client
====================

一、AFHTTPClient是什么？

AFHTTPClient 是在AFNetworkingV2基础上做的改进，主要实现AFHTTPClientV2类，该类根据当前OS进行选择HTTP请求处理方式，
IOS7及其以后，采用AFHTTPSessionManager，IOS7之前采用AFHTTPRequestOperationManager。

二、改进：
１）在AFNetworkingV2中AFHTTPResponseSerializer属性增加@"text/html"
self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
２）在AFHTTPSessionManager和AFHTTPRequestOperationManager类中增加header方法如下：
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

三、使用方法：

工程示例采用糗事百科的嫩草API
/*
- (void)loadData
{
    [self.indicatorView startAnimating];
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:@"5" forKey:@"count"];
    [params setObject:@"1" forKey:@"page"];
    
    __weak QiushiViewController  *weakSelf = self;
    [AFHTTPClientV2 requestWithBaseURLStr:@"http://m2.qiushibaike.com/article/list/latest" params:params httpMethod:HttpMethodGet successBlock:^(id responseObject) {
        
        NSLog(@"GET responseObject: %@",responseObject);
        QiushiViewController  *strongSelf = weakSelf;
        [strongSelf.indicatorView stopAnimating];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = [responseObject objectForKey:@"items"];
            NSMutableArray  *strollArray = [NSMutableArray arrayWithCapacity:[array count]];
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *qiushiDic = [array objectAtIndex:i];
                QiuShi *qs = [[QiuShi alloc] initWithQiuShiDictionary:qiushiDic];
                [strollArray addObject:qs];
            }
            
            strongSelf.dataArray = strollArray;
        }

        
    } failedBlock:^(NSError *error) {
        NSLog(@"GET error: %@",error);
        QiushiViewController  *strongSelf = weakSelf;
        [strongSelf.indicatorView stopAnimating];
    }];
}
*/

四、QA交流

本工程希望能给IOS开发者提供些帮助，同时更希望IOS同行，能提出宝贵意见，欢迎拍砖

新浪微博：http://www.weibo.com/rubbishpicker
CSDN博客：http://blog.csdn.net/pjk1129
