//
//  LCKRecommendCategory.h
//  百思不得骑姐
//
//  Created by 黄海良 on 16/5/4.
//  Copyright © 2016年 黄海良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCKRecommendCategory : NSObject
/** id */
@property (nonatomic , assign) NSUInteger *id;
/** name */
@property (nonatomic , copy) NSString *name;
/** count */
@property (nonatomic , assign) NSUInteger *count;
@end
