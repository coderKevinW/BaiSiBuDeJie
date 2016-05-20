//
//  KWRecommendTag.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWRecommendTag : NSObject

/** 头像 */
@property (nonatomic,strong) NSString *image_list;
/** 主题名字 */
@property (nonatomic,strong) NSString *theme_name;
/** 订阅数量 */
@property (nonatomic,assign) NSInteger sub_number;

@end
