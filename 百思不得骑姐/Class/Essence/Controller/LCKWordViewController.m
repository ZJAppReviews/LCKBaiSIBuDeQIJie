//
//  LCKWordViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKWordViewController.h"
#import "AFNetWorking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LCKTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LCKTopicCell.h"

@interface LCKWordViewController ()
/** 帖子到数目 */
@property(nonatomic,strong) NSMutableArray *topics;
/** 页码 */
@property(nonatomic,assign) NSInteger page;
/** 加载下一页数据时需要的参数 */
@property(nonatomic,copy) NSString *maxtime;

/** 上一次请求的参数 */
@property(nonatomic,strong) NSDictionary *params;

@end

@implementation LCKWordViewController

-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
        
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    
    //请求加载数据
    [self loadDatas];
    
    //添加刷新控件
    [self setupRefresh];

}
-(void)setupTableView{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LCKTitleViewH + LCKTitleViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册nib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKTopicCell class]) bundle:nil] forCellReuseIdentifier:@"Topic"];
    
}

/**
 *  请求加载数据
 */
-(void)loadDatas{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //将数据写入到硬盘中
        //        [responseObject writeToFile:@"/Users/AppleDeveloper/Desktop/Word.plist" atomically:YES];
        
        NSArray *newTopics = [LCKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        //当重新加载时需要重置为第0页
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载段子数据错误"];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -- 刷新更新数据
/**
 *  添加刷新控件（集成的MJRefresh框架）
 */
-(void)setupRefresh{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.hidden = YES;
    //一进入就开始刷新
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];//自动改变透明度
    [self.tableView.mj_header beginRefreshing];

}
#pragma mark --- 数据处理
/**
 *  下拉刷新，加载更多最新的资源
 */
-(void)loadNewTopics{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [LCKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清除页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败！"];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多的帖子
 */
-(void)loadMoreTopics{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (self.params != params) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [LCKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败！"];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.page--;//当网络发送错误时需要将页码该回来
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.topics.count == 0;
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const CellID = @"Topic";
    LCKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[LCKTopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    
//    LCKTopic *topic = self.topics[indexPath.row];
//    cell.textLabel.text = topic.name;
//    cell.detailTextLabel.text = topic.text;
//    NSString *url = topic.profile_image;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark ---代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

@end
