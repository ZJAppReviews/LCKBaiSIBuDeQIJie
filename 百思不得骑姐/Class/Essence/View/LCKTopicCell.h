//
//  LCKTopicCell.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCKTopic;

@interface LCKTopicCell : UITableViewCell

+(instancetype)cell;
/**
 *  帖子数据
 */
@property (nonatomic , strong) LCKTopic *topic;
@end
