/**
 //3 利用KVC获取tabBar:self.tabBar = tabBar;相当于XIB中继承自定义的类
 KWTabBar *tabBar = [[KWTabBar alloc]init];
 [self setValue:tabBar forKeyPath:@"tabBar"];
 */

#import "KWTabBarController.h"
#import "KWNavigationController.h"
#import "KWEssenceViewController.h"
#import "KWNewViewController.h"
#import "KWFriendTrendsViewController.h"
#import "KWMeViewController.h"
#import "KWTabBar.h"

@interface KWTabBarController ()

@end

@implementation KWTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //2 创建4个子控制器
    [self setupChildViewControllers];
    //3 利用KVC获取tabBar
    KWTabBar *tabBar = [[KWTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

//当本类第一次被调用的时候 会被 调用一次
+ (void)initialize
{
    //1 富文本化 设置UITabBarItem
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    attrsSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}

#pragma mark - 创建4个子控制器
- (void)setupChildViewControllers
{
    KWEssenceViewController *essenceVC = [[KWEssenceViewController alloc]init];
    [self setupChildViewController:essenceVC
                          andImage:[UIImage imageWithoutRendering:@"tabBar_essence_icon"]
                  andSelectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]
                          andTitle:@"精华"];
    
    KWNewViewController *newVC = [[KWNewViewController alloc]init];
    [self setupChildViewController:newVC andImage:[UIImage imageWithoutRendering:@"tabBar_new_icon"]
                  andSelectedImage:[UIImage imageWithoutRendering:@"tabBar_new_click_icon"]
                          andTitle:@"新帖"];
    
    KWFriendTrendsViewController *friendTrendsVC = [[KWFriendTrendsViewController alloc]init];
    [self setupChildViewController:friendTrendsVC andImage:[UIImage imageWithoutRendering:@"tabBar_friendTrends_icon"]
                  andSelectedImage:[UIImage imageWithoutRendering:@"tabBar_friendTrends_click_icon"]
                          andTitle:@"关注"];
    
    KWMeViewController *meVC = [[KWMeViewController alloc]init];
    [self setupChildViewController:meVC andImage:[UIImage imageWithoutRendering:@"tabBar_me_icon"]
                  andSelectedImage:[UIImage imageWithoutRendering:@"tabBar_me_click_icon"]
                          andTitle:@"我"];
}

- (void)setupChildViewController:(UIViewController *)vc
                        andImage:(UIImage *)image
                andSelectedImage:(UIImage *)selectedImage
                        andTitle:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    KWNavigationController *naviVC = [[KWNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:naviVC];
}

@end
