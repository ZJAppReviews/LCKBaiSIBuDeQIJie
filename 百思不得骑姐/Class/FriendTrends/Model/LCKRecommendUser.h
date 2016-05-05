//
//  LCKRecommendUser.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/5.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCKRecommendUser : NSObject
/**
 	introduction : ,
	uid : 17717764,
	header : http://wimg.spriteapp.cn/profile/large/2016/03/08/56de4952777e1_mini.jpg,
	gender : 1,
	is_vip : 0,
	fans_count : 3867,
	tiezi_count : 9,
	is_follow : 0,
	screen_name : i烘焙
 */
/** 头像 */
@property (nonatomic , copy) NSString *header;
/** 粉丝数目 */
@property (nonatomic , assign) NSInteger fans_count;
/** 呢称 */
@property (nonatomic , copy) NSString *screen_name;
@end
