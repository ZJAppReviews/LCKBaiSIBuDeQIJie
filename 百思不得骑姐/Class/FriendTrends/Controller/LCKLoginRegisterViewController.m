//
//  LCKLoginRegisterViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/7.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKLoginRegisterViewController.h"

@interface LCKLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**
 *  登录狂距离控制器view左边的变局
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation LCKLoginRegisterViewController

- (IBAction)dissLoginView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister {
    //退出键盘
    [self.view endEditing:YES];
    
    //设置将登录模块进行整体的布局等移动
    if (self.loginViewLeftMargin.constant == 0) {//显示注册页面
        
        self.loginViewLeftMargin.constant = -self.view.width;
        [self.registerButton setTitle:@"帐号登录" forState:UIControlStateNormal];
        
    }else{
        self.loginViewLeftMargin.constant = 0;
        [self.registerButton setTitle:@"注册帐号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置登录按钮的圆角(方法一)
//    self.loginButton.layer.cornerRadius = 5;
//    self.loginButton.layer.masksToBounds = YES;
    //方法二：在xib的面板中使用kvc来设置
    
    
    
//    //设置文字样式（方法一）
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    //NSAttributedString：带有属性的富文本
//    NSAttributedString *placehoder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placehoder;
    
    
//    //设置文字样式（方法二）
//    NSMutableAttributedString *placehoder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placehoder setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 3)];
//    
//    self.phoneField.attributedPlaceholder = placehoder;
    
    //设置文字样式（方法三：自定义TextField并是xib中的textfield拥有这个自定义的类）
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  这个方法是控制状态栏的
 *
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
