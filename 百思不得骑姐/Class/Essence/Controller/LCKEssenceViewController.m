//
//  LCKEssenceViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKEssenceViewController.h"
#import "LCKRecommendTagViewController.h"

@interface LCKEssenceViewController ()
/** 底部标签栏的指示器 */
@property(nonatomic, weak) UIView *indicatorView;

/** 当前选择的按钮 */
@property(nonatomic, weak) UIButton *selectedButton;

/** 所有分类的标签 */
@property(nonatomic, weak) UIView *categoryView;

@end

@implementation LCKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavigation];
    
    //设置顶部精华部分分类
    [self setupCategoryEssence];
    
    //底部的scrollView
    [self setupContentScrollView];

}

/** 底部的scrollView */
-(void)setupContentScrollView{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
//    contentView.backgroundColor = [UIColor redColor];
    
//    //这样做会缺失穿透的效果
//    contentView.width = self.view.width;
//    contentView.y = 64 + 35;
//    contentView.height = self.view.height - self.tabBarController.tabBar.height - contentView.y;
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.categoryView.frame);

    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);

    [self.view insertSubview:contentView atIndex:0];
}

/** 设置顶部精华部分分类 */
-(void)setupCategoryEssence{

    //标签栏分类的整体
    UIView *categoryView = [[UIView alloc] init];
    categoryView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    categoryView.y = 64;
    categoryView.x = 0;
    categoryView.width = self.view.width;
    categoryView.height = 35;
    
    [self.view addSubview:categoryView];
    
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = categoryView.height - indicatorView.height;
    indicatorView.x = categoryView.x;
    [categoryView addSubview:indicatorView];
    
    self.indicatorView = indicatorView;
    
    
    //在分类中添加按钮
    NSInteger categoryCount = 5;
    NSArray *array = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    for (NSInteger i = 0; i < categoryCount; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.height = categoryView.height;
        btn.width = categoryView.width / categoryCount;
        btn.x = i *btn.width;
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
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

}

-(void)categoryClick:(UIButton *)button{
    //修改按钮的状态
//    self.selectedButton.selected = NO;
//    button.selected = YES;
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.indicatorView.centerX = button.centerX;
        self.indicatorView.width = button.titleLabel.width;
    }];
    
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

@end
