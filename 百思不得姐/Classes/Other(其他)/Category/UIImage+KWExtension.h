//
//  UIImage+KWExtension.h
//  百思不得姐
//
//  Created by 王鑫 on 16/5/7.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KWExtension)


/** 图片去除默认渲染的方法*/
+ (UIImage *)imageWithoutRendering:(NSString *)originalImageStr;

@end
