//
//  KWTextField.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTextField.h"

static NSString *const KWPlaceholderTextColor = @"_placeholderLabel.textColor";
@implementation KWTextField

- (void)awakeFromNib
{
    //设置光标颜色与文字颜色一致
    self.tintColor = self.textColor;
}

/** 重写becomeFirstResponder与resignFirstResponder方法，解决光标聚焦切换的问题*/
- (BOOL)becomeFirstResponder
{
    //成为第一响应者,光标变亮
    [self setValue:self.textColor forKeyPath:KWPlaceholderTextColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    //取消成为第一响应者,光标变灰色
    [self setValue:[UIColor grayColor] forKeyPath:KWPlaceholderTextColor];
    return [super resignFirstResponder];
}

@end
