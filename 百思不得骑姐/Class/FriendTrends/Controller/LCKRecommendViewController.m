//
//  LCKRecommendViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LCKRecommendCategoryCell.h"
#import "LCKRecommendCategory.h"
#import "LCKRecommendUserCell.h"
#import "LCKRecommendUser.h"

@interface LCKRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic , strong) NSArray *categories;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@end

@implementation LCKRecommendViewController

static NSString *const LCKCategoryId = @"category";
static NSString *const LCKUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LCKCategoryId];
    
    //注册user.xib
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LCKUserId];
    
    //设置inset(在导航栏控制器中，只有一个View是默认有inset为64，其它都不会有)
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    self.view.backgroundColor = LCKGlobalBackground;
    
    //添加刷新控件（集成的MJRefresh框架）
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    /**
     SVProgressHUDMaskTypeNone = 1,  // allow user interactions while HUD is displayed
     SVProgressHUDMaskTypeClear,     // don't allow user interactions
     SVProgressHUDMaskTypeBlack,     // don't allow user interactions and dim the UI in the back of the HUD
     SVProgressHUDMaskTypeGradient   // don't allow user interactions and dim the UI with a a-la-alert-view background gradient
     */
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        LCKLog(@"progress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        LCKLog(@"success = %@",responseObject);
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的是JSON数据(字典转模型：使用MJExtentiion第三方框架)
        self.categories = [LCKRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中category的第一个选目
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        LCKLog(@"failure = %@",error);
        
        //隐藏指示器，并显示错误
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}


#pragma mark -- 刷新更新数据
/**
 *  添加刷新控件（集成的MJRefresh框架）
 */
-(void)setupRefresh{
    //下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewUsers)];
    
    self.userTableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

    //当数据出来后，刷新按钮才出来
    self.userTableView.mj_footer.hidden = YES;
}
/**
 *  下拉刷新，加载更多最新的资源
 */
-(void)loadMoreNewUsers{
    
    LCKRecommendCategory *rc = LCKSelectedCategory;
    
    
    //设置当前页码为1（首次加载数据）
    rc.currentPage = 1;
    
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        self.users = [LCKRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];//这个数组只能保存这次的数据并不能保存上次的数据，也就时说能够解决问题点2.要想保存所有类别的数据，可以再定义一个数组模型来存储每个类别对应的数据。
        //字典转模型数组
        NSArray *users = [LCKRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        [self.userTableView reloadData];
        
       //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败！"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        //判断底部控件
        [self checkFooterState];
    }];
}

/**
 *  刷新加载更多的数据
 */
-(void)loadMoreUsers{
    LCKRecommendCategory *category = LCKSelectedCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([LCKSelectedCategory id]);
    params[@"page"] = @(++category.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *users = [LCKRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的数组中
        [category.users addObjectsFromArray:users];
        
        [self.userTableView reloadData];
        
        //提示footer加载完毕
        if (category.users.count == category.total) {//全部数据结束加载
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            //数据更新完毕，结束刷新
            [self.userTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载详细信息失败！"];
    }];

}

/**
 *  检测底部控件的状态
 */
-(void)checkFooterState{
    
    LCKRecommendCategory *category = LCKSelectedCategory;
    
    //每次刷新右侧数据时，都监测footeer的显示和隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0 );
    
    //底部控件结束刷新
    if (category.users.count == category.total) {//全部数据结束加载
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        //数据更新完毕，结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark -- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        //监测footer状态
        [self checkFooterState];
        
        LCKRecommendCategory *category = LCKSelectedCategory;
     
        return [category users].count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        LCKRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{//右边的用户表格数据(这里处理用户数据，但是需要在请求中处理用户请求返还来的数据)
        LCKRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKUserId];
        
        //左边被选中的类别模型
        LCKRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        cell.user = c.users[indexPath.row];
        return cell;
    }
 
}

#pragma mark -- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LCKRecommendCategory *c = self.categories[indexPath.row];
    //点击其它左侧按钮时马上停止刷新上一页面的数据
    [self.userTableView.mj_footer endRefreshing];
//    LCKLog(@"C = %@",c.name);
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else{
        //马上刷新表格，目的：马上显示category中的用户数据，不让客户看到上一个category的残留数据()
        [self.userTableView reloadData];
        
        //进入下行啦刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
     
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //由于cell中的高度为55，而磨人的tableViewCell默认的高度为44，因此会到导致出现变形
//    
//}

/**
 *  问题点：
 1. 目前只能显示一页数据
 2. 重复请求
 3. 网络慢，所带来的细节问题
 
 解决点：
 1. 发送请求加上页码
 2.
 3. 点击时，若网络慢，可以加载上一次请求点数据
 */
@end
