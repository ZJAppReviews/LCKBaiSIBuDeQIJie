//
//  LCKRecommendTagViewCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/5.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendTagViewCell.h"
#import "LCKRecommendTags.h"
#import "UIImageView+WebCache.h"

@interface LCKRecommendTagViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@end

@implementation LCKRecommendTagViewCell

-(void)setRecommendTag:(LCKRecommendTags *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    //订阅数的简写
    NSString *subNumbedr = nil;
    if (recommendTag.sub_number < 1000) {
        subNumbedr =[NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
    subNumbedr = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 1000.0];
    }
    self.subNumberLabel.text = subNumbedr;
}
/**
 *  外面修改的位置，都需要通过这个方法来进行过滤。在这里修改的位置都会被修改掉的（因为这是最后进行位置排列的方法
 *
 *  一般自定义cell的位置都是通过重写这个方法来定位位置的
 */
-(void)setFrame:(CGRect)frame{
   
    frame.origin.x = 10;
    frame.size.width -=20;
    frame.size.height -=1;
    
    [super setFrame:frame];//这个是在最后的时候加上去的
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
