//
//  AppDelegate.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "AppDelegate.h"
#import "LCKtabBarController.h"
#import "LCKPushGuideView.h"
#import "LCKTopWindow.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置窗口的根控制器
    UITabBarController *tarBarController = [[LCKtabBarController alloc] init];
    tarBarController.delegate = self;
    self.window.rootViewController = tarBarController;
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    //显示推送引导(在相关类中封装起来)
    [LCKPushGuideView showGuideView];
    
    
    return YES;
}

#pragma mark --- UITabBarControllerDelegate

//进行点击刷新（一般不会让自己来实现自己的代理）
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //使用通知来通知ViewController来更新视图（相距太远，通知最合适）
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[LCKSelectedControllerKey] = viewController;
    //对象要用（）
    userInfo[LCKSelectedControllerIndexKey] = @(tabBarController.selectedIndex);
    [[NSNotificationCenter defaultCenter] postNotificationName:LCKTabBarDidSelectNotification object:nil userInfo:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // 添加一个window, 点击这个window, 可以让屏幕上的scrollView滚到最顶部
//    [LCKTopWindow show];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
