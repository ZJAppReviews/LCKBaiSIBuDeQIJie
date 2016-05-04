//
//  LCKFriendTrendsViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKFriendTrendsViewController.h"
#import "LCKRecommendViewController.h"

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


@end
