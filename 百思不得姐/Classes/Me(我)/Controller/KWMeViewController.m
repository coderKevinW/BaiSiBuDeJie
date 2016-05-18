//
//  KWMeViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/7.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWMeViewController.h"

@interface KWMeViewController ()

@end

@implementation KWMeViewController

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
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] andHighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] andTarget:self andAction:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] andHighlightedImage:[UIImage imageNamed:@"mine-moon-icon-click"] andTarget:self andAction:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

- (void)settingClick
{
    KWLogFunc;
}

- (void)moonClick
{
    KWLogFunc;
}
@end
