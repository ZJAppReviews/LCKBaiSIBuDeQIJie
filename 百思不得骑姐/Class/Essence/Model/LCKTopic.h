//
//  LCKTopic.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCKTopic : NSObject
/** 头像 */
@property (nonatomic , copy) NSString *profile_image;
/** 文本段落 */
@property (nonatomic , copy) NSString *text;
/** 名字 */
@property (nonatomic , copy) NSString *name;
/** 创建时间 */
@property (nonatomic , copy) NSString *create_time;
/** 顶的数量 */
@property (nonatomic , assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic , assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic , assign) NSInteger repost;
/** 帖子的被评论数量 */
@property (nonatomic , assign) NSInteger comment;

@end
