//
//  UIView+LCKExtention.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCKExtention)
//在分类中写属性，只会自动生成方法的声明，不会生成方法的实现和带_的的成员变量
@property (nonatomic , assign) CGFloat width;
@property (nonatomic , assign) CGFloat height;

@property (nonatomic , assign) CGFloat x;
@property (nonatomic , assign) CGFloat y;

@property (nonatomic , assign) CGFloat centerX;
@property (nonatomic , assign) CGFloat centerY;

@property (nonatomic , assign) CGSize size;

@end
