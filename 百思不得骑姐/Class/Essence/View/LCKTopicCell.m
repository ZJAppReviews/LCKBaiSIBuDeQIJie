//
//  LCKTopicCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/8.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKTopicCell.h"
#import "LCKTopic.h"
#import "UIImageView+WebCache.h"
#import "LCKTopicPictureView.h"
#import "LCKTopicVoiceView.h"
#import "LCKTopicVideoView.h"
#import "LCKUser.h"
#import "LCKComent.h"

@interface LCKTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *xinaVVIew;
@property (weak, nonatomic) IBOutlet UILabel *topicTextLabel;

/** 图片帖子中间的内容 */
@property (nonatomic, weak) LCKTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) LCKTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) LCKTopicVideoView *videoView;

@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@end


@implementation LCKTopicCell

-(void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

//懒加载
-(LCKTopicPictureView *)pictureView{
    if (!_pictureView) {
        LCKTopicPictureView *pictureView = [LCKTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(LCKTopicVoiceView *)voiceView{
    if (!_voiceView) {
        LCKTopicVoiceView *voiceView =[LCKTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(LCKTopicVideoView *)videoView{
    if (!_videoView) {
        LCKTopicVideoView *videoView = [LCKTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}



-(void)setTopic:(LCKTopic *)topic{
    
//    //测试新浪V
//    topic.sina_v = (int)(arc4random_uniform(10) / 2);
//
    
    _topic = topic;
    
    //是否为新浪会员
    self.xinaVVIew.hidden = !topic.sina_v;
    //设置Cell中的数据
    self.nameLabel.text = topic.name;
    
    //日期格式化
    self.creatTimeLabel.text = topic.create_time;
    
    //正文
    self.topicTextLabel.text = topic.text;
    
    //头像
    NSString *url = topic.profile_image;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 按钮数字格式化
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == LCKTopicTypePicture){
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;//这里没有位置，需要设置
        self.pictureView.frame = topic.pictureF;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == LCKTopicTypeVoice){
        self.voiceView.hidden = NO;
        //传递模型
        self.voiceView.topic = topic;
        //设置声音中间控件的位置（这需要到模型［LCKTopic］中设置）
        self.voiceView.frame = topic.voiceF;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }else if(topic.type == LCKTopicTypeVideo){
        self.videoView.hidden = NO;
        
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }else{
        
        //cell循环利用时出现问题解决方法如下(下面的代码隐藏后，在新建的时候要设置为显示)
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
//    LCKLog(@"%@", topic.top_cmt);//判断模型是否转化成功
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.topCommentView.hidden = NO;
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCommentView.hidden = YES;
    }


}

/**
 * 按钮数字格式化
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = LCKTopicCellMargin;
    frame.size.width -= LCKTopicCellMargin * 2;
    frame.size.height -= LCKTopicCellMargin;
    frame.origin.y += LCKTopicCellMargin;
    
    [super setFrame:frame];
}

@end
