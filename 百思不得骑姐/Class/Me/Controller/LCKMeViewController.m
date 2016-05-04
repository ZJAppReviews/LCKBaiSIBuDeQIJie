//
//  LCKMeViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKMeViewController.h"

@interface LCKMeViewController ()

@end

@implementation LCKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" hightImage:@"nav_coin_icon_click" target:self action:@selector(momenyClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LCKGlobalBackground;
}

-(void)settingClick{
    LCKLogFunc;
}

-(void)moonClick{
    LCKLogFunc;
}

-(void)momenyClick{
    LCKLogFunc;
}

@end
