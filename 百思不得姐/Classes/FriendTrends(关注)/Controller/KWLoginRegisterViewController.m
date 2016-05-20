//
//  KWLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWLoginRegisterViewController.h"

@interface KWLoginRegisterViewController ()

/** 中间父view左边距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation KWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//调整控制器的状态栏:亮色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//点击使登陆框或者注册框切换
- (IBAction)registerOrLoginClick:(UIButton *)sender
{
    //取消编辑模式
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0)
    {
        self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected = YES;
    }
    else
    {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    
    //加入动画模式
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//
- (IBAction)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
