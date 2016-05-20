//
//  KWFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/7.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWFriendTrendsViewController.h"
#import "KWRecommendViewController.h"
#import "KWLoginRegisterViewController.h"

@interface KWFriendTrendsViewController ()

@end

@implementation KWFriendTrendsViewController

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
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] andHighlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] andTarget:self andAction:@selector(friendsClick)];
}

- (void)friendsClick
{
    KWRecommendViewController *vc = [[KWRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginOrRegisterClick
{
    KWLoginRegisterViewController *vc = [[KWLoginRegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
