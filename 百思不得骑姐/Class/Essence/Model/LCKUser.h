//
//  LCKUser.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LCKUser : NSObject
/** 用户名 */
@property (nonatomic , copy) NSString *username;

/** 性别 */
@property (nonatomic , copy) NSString *sex;

/** 头像 */
@property (nonatomic , copy) NSString *profile_image;
@end
