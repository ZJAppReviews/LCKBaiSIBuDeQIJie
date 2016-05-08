//
//  LCKPushGuideView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKPushGuideView.h"

@implementation LCKPushGuideView

+(instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+(void)showGuideView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //版本号(或者是软件新特性的都可以在这里设置)
    NSString *keyVersion = @"CFBundleVersion";
    
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;//plist中的
    
    NSString *currentVersion = dict[keyVersion];
    
    //沙盒中保存的版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:keyVersion];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        
        LCKPushGuideView *guideView = [LCKPushGuideView guideView];//通过在类中定义一个类方法，屏蔽xib的创建过程
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        //存储最新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:keyVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];//马上同步存储版本号
    }
}

//透明按钮（技巧）
- (IBAction)dissmissPushGuide {
    [self removeFromSuperview];
}

@end
