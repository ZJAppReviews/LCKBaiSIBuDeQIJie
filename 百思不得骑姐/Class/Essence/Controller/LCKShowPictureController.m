//
//  LCKShowPictureController.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/9.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKShowPictureController.h"
#import "LCKTopic.h"
#import "UIImageView+WebCache.h"
#import "LCKProgressView.h"
#import "SVProgressHUD.h"

@interface LCKShowPictureController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet LCKProgressView *progressView;

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation LCKShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;//图片可以点击
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backVC)]];
    [self.scrollView addSubview:imageView];
 
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = LCKScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > LCKScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = LCKScreenH * 0.5;
    }
    
    // 马上显示当前图片的下载进度（模型更新的最新图片下载的值）
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
//    
//    // 下载图片
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    
    // 下载图片（与之前未下载完就点入的下载图片是同一个下载，不会重复下载）
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
}

- (IBAction)backVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
    
    // 将图片写入相册(这方法不会导致数组越界，推荐使用)
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

@end
