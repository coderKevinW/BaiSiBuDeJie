//
//  NSDate+KWExtension.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/14.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KWExtension)
/** 计算时间间隔的方法*/
- (NSDateComponents *)deltaFromDate:(NSDate *)fromDate;

/** 判断是否今年*/
- (BOOL)isThisYear;

/** 判断是否今天*/
- (BOOL)isToday;

/** 判断是否昨天*/
- (BOOL)isYesterday;

@end
