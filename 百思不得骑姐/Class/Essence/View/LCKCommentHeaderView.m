//
//  LCKCommentHeaderView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKCommentHeaderView.h"


@interface LCKCommentHeaderView()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end


@implementation LCKCommentHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"header";
    LCKCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[LCKCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LCKGlobalBackground;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LCKRGBColor(67, 67, 67);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = title;
}

@end
