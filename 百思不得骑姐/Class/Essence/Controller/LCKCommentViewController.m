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

@interface LCKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//工具条的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSpace;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) LCKComent *saved_top_cmt;

@end

@implementation LCKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
    //设置Cell的头部部分显示
    [self setupHeader];
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

-(void)setupBasic{
    
    self.title = @"最新评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:@selector(backToTop)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChageFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //设置tableView的全局色
    self.tableView.backgroundColor = LCKGlobalBackground;
}

-(void)backToTop{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardWillChageFrame:(NSNotification *)note{
    
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ---- 代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    return cell;
}
@end
