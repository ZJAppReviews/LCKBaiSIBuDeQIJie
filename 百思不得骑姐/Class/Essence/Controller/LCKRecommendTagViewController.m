//
//  LCKRecommendTagViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/5.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendTagViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LCKRecommendTags.h"
#import "MJExtension.h"
#import "LCKRecommendTagViewCell.h"
#import "LCKRecommendTags.h"

@interface LCKRecommendTagViewController ()
/** 标签数据 */
@property (nonatomic,strong) NSArray *tags;
@end

static NSString * const LCKTagsId = @"tagCell";

@implementation LCKRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKRecommendTagViewCell class]) bundle:nil] forCellReuseIdentifier:LCKTagsId];
    
    self.title = @"推荐订阅";
//    self.tableView.height = 100 ;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LCKGlobalBackground;
    
    //遮盖蒙板
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        LCKLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LCKLog(@"responseObject = %@",responseObject);
        //数组转模型
       self.tags = [LCKRecommendTags mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LCKLog(@"error = %@",error);
        [SVProgressHUD showErrorWithStatus:@"请求数据失败！"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCKRecommendTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKTagsId];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

@end
