//
//  LCKPlaceholderTextView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/17.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKPlaceholderTextView.h"

@interface LCKPlaceholderTextView()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation LCKPlaceholderTextView

-(UILabel *)placeholderLabel{
    
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
//    [self setNeedsDisplay];
    self.placeholderLabel.hidden = self.hasText;
}

/**
 * 绘制占位文字(每次drawRect:之前, 会自动清除掉之前绘制的内容)
 */
//- (void)drawRect:(CGRect)rect {
//    // 如果有文字, 直接返回, 不绘制占位文字
//    //    if (self.text.length || self.attributedText.length) return;
//    if (self.hasText) return;
//    
//    // 处理rect
//    rect.origin.x = 4;
//    rect.origin.y = 7;
//    rect.size.width -= 2 * rect.origin.x;
//    
//    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.font;
//    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//}
/**
 * 更新占位文字的尺寸
 */


- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(LCKScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    self.placeholderLabel.backgroundColor = [UIColor redColor];
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
//    [self setNeedsDisplay];
    self.placeholderLabel.textColor = placeholderColor;

}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
//    [self setNeedsDisplay];
    self.placeholderLabel.text = placeholder;
    
    [self updatePlaceholderLabelSize];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
//    [self setNeedsDisplay];
    self.placeholderLabel.font = font;
    
    [self updatePlaceholderLabelSize];

}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
//    [self setNeedsDisplay];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
//    [self setNeedsDisplay];
    [self textDidChange];
}

@end
