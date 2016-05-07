//
//  LCKFriendTrendsViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKFriendTrendsViewController.h"
#import "LCKRecommendViewController.h"
#import "LCKLoginRegisterViewController.h"

@interface LCKFriendTrendsViewController ()

@end

@implementation LCKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LCKGlobalBackground;
}

-(void)friendClick{
    LCKRecommendViewController *recommendVC = [[LCKRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
    
}

- (IBAction)loginRegister {
    LCKLoginRegisterViewController *login = [[LCKLoginRegisterViewController alloc] init];
    //要想从底部弹出控制器，需要使用presentViewController
    [self presentViewController:login animated:YES completion:nil];
}

@end
