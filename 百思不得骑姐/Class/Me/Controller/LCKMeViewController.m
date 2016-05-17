//
//  LCKMeViewController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKMeViewController.h"
#import "LCKMeCell.h"
#import "LCKMeFooterView.h"

@interface LCKMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LCKMeViewController

static NSString * const CellID = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" hightImage:@"nav_coin_icon_click" target:self action:@selector(momenyClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LCKGlobalBackground;
    
    //注册
    [self.tableView registerClass:[LCKMeCell class] forCellReuseIdentifier:CellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   //调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LCKTopicCellMargin;
    //使得整cell往上挪动，可避免重写setFrame方法
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    
    //加载foorerView
    self.tableView.tableFooterView = [[LCKMeFooterView alloc] init];
    
}



-(void)settingClick{
    LCKLogFunc;
}

-(void)moonClick{
    LCKLogFunc;
}

-(void)momenyClick{
    LCKLogFunc;
}

#pragma mark -- UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCKMeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[LCKMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录／注册";
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    [self.tableView.tableFooterView setNeedsDisplay];
}

@end
