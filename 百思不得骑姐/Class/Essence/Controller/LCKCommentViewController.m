//
//  LCKCommentViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKCommentViewController.h"

@interface LCKCommentViewController ()

@end

@implementation LCKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:@selector(backToTop)];
}

-(void)backToTop{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
