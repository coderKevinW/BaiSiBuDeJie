#import <UIKit/UIKit.h>
/**
 *  精华板块
 */
/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const KWTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const KWTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const KWTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const KWTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const KWTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const KWTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const KWTopicCellPictureBreakH;

/** 精华板块不同类型的枚举*/
typedef enum {
    KWTopicTypeAll = 1,
    KWTopicTypePicture = 10,
    KWTopicTypeWord = 29,
    KWTopicTypeVoice = 31,
    KWTopicTypeVideo = 41
} KWTopicType;