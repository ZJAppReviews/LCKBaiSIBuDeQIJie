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
#import "MJExtension.h"
#import "LCKRecommendCategoryCell.h"
#import "LCKRecommendCategory.h"

@interface LCKRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic , strong) NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation LCKRecommendViewController

static NSString *const LCKCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCKRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LCKCategoryId];
    
    
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
        
//        LCKLog(@"progress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        LCKLog(@"success = %@",responseObject);
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的是JSON数据(字典转模型：使用MJExtentiion第三方框架)
        self.categories = [LCKRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中category的第一个选目
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        LCKLog(@"failure = %@",error);
        
        //隐藏指示器，并显示错误
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}

#pragma mark -- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCKRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LCKCategoryId];
    cell.category = self.categories[indexPath.row];
    
    
    return cell;
}


@end
