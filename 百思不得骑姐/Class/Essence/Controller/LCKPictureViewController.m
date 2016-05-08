//
//  LCKPictureViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKPictureViewController.h"

@interface LCKPictureViewController ()

@end

@implementation LCKPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    
}
-(void)setupTableView{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LCKTitleViewH + LCKTitleViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    
    return cell;
}
@end
