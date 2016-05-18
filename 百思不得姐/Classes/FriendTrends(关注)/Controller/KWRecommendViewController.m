#import "KWRecommendViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

@interface KWRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation KWRecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1 初始化 与 设置
    [self initializeAndSetup];
    //2 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //3 第一次发生请求
    [self sendRequestAboutLeft];
}

#pragma mark - 1 初始化 与 设置
- (void)initializeAndSetup
{
    //设置标题
    self.title = @"推荐关注";
    //设置全局背景色
    self.view.backgroundColor = KWGlobalBg;
}

#pragma mark - 2 第一次发生请求
- (void)sendRequestAboutLeft
{
    //1 准备字典 与 mgr
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2 发送GET请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //请求成功隐藏指示器
         [SVProgressHUD dismiss];
         //打印字典
         KWLog(@"%@",responseObject);
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD showErrorWithStatus:@"请求失败，请再次请求。"];
     }];
}

//#pragma mark - UITableViewDataSource Method
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
//
//#pragma mark - UITableViewDelegate Method
@end
