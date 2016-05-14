//
//  LCKTopWindow.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopWindow.h"

@implementation LCKTopWindow


//变量要保证它的存在，需要声明为strong的成员变量，但是因为类方法的变量是不能声明在property里面的变量。因此使用静态常量来处理

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LCKScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    
    //添加手势识别
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
    
}

+ (void)hide
{
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end
