//
//  LCKTopicPictureView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/9.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicPictureView.h"
#import "UIImageView+WebCache.h"
#import "LCKTopic.h"

@interface LCKTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** Gif图片 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation LCKTopicPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
}


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
@end
