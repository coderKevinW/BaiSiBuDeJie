//
//  KWRecommendCategory.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWRecommendCategory.h"

@implementation KWRecommendCategory

//懒加载
- (NSMutableArray *)users
{
    if (!_users)
    {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
