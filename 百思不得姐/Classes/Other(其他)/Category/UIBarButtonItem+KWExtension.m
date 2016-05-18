//
//  UIBarButtonItem+KWExtension.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/7.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "UIBarButtonItem+KWExtension.h"

@implementation UIBarButtonItem (KWExtension)

+ (instancetype)itemWithImage:(UIImage *)image
          andHighlightedImage:(UIImage *)highlightedImage
                    andTarget:(id)target
                    andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    return item;
}
@end
