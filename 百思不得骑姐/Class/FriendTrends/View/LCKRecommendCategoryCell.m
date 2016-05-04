//
//  LCKRecommendCategoryCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendCategoryCell.h"
#import "LCKRecommendCategory.h"

@implementation LCKRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // xib中调用的左侧，可在这里设置背景颜色
    self.backgroundColor = LCKRGBColor(244, 244, 244);
    
//    self.textLabel.textColor = LCKRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = LCKRGBColor(219, 21, 26);
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
}

-(void)setCategory:(LCKRecommendCategory *)category{
    
    _category = category;
    self.textLabel.text = category.name;
    
}

//当cell进入选中状态时，会调用此方法
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.selectedIndictor.hidden = !selected;
    
    self.textLabel.textColor = selected ? LCKRGBColor(219, 21, 26) : LCKRGBColor(78, 78, 78) ;
    
}

//这个方法可以将cell中的增加一条白线进行分割
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.textLabel.height = self.contentView.height - 1;
//}

@end
