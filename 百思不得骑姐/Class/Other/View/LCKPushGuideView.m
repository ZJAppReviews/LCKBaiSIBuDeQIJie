//
//  LCKPushGuideView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKPushGuideView.h"

@implementation LCKPushGuideView

+(instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//透明按钮（技巧）
- (IBAction)dissmissPushGuide {
    [self removeFromSuperview];
}

@end
