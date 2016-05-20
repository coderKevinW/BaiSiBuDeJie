//
//  KWTopics.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/12.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWTopics : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的高度*/
@property (nonatomic, assign) CGFloat height;
/** 图片的宽度*/
@property (nonatomic, assign) CGFloat width;
/** 小图片URL*/
@property (nonatomic, copy) NSString *small_image;
/** 中图片URL*/
@property (nonatomic, copy) NSString *middle_image;
/** 大图片URL*/
@property (nonatomic, copy) NSString *large_image;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/** 帖子的类型 */
@property (nonatomic, assign) KWTopicType type;

/** 额外属性辅助开发*/
/** 计算cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 图片是否为大图*/
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicture;
/** 图片下载进度*/
@property (nonatomic, assign) CGFloat pictureProgress;
/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;


@end
