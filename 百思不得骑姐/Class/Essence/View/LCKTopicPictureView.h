//
//  LCKTopicPictureView.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/9.
//  Copyright © 2016年 黄海良. All rights reserved.
//  图片帖子中间的图片

#import <UIKit/UIKit.h>
@class LCKTopic;

@interface LCKTopicPictureView : UIView
+(instancetype)pictureView;

/**
 *  帖子数据
 */
@property (nonatomic , strong) LCKTopic *topic;

@end
