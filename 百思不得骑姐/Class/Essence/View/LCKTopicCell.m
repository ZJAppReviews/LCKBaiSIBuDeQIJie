//
//  LCKTopicCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicCell.h"

@implementation LCKTopicCell

-(void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
}

-(void)setFrame:(CGRect)frame{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= margin * 2;
    frame.size.height -=margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
