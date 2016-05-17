//
//  LCKMeFooterView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/17.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKMeFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "LCKSquare.h"
#import "LCKSquareButton.h"
#import "LCKWebViewController.h"

@implementation LCKMeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"]=@"square";
        params[@"c"]=@"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [LCKSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            LCKLog(@"%@",responseObject);
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = LCKScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        LCKSquareButton *button = [LCKSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重新设置footerView(这几行决定了，底部的FooterView是否可以滚动)
    UITableView *tableView = (UITableView *)self.superview;
    //    tableView.tableFooterView = self;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame) + 44 );

    // 重绘
    [self setNeedsDisplay];
}



- (void)buttonClick:(LCKSquareButton *)button
{
    LCKLogFunc;
    
    if (![button.square.url hasPrefix:@"http"]) return;
    
    LCKWebViewController *web = [[LCKWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}

////由于UIView没有image，imageView属性，因此需要背景图片就需要重写此方法
//-(void)drawRect:(CGRect)rect{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}
@end
