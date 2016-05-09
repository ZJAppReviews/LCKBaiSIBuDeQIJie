//
//  LCKEssenceViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKEssenceViewController.h"
#import "LCKRecommendTagViewController.h"
#import "LCKTopicViewController.h"

@interface LCKEssenceViewController ()<UIScrollViewDelegate>
/** 底部标签栏的指示器 */
@property(nonatomic, weak) UIView *indicatorView;

/** 当前选择的按钮 */
@property(nonatomic, weak) UIButton *selectedButton;

/** 所有分类的标签 */
@property(nonatomic, weak) UIView *categoryView;
/** 底部的所有内容 */
@property(nonatomic, weak) UIScrollView *contentView;

@end

@implementation LCKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavigation];
    
    //初始化子控件
    [self setupChildViewController];
    
    //设置顶部精华部分分类
    [self setupCategoryEssence];
    
    //底部的scrollView
    [self setupContentScrollView];
    
}

-(void)setupChildViewController{
    
    LCKTopicViewController *allVC = [[LCKTopicViewController alloc] init];
    allVC.title = @"全部";
    allVC.type =LCKTopicTypeAll;
    [self addChildViewController:allVC];
    
    LCKTopicViewController *pictureVC = [[LCKTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type =LCKTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    LCKTopicViewController *wordVC = [[LCKTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type =LCKTopicTypeWord;
    [self addChildViewController:wordVC];
    
    LCKTopicViewController *soundVC = [[LCKTopicViewController alloc] init];
    soundVC.title = @"声音";
    soundVC.type =LCKTopicTypeVoice;
    [self addChildViewController:soundVC];
    
    LCKTopicViewController *videoVC = [[LCKTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type =LCKTopicTypeVideo;
    [self addChildViewController:videoVC];

}

/** 设置顶部精华部分分类 */
-(void)setupCategoryEssence{
    
    //标签栏分类的整体
    UIView *categoryView = [[UIView alloc] init];
    categoryView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    categoryView.y = LCKTitleViewY;
    categoryView.width = self.view.width;
    categoryView.height = LCKTitleViewH;
    [self.view addSubview:categoryView];
    self.categoryView = categoryView;
    
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = categoryView.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    
    
    //在分类中添加按钮
//    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];//去除这段的目的时为了不让控制器和控制器的名字之间断离
    CGFloat width = categoryView.width / self.childViewControllers.count;
    CGFloat height = categoryView.height;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.height = height;
        btn.width = width;
        btn.x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //        //强制设置大小（因为在这里还没创建按钮的位置）,也叫强制布局
        //        [btn layoutIfNeeded];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(categoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [categoryView addSubview:btn];
        
        //默认选中第一个
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            //当不适用强制布局的话，可是让内部的label根据文字内容来计算尺寸
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
    }
    
    [categoryView addSubview:indicatorView];
    
}

-(void)categoryClick:(UIButton *)button{
    //修改按钮的状态
    //    self.selectedButton.selected = NO;
    //    button.selected = YES;
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    //切换子控制器
    
}

/** 底部的scrollView */
-(void)setupContentScrollView{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
     [self.view insertSubview:contentView atIndex:0];
    //设置scrollView的contentSize
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //默认添加一个控制器View
    [self scrollViewDidEndScrollingAnimation:contentView];
}


-(void)setupNavigation{
    //设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LCKGlobalBackground;
}

-(void)tagClick{
    
    LCKRecommendTagViewController *recommendTag = [[LCKRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:recommendTag animated:YES];
    
}


#pragma mark --- <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //拿出当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出当前的控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)

    [scrollView addSubview:vc.view];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self categoryClick:self.categoryView.subviews[index]];
}
@end
