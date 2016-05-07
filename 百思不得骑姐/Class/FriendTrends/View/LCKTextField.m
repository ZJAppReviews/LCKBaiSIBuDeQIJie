//
//  LCKTextField.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/7.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTextField.h"
#import <objc/runtime.h>

static NSString * const LCKPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation LCKTextField
/**
 *  创建完后调用的方法
 */
-(void)awakeFromNib{
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor redColor];
    
    [self setValue:[UIColor grayColor] forKeyPath:LCKPlaceholderColorKeyPath];
    //设置光标颜色
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];

}

//-(void)setHighlighted:(BOOL)highlighted{
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//}

-(BOOL)becomeFirstResponder{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:LCKPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self setValue:self.textColor forKeyPath:LCKPlaceholderColorKeyPath];

    return [super resignFirstResponder];
}

//+(void)initialize{
//    
//    unsigned int count = 0;
//    
//    //copy出所有的成员变量
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0 ;i<count;i++) {
//        //取出成员变量
//        Ivar ivar = *(ivars + i);
//        
//        LCKLog(@"%s",ivar_getName(ivar));
//    }
//    
//    //释放
//    free(ivars);
//}

//-(void)drawPlaceholderInRect:(CGRect)rect{
////    
////    [self.placeholder drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:self.font}];
////    [super drawPlaceholderInRect:rect];
//    
//
//    /**
//     *  运行时：Runtime
//     苹果官方的一套C语言库
//     能够操作很多底层隐藏的成员变量/成员方法.....
//     需要导入库，由于是官方的库，因此使用<>来括住
//     */
//    
//}

@end
