//
//  KWPushGuideView.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/11.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWPushGuideView.h"

@implementation KWPushGuideView

/** 构造方法*/
+ (instancetype)pushGuideView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

/** 初始化方法*/
+ (void)showPushGuideView
{
    // 判断版本号是否相同
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSString *sanboxVersion = [udf stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion])
    {
        //获得window
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 添加推送引导页
        KWPushGuideView *pushGuideView = [KWPushGuideView pushGuideView];
        //务必设置frame
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
        // 存入沙盒中
        [udf setObject:currentVersion forKey:key];
        // 即时保存
        [udf synchronize];
    }
}

/** 从window上移除PushGuideView*/
- (IBAction)RemovePushGuideViewClick
{
    [self removeFromSuperview];
}

@end
