//
//  LCKRecommendTags.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/5.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 {
	image_list : http://img.spriteapp.cn/ugc/2016/03/10/092924_69853.jpg,
	theme_id : 3096,
	theme_name : 百思红人,
	is_sub : 0,
	is_default : 0,
	sub_number : 95280
 },
 */
@interface LCKRecommendTags : NSObject
/** 图像 */
@property (nonatomic , copy) NSString *image_list;
/** 昵称 */
@property (nonatomic , copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic , assign) NSInteger sub_number;

@end
