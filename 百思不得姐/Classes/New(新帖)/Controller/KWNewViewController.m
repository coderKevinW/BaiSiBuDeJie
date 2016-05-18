//
//  KWNewViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/7.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWNewViewController.h"

@interface KWNewViewController ()

@end

@implementation KWNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1 初始化与设置
    [self initializeAndSetup];
}

#pragma mark - 1 初始化与设置
- (void)initializeAndSetup
{
    // 设置控制器背景颜色
    self.view.backgroundColor = KWGlobalBg;
    // 设置navigationItem
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] andHighlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] andTarget:self andAction:@selector(tagClick)];
}

- (void)tagClick
{
    KWLogFunc;
}

@end
