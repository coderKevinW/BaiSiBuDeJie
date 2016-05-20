/**
 功能:点击titleButton时，contentScrollView跟随移动；而拖动contentScrollView时，titleButton也跟随移动
 (1)点击titleButton时，contentScrollView跟随移动
    1 初始化contentScrollView(最后设置了，默认状态下显示第一个tableView)
    2 方法 -[titleButtonClick:]中改变contentScrollView的偏移量实现self.contentScrollView的移动
         //点击titleButton时滚动到对应的contentScrollView.offset
         CGPoint offset = self.contentScrollView.contentOffset;
         offset.x = titleButton.tag * self.contentScrollView.width;
         [self.contentScrollView setContentOffset:offset animated:YES];
    3 代理方法 -[scrollViewDidEndScrollingAnimation:]点击滚动之后把tableViewVC.tableView放入对应的contentScrollView中，实现了contentScrollView显示tableView中的内容(诸多细节需要优化)
 (2)而拖动contentScrollView时，titleButton也跟随移动
    1 代理方法 -[scrollViewDidEndDecelerating:];
        //scrollView被拖拽滚动,滚动停止:会选中对应的titleButton
 */

#import "KWEssenceViewController.h"
#import "KWRecommendTagViewController.h"
#import "KWTopicViewController.h"

@interface KWEssenceViewController ()<UIScrollViewDelegate>

/** 记录上次被选中的按钮*/
@property (nonatomic,weak) UIButton *selectedButton;
/** 标签栏底部红色指示器*/
@property (nonatomic,weak) UIView *redIndicatorView;
/** 中间主要的contentScrollView*/
@property (nonatomic,weak) UIScrollView *contentScrollView;
/** 标签栏的父view*/
@property (nonatomic,weak) UIView *titleView;

@end

@implementation KWEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1 初始化与设置
    [self initializeAndSetup];    
    //3 添加5个子控制器
    [self setupChildViewControllers];
    //2 添加标签栏
    [self setupTitleView];
    //4 添加中间contentScrollView
    [self setupContentScrollView];
}

#pragma mark - 1 初始化与设置
- (void)initializeAndSetup
{
    // 设置控制器背景颜色
    self.view.backgroundColor = KWGlobalBg;
    // 设置navigationItem
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] andHighlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"]  andTarget:self andAction:@selector(tagClick)];
}

- (void)tagClick
{
    KWRecommendTagViewController *vc = [[KWRecommendTagViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 2 添加标签栏
- (void)setupTitleView
{
    //1 添加标签栏的父view
    UIView *titleView = [[UIView alloc]init];
    self.titleView = titleView;
    //titleView.frame
    titleView.y = 64,
    titleView.width = self.view.width;
    titleView.height = 35;
    //titleView的backgroundColor
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titleView];
    
    //3 添加底部红色指示器
    UIView *redIndicatorView = [[UIView alloc]init];
    //记录下来
    self.redIndicatorView = redIndicatorView;
    //redIndicatorView的背景色
    redIndicatorView.backgroundColor = [UIColor redColor];
    //redIndicatorView.frame
    /** 控制redIndicatorView.x使该控件移动,而redIndicatorView.width与titleButton相关 */
    redIndicatorView.height = 2;
    redIndicatorView.y = titleView.height - redIndicatorView.height;
    redIndicatorView.tag = -1;
   
    
    //2 添加5个标签button
    //设置width与height
    NSInteger count = self.childViewControllers.count;
    CGFloat buttonW = titleView.width / count;
    CGFloat buttonH = titleView.height;
    for (NSInteger i = 0; i < count; i++)
    {
        UIButton *titleButton = [[UIButton alloc]init];
        //titleButton.frame
        titleButton.width = buttonW;
        titleButton.height = buttonH;
        titleButton.x = i * buttonW;
        titleButton.y = 0;
        //titleButton.tag
        titleButton.tag = i;
        //titleButton的内容
        NSString *titleStr = self.childViewControllers[i].title;
        [titleButton setTitle:titleStr forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //titleButton添加监看方法
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        //4 细节问题1:初始化状态默认选中第一个titleButton,并且没有动画效果
        if (i == 0)
        {
            //修改状态
            titleButton.enabled = NO;
            self.selectedButton = titleButton;
            
            //让titleButton.titleLabel根据内部来计算尺寸
            [titleButton.titleLabel sizeToFit];
            
            self.redIndicatorView.width = titleButton.titleLabel.width;
            self.redIndicatorView.centerX = titleButton.centerX;
        }
    }
     [titleView addSubview:redIndicatorView];//此时redIndicatorView是titleView.subviews[index],其中index = 5;
}

//点击titleButton后的事件
- (void)titleButtonClick:(UIButton *)titleButton
{
    //修改状态:(1)当前选中按钮不能再被选中，(2)上次选中按钮能再次被选中，(3)记录本次被选中的按钮
    self.selectedButton.enabled = YES;
    titleButton.enabled = NO;
    self.selectedButton = titleButton;
    
    //redIndicatorView的动画
    [UIView animateWithDuration:0.05 animations:^{
        //redIndicatorView移动代码
        self.redIndicatorView.width = titleButton.titleLabel.width;
        self.redIndicatorView.centerX = titleButton.centerX;
    }];
    
    //点击titleButton时滚动到对应的contentScrollView.offset
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = titleButton.tag * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - 3 添加5个子控制器
- (void)setupChildViewControllers
{
    KWTopicViewController *allVC = [[KWTopicViewController alloc]init];
    allVC.title = @"全部";
    allVC.type = KWTopicTypeAll;
    [self addChildViewController:allVC];
    
    KWTopicViewController *pictureVC = [[KWTopicViewController alloc]init];
    pictureVC.title = @"图片";
    pictureVC.type = KWTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    KWTopicViewController *wordVC = [[KWTopicViewController alloc]init];
    wordVC.title = @"段子";
    wordVC.type = KWTopicTypeWord;
    [self addChildViewController:wordVC];
    
    KWTopicViewController *voiceVC = [[KWTopicViewController alloc]init];
    voiceVC.title = @"声音";
    voiceVC.type = KWTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    
    KWTopicViewController *videoVC = [[KWTopicViewController alloc]init];
    videoVC.title = @"视频";
    videoVC.type = KWTopicTypeVideo;
    [self addChildViewController:videoVC];

}

#pragma mark - 4 添加中间contentScrollView
- (void)setupContentScrollView
{
    //让系统不要自动调节scrollView页边距,自己设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]init];
    //记录下来
    self.contentScrollView = contentScrollView;
    //contentScrollView.frame
    contentScrollView.frame = self.view.bounds;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    //加到父view的最底层,否则会遮挡 标签栏
    [self.view insertSubview:contentScrollView atIndex:0];
    //设置contentScrollView的滚动范围
    contentScrollView.contentSize = CGSizeMake(contentScrollView.width * self.childViewControllers.count, 0);
    
    //初始化状态默认选择第一个tableView
    [self scrollViewDidEndDecelerating:contentScrollView];
}

#pragma mark - UIScrollViewDelegate Method
//titleButton使scrollView滚动，滚动停止:把tableViewVC.tableView放入对应的contentScrollView中
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //1 当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出选中的tableViewVC
    UITableViewController *tableViewVC = self.childViewControllers[index];
    
    //2 设置tableViewVC
    //2-1 tableViewVC.view.frame
    tableViewVC.view.y = 0;//默认是距离contentScrollView.y 20,故此调整
    tableViewVC.view.x = scrollView.contentOffset.x;
    tableViewVC.view.height = scrollView.height;//设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    tableViewVC.view.width = scrollView.width;
    
    //2-2 tableViewVC的页边距
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    tableViewVC.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    tableViewVC.tableView.scrollIndicatorInsets = self.contentScrollView.contentInset;
    
    [scrollView addSubview:tableViewVC.view];
}

//scrollView被拖拽滚动,滚动停止:会选中对应的titleButton
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //1 当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleButtonClick:self.titleView.subviews[index]];
}
@end
