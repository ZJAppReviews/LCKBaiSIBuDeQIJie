//
//  LCKtabBarController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKtabBarController.h"
#import "LCKEssenceViewController.h"
#import "LCKNewViewController.h"
#import "LCKFriendTrendsViewController.h"
#import "LCKMeViewController.h"
#import "LCKTabBar.h"
#import "LCKNavigationController.h"

@interface LCKtabBarController ()

@end

@implementation LCKtabBarController

+(void)initialize{
    
    //文字的属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAtrrs = [NSMutableDictionary dictionary];
    selectAtrrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtrrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //凡事方法后面带有UI_APPEARANCE_SELECTOR的都可以通过设置其appearance来统一控制所有的外观，如下所示
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAtrrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器(自定义的控件)
    [self initChildVC:[[LCKEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    [self initChildVC:[[LCKNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
//    [self initChildVC:[[UIViewController alloc] init] title:@"发布" image:@"tabBar_publish_icon" selectImage:@"tabBar_publish_click_icon"];
    
    [self initChildVC:[[LCKFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    [self initChildVC:[[LCKMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];

    
    
    //在布局Tabbar的控件时因为拿不到字控件的对象，因此可以通过更换自定义的tabBar来实现，并通过layoutSubViews方法来进行布局  (由于tabBar时read－only的，要修改则可使用KVC来进行修改［KVC能直接访问成员变量的］)
//    self.tabBar = [[LCKTabBar alloc] init];
    [self setValue:[[LCKTabBar alloc] init] forKey:@"tabBar"];
    //设置tabbar的背景颜色
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    


}



//初始化子控制器
-(void)initChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
//    UIViewController *vc = [[class alloc] init];//这样对未来创建的控制器的扩展性不哈奥，因为有些控制器并不是通过init来创建的。
    
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    //    //防止图片被渲染,另外一种方法就时通过图片在控制面板上的属性来设置
    //    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0]; //这行代码将会提前创建出4个控制器，这是不合理的。因为View创建将会懒加载4个控制器。
    
//    [self addChildViewController:vc];//由于导航控制器的不同，因此我们需要先加载上导航控制器后，才将其控制器加入上去
    
    LCKNavigationController *nav = [[LCKNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}




@end
