//
//  LCKCommentViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKCommentViewController.h"

@interface LCKCommentViewController ()<UITableViewDelegate>
//工具条的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonSpace;
@end

@implementation LCKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    [self setupBasic];
}
-(void)setupBasic{
    
    self.title = @"最新评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:@selector(backToTop)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChageFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)backToTop{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyboardWillChageFrame:(NSNotification *)note{
    
    //得到键盘的值
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部的约束
    self.buttonSpace.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    //动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ---- 代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
