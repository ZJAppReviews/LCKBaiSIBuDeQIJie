//
//  LCKNavigationController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKNavigationController.h"

@implementation LCKNavigationController

/**
 *当第一次使用这个类时会调用一次
 */

+(void)initialize{
    //当导航栏用在LCKNavigationController中appearance才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class],nil];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
//    LCKLogFunc;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //设置导航控制器的背景颜色
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

}

//为了将导航栏控制器的样式进行统一，需要重写pushViewController将其进行拦截，并定制样式
//由于在调用此方法的时候将会将4个控制器都推入堆栈中，此是拦截并自定义样式的时机最合适

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    
    //通过判断是否是最前面的导航层次来对导航栏进行设置
    if (self.childViewControllers.count > 0) {//如果push进来的不适第一个控制器，这不要
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
//        button.backgroundColor = [UIColor redColor];//通过颜色来调节按钮的大小（推荐使用）
//        [button sizeToFit];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];

     [super pushViewController:viewController animated:animated];//这句放在后面，可以让viewController可以覆盖上面设置的leftBarBarButtonItem。是的viewController有更大的权限
    
}

-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
