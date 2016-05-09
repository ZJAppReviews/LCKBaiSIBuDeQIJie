//
//  LCKTopic.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopic.h"
#import "NSDate+XMGExtension.h"
#import "MJExtension.h"

@implementation LCKTopic

//当属性声明为readonly这只会生成get方法，但如果自己实现了get方法那么就不会生成带下划线的成员变量
{
    CGFloat _cellHeight;
}

//重写:自定义时间
-(NSString *)create_time{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight{
    
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LCKTopicCellMargin, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        _cellHeight = LCKTopicCellTextY + textH + LCKTopicCellBottomBarH + 2 * LCKTopicCellMargin + self.height + 40;//40是为了避开文章中的特殊符号，而导致cell出现异样
    }
    
    return _cellHeight;
}


//字典中和服务器不同的字典进行替换
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             };
}

@end
