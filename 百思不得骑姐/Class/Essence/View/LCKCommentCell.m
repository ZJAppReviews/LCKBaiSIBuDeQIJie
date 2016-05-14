//
//  LCKCommentCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/11.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKCommentCell.h"
#import "LCKComent.h"
#import "UIImageView+WebCache.h"
#import "LCKUser.h"

@interface LCKCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end


@implementation LCKCommentCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    //对于图层的操作，会显得程序特别卡（解决方法：从服务器中返回的正方形的图片，转变为圆角图片直接显示在imageView中即可）
//    //设置头像图片圆角
//    self.profileImageView.layer.cornerRadius = self.profileImageView.size.height * 0.5;
//    //A Boolean indicating whether sublayers are clipped to the layer’s bounds.
//    //指明子子图层是否剪切图层
//    self.profileImageView.layer.masksToBounds = YES;
    
}

- (void)setComment:(LCKComent *)comment
{
    _comment = comment;
    
    [self.profileImageView setHeader:comment.user.profile_image];
    
    self.sexView.image = [comment.user.sex isEqualToString:LCKUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = LCKTopicCellMargin;
    frame.size.width -= 2 * LCKTopicCellMargin;
    [super setFrame:frame];//必须写上，否则会出现不可预测的bug
}


@end
