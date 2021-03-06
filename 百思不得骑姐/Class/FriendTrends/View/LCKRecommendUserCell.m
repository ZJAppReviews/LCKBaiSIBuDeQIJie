//
//  LCKRecommendUserCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/5.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKRecommendUserCell.h"
#import "LCKRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface LCKRecommendUserCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 呢称 */
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
/** 粉丝数 */
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end

@implementation LCKRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUser:(LCKRecommendUser *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    //订阅数的简写
    NSString *fansCount = nil;
    if (user.fans_count < 1000) {
        fansCount =[NSString stringWithFormat:@"%zd人订阅",user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",user.fans_count / 1000.0];
    }
    
    self.fansCountLabel.text = fansCount;
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置头像为圆形头像
    NSString *url = [NSString stringWithFormat:@"%@",[NSURL URLWithString:user.header]];
    [self.headerImageView setHeader:url];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
