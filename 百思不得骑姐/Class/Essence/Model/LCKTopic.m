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
#import "LCKComent.h"
#import "LCKUser.h"

@implementation LCKTopic

//当属性声明为readonly这只会生成get方法，但如果自己实现了get方法那么就不会生成带下划线的成员变量
{
    CGFloat _cellHeight;
    CGRect _pictureF;
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
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        //文字部分的高度
        _cellHeight = LCKTopicCellTextY + textH + LCKTopicCellMargin ;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == LCKTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= LCKTopicCellPictureMaxH) { // 图片高度过长
                pictureH = LCKTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = LCKTopicCellMargin;
            CGFloat pictureY = LCKTopicCellTextY + textH + LCKTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + LCKTopicCellMargin;
            
        }else if (self.type == LCKTopicTypeVoice){
             CGFloat voiceX = LCKTopicCellMargin;
             CGFloat voiceY = LCKTopicCellTextY + textH + LCKTopicCellMargin;
             CGFloat voiceW = maxSize.width;
             CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            //Cell的高度
            _cellHeight += voiceH + LCKTopicCellMargin;
        }else if (self.type == LCKTopicTypeVideo){
            CGFloat videoX = LCKTopicCellMargin;
            CGFloat videoY = LCKTopicCellTextY + textH + LCKTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            //Cell的高度
            _cellHeight += videoH + LCKTopicCellMargin;

        }
        
        // 如果有最热评论
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LCKTopicCellTopCmtTitleH + contentH + LCKTopicCellMargin;
        }
        
        // 底部工具条的高度
        _cellHeight += LCKTopicCellBottomBarH + LCKTopicCellMargin + 20;

    }
    
    return _cellHeight;
}
//字典中和服务器不同的字典进行替换
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"// 这条代码对于后面的最热评论至关重要
             };
}
//上面的@"top_cmt" : @"top_cmt[0]"可以替代下面的方法
////这个方法是将返回的字典转换为我们定义的模型
//+(NSDictionary *)mj_objectClassInArray{
//
//    return @{@"top_cmt" : [LCKComent class]};
//    
//}


@end
