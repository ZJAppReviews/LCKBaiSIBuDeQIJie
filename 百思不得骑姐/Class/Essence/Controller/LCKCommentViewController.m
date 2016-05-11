//
//  LCKCommentViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKCommentViewController.h"
#import "LCKTopicCell.h"
#import "LCKTopic.h"
#import "UIView+LCKExtention.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "LCKComent.h"
#import "MJExtension.h"
#import "LCKCommentHeaderView.h"
#import "LCKCommentCell.h"

static NSString * const LCKCommentId = @"comment";

@interface LCKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//工具条的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSpace;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) LCKComent *saved_top_cmt;
/** 管理者 */
@property (nonatomic , strong) AFHTTPSessionManager *manager;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;



@end

@implementation LCKCommentViewController

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
    //设置Cell的头部部分显示
    [self setupHeader];
    //点开自动刷新加载
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    LCKComent *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        // 最新评论
        NSArray *newComments = [LCKComent mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:newComments];
        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        } // 说明没有评论数据
        
        // 最热评论
        self.hotComments = [LCKComent mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 最新评论
        self.latestComments = [LCKComent mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 页码
        self.page = 1;
        
        // 刷新数据
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];

    }];
}
     
LCKTopicCell *cell;

-(void)setupHeader{
    //设置header(再创建一个层，封装好cellheader，而且扩张性也比较好)
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor redColor];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    // 添加cell
    LCKTopicCell *cell = [LCKTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.size = CGSizeMake(LCKScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = self.topic.cellHeight + LCKTopicCellMargin;
    
    // 设置header
    self.tableView.tableHeaderView = header;
    
//    cell = [LCKTopicCell cell];
//    //这个cell的高度要独立来设置，因为这是自己来掌握的，并不能使用heightFor...代理方法来设置
//    cell.topic = self.topic;
//    cell.height = self.topic.cellHeight;
//    self.tableView.tableHeaderView = cell;
//    //headerView是特殊的view，他的frame会随着拖动而改变的
    
    
}

//-(void)setupBasic{
//    
//    self.title = @"最新评论";

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChageFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    //设置tableView的全局色
//    self.tableView.backgroundColor = LCKGlobalBackground;
//}
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // cell的高度设置(ios8后cell可以自动来计算高度)
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    self.tableView.backgroundColor = LCKGlobalBackground;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKCommentCell class]) bundle:nil] forCellReuseIdentifier:LCKCommentId];
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LCKTopicCellMargin, 0);
}

-(void)keyboardWillChangeFrame:(NSNotification *)note{
    
    //得到键盘的值
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部的约束
    self.buttonSpace.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    //动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    // 取消所有任务
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark ---- 代理方法

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (LCKComent *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    // 隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 先从缓存池中找header(header的循环利用)
    LCKCommentHeaderView *header = [LCKCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKCommentId];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;

}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    if (menu.isMenuVisible) {
//        [menu setMenuVisible:NO animated:YES];
//    } else {
//        // 被点击的cell
//        LCKCommentCell *cell = (LCKCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
//        // 出现一个第一响应者
//        [cell becomeFirstResponder];
//        
//        // 显示MenuController
//        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
//        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
//        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
//        menu.menuItems = @[ding, replay, report];
//        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
//        [menu setTargetRect:rect inView:cell];
//        [menu setMenuVisible:YES animated:YES];
//    }
//}

//#pragma mark - MenuItem处理
//- (void)ding:(UIMenuController *)menu
//{
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
//}
//
//- (void)replay:(UIMenuController *)menu
//{
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
//}
//
//- (void)report:(UIMenuController *)menu
//{
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
//}
@end

