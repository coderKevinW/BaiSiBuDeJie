//
//  KWRecommendUser.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
