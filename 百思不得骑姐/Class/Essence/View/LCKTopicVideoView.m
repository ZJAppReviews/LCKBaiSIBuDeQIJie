//
//  LCKTopicVideoView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicVideoView.h"
#import "LCKTopic.h"
#import "UIImageView+WebCache.h"
#import "LCKShowPictureController.h"

@interface LCKTopicVideoView()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation LCKTopicVideoView

+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数样式
    if (topic.playcount > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放%.1f万次",topic.playcount / 10000.0];
    }else if(topic.playcount <= 10000){
        self.playCountLabel.text = [NSString stringWithFormat:@"播放%zd次",topic.playcount];
    }
    
    //处理时长的样式
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoLengthLabel.text = [NSString stringWithFormat:@"时长:%0.2zd:%0.2zd",minute,second];
}


//要想点击按钮能干显示就需要将user interaction 设置为disable。或者不要设置为void而是返回IBOutlet，这样就可以连线
- (void)showPicture
{
    LCKShowPictureController *showPicture = [[LCKShowPictureController alloc] init];
    showPicture.topic = self.topic;
    
    //UIView（也就是self）不是控制器是没有present方法的，因此使用下面的方法来推出控制器View
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
@end
