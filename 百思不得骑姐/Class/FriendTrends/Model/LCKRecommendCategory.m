//
//  LCKRecommendCategory.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendCategory.h"
#import "MJExtension.h"

@implementation LCKRecommendCategory
/**
 *  懒加载
 *
 *  @return return value description
 */
-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" :@"id"
             };
}

@end
