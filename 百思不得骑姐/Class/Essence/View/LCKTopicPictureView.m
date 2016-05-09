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
#import "SVProgressHUD.h"
#import "LCKProgressView.h"
#import "LCKShowPictureController.h"

@interface LCKTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** Gif图片 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

/** 进度条控件 */
@property (weak, nonatomic) IBOutlet LCKProgressView *progressView;
@end

@implementation LCKTopicPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(LCKTopic *)topic{
    _topic = topic;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
    }
}

//要想点击按钮能干显示就需要将user interaction 设置为disable。或者不要设置为void而是返回IBOutlet，这样就可以连线
- (void)showPicture
{
    LCKShowPictureController *showPicture = [[LCKShowPictureController alloc] init];
//    showPicture.topic = self.topic;
    
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
