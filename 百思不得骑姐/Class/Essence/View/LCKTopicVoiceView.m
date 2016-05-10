//
//  LCKTopicVoiceView.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/10.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicVoiceView.h"
#import "LCKTopic.h"
#import "UIImageView+WebCache.h"

@interface LCKTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceLength;

@end

@implementation LCKTopicVoiceView

+(instancetype)voiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
    
    
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数样式
//    LCKLog(@"%zd",topic.playcount);
    if (topic.playcount > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放%.1f万次",topic.playcount / 10000.0];
    }else if(topic.playcount <= 10000){
    self.playCountLabel.text = [NSString stringWithFormat:@"播放%zd次",topic.playcount];
    }
    
    //处理时长的样式
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceLength.text = [NSString stringWithFormat:@"时长:%zd:%zd",minute,second];
    
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
