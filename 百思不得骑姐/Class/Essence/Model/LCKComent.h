//
//  LCKComent.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCKUser;

@interface LCKComent : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LCKUser *user;

@end
