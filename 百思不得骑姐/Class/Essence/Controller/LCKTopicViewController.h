//
//  LCKTopicViewController.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/9.
//  Copyright © 2016年 黄海良. All rights reserved.


//  最基本的帖子控制器

#import <UIKit/UIKit.h>

@interface LCKTopicViewController : UITableViewController
/**
 *  帖子类型
 */
@property (nonatomic , assign) LCKTopicType type;
@end
