//
//  LCKTabBar.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTabBar.h"
@interface LCKTabBar()
@property(nonatomic,weak) UIButton *publishButton;
@end

@implementation LCKTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //自定义控件初始化，必须实现这个方法
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    //通过封装frame来进行设置的
    self.publishButton.width = self.publishButton.currentImage.size.width;
    self.publishButton.height = self.publishButton.currentImage.size.height;
    
    
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其它按钮的frame
    CGFloat buttonW = self.frame.size.width / 5 ;
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    NSUInteger index = 0 ;
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])  continue; //背景和＋位置不变外，其它都可以发生改变
        
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1): index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index ++;//增加索引
    }
}

@end
