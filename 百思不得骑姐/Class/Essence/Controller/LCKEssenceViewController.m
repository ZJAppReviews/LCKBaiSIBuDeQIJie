//
//  LCKEssenceViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKEssenceViewController.h"
#import "LCKTestViewController.h"

@interface LCKEssenceViewController ()

@end

@implementation LCKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LCKGlobalBackground;
    
}

-(void)tagClick{
//    LCKLog(@"LCKEssenceViewController");
    LCKLogFunc;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LCKTestViewController *vc = [[LCKTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
