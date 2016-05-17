//
//  LCKPublishViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/10.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKPublishViewController.h"
#import "LCKVerticalButton.h"
#import "LCKPublishWordViewController.h"
#import "LCKNavigationController.h"


@interface LCKPublishViewController ()

@end

@implementation LCKPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //控制器View不能点击
//    self.view.userInteractionEnabled = NO;
    
    //添加标语
    UIImageView *slogin =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogin.y = LCKScreenH * 0.2;
    slogin.centerX = LCKScreenW * 0.5;
    [self.view addSubview:slogin];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LCKScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (LCKScreenW - maxCols * buttonW - 2 * buttonStartX ) / (maxCols - 1);
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    for (int i = 0 ; i < images.count; i++) {
        LCKVerticalButton *button = [[LCKVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        
        //设置frame
        button.width = buttonW;
        button.height = buttonH;
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        
        [self.view addSubview:button];
        // 按钮动画（推荐是用facebook开发的pop框架）
   
       
    }
 
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 2) {
//        LCKLogFunc;
        LCKPublishWordViewController *publishWord = [[LCKPublishWordViewController alloc] init];
        LCKNavigationController *nav = [[LCKNavigationController alloc] initWithRootViewController:publishWord];
        // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
//        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//        [root presentViewController:nav animated:YES completion:nil];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (IBAction)cancelVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

@end
