//
//  KWWordTableViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/11.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTopicViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "KWTopics.h"
#import "KWTopicsCell.h"

@interface KWTopicViewController ()

/** 全局模型数组*/
@property (nonatomic,strong) NSMutableArray *topics;
/** 上一次的请求参数*/
@property (nonatomic,strong) NSMutableDictionary *params;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;

@end

static NSString *const KWTopicsCellID = @"topic";

@implementation KWTopicViewController

//懒加载
- (NSMutableArray *)topics
{
    if (!_topics)
    {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1 初始化与设置
    [self initializeAndSetup];
    
    //2 初始化上下拉刷新控件 并 发送请求
    [self setupRefresh];
}

#pragma mark - 1 初始化与设置
- (void)initializeAndSetup
{
    //1 设置tableView的页边距
    CGFloat top = KWTitilesViewH + KWTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 257;
    
    //2 注册对应的tableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KWTopicsCell class]) bundle:nil] forCellReuseIdentifier:KWTopicsCellID];
}

#pragma mark - 2 初始化上下拉刷新控件 并 发送请求
- (void)setupRefresh
{
    //设置下拉刷新控件
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewTopics)];
    self.tableView.header.autoChangeAlpha = YES;
    // 默认刷新首页
    [self.tableView.header beginRefreshing];
    
    //设置上拉刷新控件
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreTopics)];
    //    self.tableView.footer.hidden = YES;
}

- (void)requestNewTopics
{
    //结束上拉刷新
    [self.tableView.footer endRefreshing];
    
    //1 参数准备
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2 发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             //避免重复请求
             if (self.params != params) return ;
             //请求成功，清空页码
             self.page = 0;
             //记录maxtime
             self.maxtime = responseObject[@"info"][@"maxtime"];
             //字典 ——> 模型
             self.topics = [KWTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
             //刷新表格
             [self.tableView reloadData];
             //结束下拉刷新
             [self.tableView.header endRefreshing];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             //避免重复请求
             if (self.params != params) return ;
             //结束下拉刷新
             [self.tableView.header endRefreshing];
         }];
}

- (void)requestMoreTopics
{
    //避免冲突,结束下拉刷新
    [self.tableView.header endRefreshing];
    
    //1 参数准备
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.page ++;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2 发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             //避免重复请求
             if (self.params != params) return;
             //记录maxtime
             self.maxtime = responseObject[@"info"][@"maxtime"];
             //字典 ——> 模型
             NSArray *newTopics = [KWTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
             [self.topics addObjectsFromArray:newTopics];
             //刷新表格
             [self.tableView reloadData];
             //结束上拉刷新
             [self.tableView.footer endRefreshing];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             //避免重复请求
             if (self.params != params) return ;
             //请求失败 page-1
             self.page --;
             //结束上拉刷新
             [self.tableView.footer endRefreshing];
         }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KWTopicsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:KWTopicsCellID];
    cell.topics = self.topics[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KWTopics *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
@end
