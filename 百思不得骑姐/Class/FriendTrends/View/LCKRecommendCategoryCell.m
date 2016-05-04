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
    // Initialization code
}

-(void)setCategory:(LCKRecommendCategory *)category{
    
    _category = category;
    self.textLabel.text = category.name;
    
}

@end
