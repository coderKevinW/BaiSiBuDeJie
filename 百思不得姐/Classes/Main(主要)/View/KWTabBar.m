/** 
 UITabBar就是tabBar下面的一个整条，而tabBarItem(UITabBarButton)就是其中的图标
 */
#import "KWTabBar.h"

@interface KWTabBar()

@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation KWTabBar

//纯代码创建会进入该方法:[ alloc]init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
    }
    return self;
}

//布局(frame)发生变化之后会进入该方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    //准备
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置publishButton的frame和size
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    //重新设置4个图标的位置
    //准备
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    NSUInteger index = 0;
    for (UIView *button in self.subviews)
    {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            //索引增加
            index ++;
        }
    }
}

@end
