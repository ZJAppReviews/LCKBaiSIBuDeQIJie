//
//  LCKCommentViewController.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCKTopic;

@interface LCKCommentViewController : UIViewController
/**
 *  帖子模型
 */
@property (nonatomic , strong) LCKTopic *topic;
@end
