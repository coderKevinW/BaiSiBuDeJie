//
//  KWVerticalButton.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWVerticalButton.h"

@implementation KWVerticalButton

//1 初始化设置
- (void)setup
{
    //文字居中对齐
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//2-1 纯代码时重写initWithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

//2-2 从XIB中获取
- (void)awakeFromNib
{
    [self setup];
}

//3 重新调整UIButton中的布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    //图片调整
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //文字调整
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
