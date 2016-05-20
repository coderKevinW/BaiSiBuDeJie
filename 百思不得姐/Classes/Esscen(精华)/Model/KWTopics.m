//
//  KWTopics.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/12.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTopics.h"
#import "MJExtension.h"

@interface KWTopics()
{
    //cellHeight为readOnly所以添加其成员变量
    CGFloat _cellHeight;
    CGRect _pictureF;
}
@end

@implementation KWTopics

/**
 *  当服务器返回的参数属性没有意义的时候，模型属性需要自己命名
 *  系统会自动调用如下方法
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

//日期格式化处理
- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear)
    { // 今年
        if (create.isToday)
        { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFromDate:create];
            
            if (cmps.hour >= 1)
            { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }
            else if (cmps.minute >= 1)
            { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }
            else
            { // 1分钟 > 时间差距
                return @"刚刚";
            }
        }
        else if (create.isYesterday)
        { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else
        { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else
    { // 非今年
        return _create_time;
    }
}


/**
 *  重写cellHeight的getter方法
 *  1 主控制器中调用方法-[tableView: heightForRowAtIndexPath:]时，返回topic.cellHeight时调用此方法
 *  2 相当于于懒加载，tableViewCell的高度只需要计算1次
 *  3 计算pictureF
 */
- (CGFloat)cellHeight
{
    if (!_cellHeight)
    {
        //帖子label文字的最大尺寸
        CGFloat maxSizeW = [UIScreen mainScreen].bounds.size.width - 4*KWTopicCellMargin;
        CGSize maxSize = CGSizeMake(maxSizeW, MAXFLOAT);//MAXFLOAT最大的浮点数
        //帖子label的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //添加帖子之后cell的高度
        _cellHeight = KWTopicCellTextY + KWTopicCellMargin + textH;
        //添加图片之后cell的高度
        if (self.type == KWTopicTypePicture)
        {
            //首先计算pictureF
            CGFloat pictureW = maxSize.width;
            //图片按原图等比例压缩
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH > KWTopicCellPictureMaxH)
            {
                pictureH = KWTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = KWTopicCellMargin;
            CGFloat pictureY = KWTopicCellTextY + textH + KWTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            //添加图片之后cell的高度
            _cellHeight += pictureH + KWTopicCellMargin;
        }
        else if (self.type == KWTopicTypeVoice)
        {
            //首先计算voiceF
            CGFloat voiceW = maxSize.width;
            //图片按原图等比例压缩
            CGFloat voiceH = voiceW * self.height / self.width;
            CGFloat voiceX = KWTopicCellMargin;
            CGFloat voiceY = KWTopicCellTextY + textH + KWTopicCellMargin;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            //添加图片之后cell的高度
            _cellHeight += voiceH + KWTopicCellMargin;
        }
        else if (self.type == KWTopicTypeVideo)
        {
            //首先计算videoF
            CGFloat videoW = maxSize.width;
            //图片按原图等比例压缩
            CGFloat videoH = videoW * self.height / self.width;
            CGFloat videoX = KWTopicCellMargin;
            CGFloat videoY = KWTopicCellTextY + textH + KWTopicCellMargin;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            //添加图片之后cell的高度
            _cellHeight += videoH + KWTopicCellMargin;
        }
        _cellHeight += KWTopicCellBottomBarH + KWTopicCellMargin;
    }
    return _cellHeight;
}
@end
