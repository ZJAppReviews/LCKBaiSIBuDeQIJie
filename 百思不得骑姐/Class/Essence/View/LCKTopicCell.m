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

@interface LCKTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@end
@implementation LCKTopicCell

-(void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
    
    //设置Cell中的数据
    self.nameLabel.text = topic.name;
    self.creatTimeLabel.text = topic.create_time;
    NSString *url = topic.profile_image;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

//    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
//    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",topic.cai] forState:UIControlStateNormal];
//    [self.shareButton setTitle:[NSString stringWithFormat:@"%zd",topic.repost] forState:UIControlStateNormal];
//    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",topic.comment] forState:UIControlStateNormal];
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];

}

/**
 * 设置底部按钮文字
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
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= margin * 2;
    frame.size.height -=margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
