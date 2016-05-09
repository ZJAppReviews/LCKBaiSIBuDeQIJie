//
//  LCKProgressView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/9.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKProgressView.h"

@implementation LCKProgressView

-(void)awakeFromNib{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress{
    
    [super setProgress:progress];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
