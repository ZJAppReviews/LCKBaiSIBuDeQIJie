//
//  LCKVerticalButton.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/7.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKVerticalButton.h"

@implementation LCKVerticalButton

//通过自定义按钮的方法来规范后续使用这个类来建立的按钮的形式
-(instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

-(void)awakeFromNib{
    
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
