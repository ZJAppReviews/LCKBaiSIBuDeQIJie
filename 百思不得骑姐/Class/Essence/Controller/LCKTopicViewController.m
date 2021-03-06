//
//  LCKTopicViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicViewController.h"
#import "AFNetWorking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LCKTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LCKTopicCell.h"
#import "LCKNewViewController.h"

#import "LCKCommentViewController.h"

@interface LCKTopicViewController ()
/** 帖子到数目 */
@property(nonatomic,strong) NSMutableArray *topics;
/** 页码 */
@property(nonatomic,assign) NSInteger page;
/** 加载下一页数据时需要的参数 */
@property(nonatomic,copy) NSString *maxtime;

/** 上一次请求的参数 */
@property(nonatomic,strong) NSDictionary *params;
/** 上一次选中的索引 */
@property(nonatomic,assign) NSInteger lastSelectedIndex;


@end

@implementation LCKTopicViewController


-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
        
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}


static NSString * const LCKTopicCellId = @"Topic";

- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LCKTitlesViewH + LCKTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKTopicCell class]) bundle:nil] forCellReuseIdentifier:LCKTopicCellId];
    
    //监听tarbar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick:) name:LCKTabBarDidSelectNotification object:nil];
}

-(void)tabBarClick:(NSString *)selectedIndex{
    //如果选中的不是当前的导航控制器，直接返回
    //如果不是两次连续点击，直接返回
    if(self.lastSelectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController == self.navigationController && self.view.isShowingOnKeyWindow){
        [self.tableView.mj_header beginRefreshing];
    }
    //记录此次的选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

/**
 *  请求加载数据
 */
//-(void)loadDatas{
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"a"] = @"list";
//    params[@"c"] = @"data";
//    params[@"type"] = @(self.type);
//    
//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        //将数据写入到硬盘中
//        //        [responseObject writeToFile:@"/Users/AppleDeveloper/Desktop/Word.plist" atomically:YES];
//        
//        NSArray *newTopics = [LCKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        [self.topics addObjectsFromArray:newTopics];
//        
//        [self.tableView reloadData];
//        
//        [self.tableView.mj_footer endRefreshing];
//        
//        //当重新加载时需要重置为第0页
//        self.page = 0;
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD showErrorWithStatus:@"加载段子数据错误"];
//        [self.tableView.mj_footer endRefreshing];
//    }];
//}


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
#pragma mark -- a参数
//新帖和精华的参数只是相差一个a参数
-(NSString *)a{
    return [self.parentViewController isKindOfClass:[LCKNewViewController class]] ? @"newList" : @"list";
}

#pragma mark --- 数据处理
/**
 *  下拉刷新，加载更多最新的资源
 */
-(void)loadNewTopics{
    // 结束上啦
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
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

// 先下拉刷新, 再上拉刷新第5页数据

// 下拉刷新成功回来: 只有一页数据, page == 0
// 上啦刷新成功回来: 最前面那页 + 第5页数据

/**
 *  加载更多的帖子
 */
-(void)loadMoreTopics{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;

    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [LCKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败！"];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LCKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKTopicCellId];\
//    if (cell == nil) {
//        cell = [[LCKTopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:LCKTopicCellId];
//    }
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark ---代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取出帖子模型(获得文字模型从而得到高度)
   LCKTopic *topic = self.topics[indexPath.row];

    //返回这个模型对应的高度
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LCKCommentViewController *cmtVC = [[LCKCommentViewController alloc] init];
    //传模型给控制器，并且点击哪个传送哪个
    cmtVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cmtVC animated:YES];
}


@end
