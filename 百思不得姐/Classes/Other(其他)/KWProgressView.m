

#import "KWProgressView.h"

@implementation KWProgressView

/**
 *  自定义进度条控件，继承第三方框架，进行一定程度上的初始化。
 *  好处:(1)将来换控件时能减少头文件的修改。
 *       (2)拖的控件不需要修改
 */
- (void)awakeFromNib
{
    //弧度统一设置为2
    self.roundedCorners = 2;
    //中间label字体设置为白色
    self.progressLabel.textColor = [UIColor whiteColor];
}

//截拦setProgress:方法，进行一些初始化的设置
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    //设置中间progressLabel的显示格式
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
