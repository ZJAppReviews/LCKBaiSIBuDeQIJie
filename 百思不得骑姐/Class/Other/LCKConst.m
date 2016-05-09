#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
CGFloat const LCKTitlesViewH = 35;
/** 精华-顶部标题的Y */
CGFloat const LCKTitlesViewY = 64;



/** 精华-cell-间距 */
CGFloat const LCKTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const LCKTopicCellTextY = 65;
/** 精华-cell-底部工具条的高度 */
CGFloat const LCKTopicCellBottomBarH = 30;




/** 精华-cell-图片帖子的最大高度 */
CGFloat const LCKTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
CGFloat const LCKTopicCellPictureBreakH = 250;

/** LCKUser模型-性别属性值 */
NSString * const LCKUserSexMale = @"m";
NSString * const LCKUserSexFemale = @"f";

/** 精华-cell-最热评论标题的高度 */
CGFloat const LCKTopicCellTopCmtTitleH = 20;

/** tabBar被选中的通知名字 */
NSString * const LCKTabBarDidSelectNotification = @"LCKTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key */
NSString * const LCKSelectedControllerIndexKey = @"LCKSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器 key */
NSString * const LCKSelectedControllerKey = @"LCKSelectedControllerKey";

/** 标签-间距 */
CGFloat const LCKTagMargin = 5;
/** 标签-高度 */
CGFloat const LCKTagH = 25;