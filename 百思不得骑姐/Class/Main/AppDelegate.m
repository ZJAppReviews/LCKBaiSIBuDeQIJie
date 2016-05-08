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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置窗口的根控制器
    self.window.rootViewController = [[LCKtabBarController alloc] init];
    //显示窗口
    [self.window makeKeyAndVisible];
    
    //版本号(或者是软件新特性的都可以在这里设置)
    
    NSString *keyVersion = @"CFBundleVersion";
    
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;//plist中的

    NSString *currentVersion = dict[keyVersion];
    
    //沙盒中保存的版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:keyVersion];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        
        LCKPushGuideView *guideView = [LCKPushGuideView guideView];//通过在类中定义一个类方法，屏蔽xib的创建过程
        guideView.frame = self.window.bounds;
        
        [self.window addSubview:guideView];
        
        //存储最新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:keyVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];//马上同步存储版本号
    }
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
