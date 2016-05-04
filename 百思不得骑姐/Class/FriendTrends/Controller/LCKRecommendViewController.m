//
//  LCKRecommendViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface LCKRecommendViewController ()

@end

@implementation LCKRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    
    self.view.backgroundColor = LCKGlobalBackground;
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    /**
     SVProgressHUDMaskTypeNone = 1,  // allow user interactions while HUD is displayed
     SVProgressHUDMaskTypeClear,     // don't allow user interactions
     SVProgressHUDMaskTypeBlack,     // don't allow user interactions and dim the UI in the back of the HUD
     SVProgressHUDMaskTypeGradient   // don't allow user interactions and dim the UI with a a-la-alert-view background gradient
     */
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        LCKLog(@"progress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LCKLog(@"success = %@",responseObject);
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LCKLog(@"failure = %@",error);
        
        //隐藏指示器，并显示错误
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}


@end
