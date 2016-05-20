//
//  KWTopicVideoView.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/18.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KWTopics;

@interface KWTopicVideoView : UIView

/** 模型属性 */
@property (nonatomic,strong) KWTopics *topic;

/** 构造方法 */
+ (instancetype)videoView;

@end
