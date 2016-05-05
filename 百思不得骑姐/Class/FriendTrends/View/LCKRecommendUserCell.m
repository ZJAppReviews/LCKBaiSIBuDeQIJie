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
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
