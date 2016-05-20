//
//  KWRecommendTagViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWRecommendTagViewController.h"
#import "KWRecommendTagCell.h"
#import "KWRecommendTag.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

@interface KWRecommendTagViewController ()

/** tags模型数组*/
@property (nonatomic, strong) NSArray *tagsArr;

@end

static NSString *const KWTagID = @"tag";

@implementation KWRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 初始化 与 设置
    [self initializeAndSetup];
    //2 从XIB中注册tableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KWRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:KWTagID];
    //3 发送请求请求JSON数据
    [self sendRequestAboutTags];
}

#pragma mark - 1 初始化 与 设置
- (void)initializeAndSetup
{
    //设置标题
    self.title = @"推荐关注";
    //全局背景色
    self.view.backgroundColor = KWGlobalBg;
    //设置rowHeight
    self.tableView.rowHeight = 70;
    //取消系统自带下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 2 发送请求请求JSON数据
- (void)sendRequestAboutTags
{
    //显示蒙板
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.tagsArr = [KWRecommendTag objectArrayWithKeyValuesArray:responseObject];
         //刷新表格
         [self.tableView reloadData];
         //请求成功,取消门板
         [SVProgressHUD dismiss];
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"数据请求失败，请再次请求！"];
     }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:KWTagID];
    cell.tags = self.tagsArr[indexPath.row];
    return cell;
}



@end
