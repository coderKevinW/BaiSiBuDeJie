//
//  KWTopicPictureView.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/15.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTopicPictureView.h"
#import "KWTopics.h"
#import "UIImageView+WebCache.h"
#import "KWProgressView.h"
#import "KWShowPictureViewController.h"

@interface KWTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条 */
@property (weak, nonatomic) IBOutlet KWProgressView *progressView;

@end

@implementation KWTopicPictureView

/** 构造方法 */
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    //消除系统自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监看:点击全屏显示图片
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)];
    [self.imageView addGestureRecognizer:tapGR];
}

//点击全屏显示图片
- (void)showPicture
{
    KWShowPictureViewController *showPictureVC = [[KWShowPictureViewController alloc]init];
    //保证点击进去的控制器的模型和此处相同，保证图片一致
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

/** 重写topic模型的setter方法 */
- (void)setTopic:(KWTopics *)topic
{
    _topic = topic;
    //判断是否为gif格式图片,gifView是否隐藏
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = !([extension.lowercaseString isEqualToString:@"gif"]);
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //计算
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        //图片加载完成，进来设置图片显示的方式
        if (topic.isBigPicture == NO) return ;
        /**
         *  利用cocos_2d绘制图片的步骤
         */
        //1 开始图片上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0);
        //2 将下载完的图片绘制到图形上下文中
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        //3 从图形上下文中获取图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //4 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //如果是大图，显示“点击看大图”按钮；如果是小图，不显示
    if (topic.isBigPicture)
    {
        self.seeBigButton.hidden = NO;
    }
    else
    {
        self.seeBigButton.hidden = YES;
    }
}

@end
