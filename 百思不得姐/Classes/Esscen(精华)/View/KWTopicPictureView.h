//
//  KWTopicPictureView.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/15.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KWTopics;

@interface KWTopicPictureView : UIView

/** topic模型属性*/
@property (nonatomic,strong) KWTopics *topic;

/** 构造方法 */
+ (instancetype)pictureView;

@end
