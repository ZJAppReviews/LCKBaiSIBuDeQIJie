//
//  LCKMeCell.m
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/17.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import "LCKMeCell.h"

@implementation LCKMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }

    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LCKTopicCellMargin;
}

//通过重写这个方法来达到整个cell往上挪动
//- (void)setFrame:(CGRect)frame
//{
////    XMGLog(@"%@", NSStringFromCGRect(frame));
//    frame.origin.y -= (35 - XMGTopicCellMargin);
//    [super setFrame:frame];
//}
@end
