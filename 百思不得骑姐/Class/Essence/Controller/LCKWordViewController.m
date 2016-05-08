//
//  LCKWordViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKWordViewController.h"
#import "AFNetWorking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface LCKWordViewController ()
/**
 *  帖子到数目
 */
@property(nonatomic,strong) NSArray *topics;
@end

@implementation LCKWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将数据写入到硬盘中
//        [responseObject writeToFile:@"/Users/AppleDeveloper/Desktop/Word.plist" atomically:YES];
        
        self.topics = responseObject[@"list"];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载段子数据错误"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"name"];
    cell.detailTextLabel.text = topic[@"text"];
    NSString *url = topic[@"profile_image"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
@end
