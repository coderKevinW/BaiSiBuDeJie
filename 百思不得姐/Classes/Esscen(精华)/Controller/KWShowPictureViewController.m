//
//  KWShowPictureViewController.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/16.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWShowPictureViewController.h"
#import "KWProgressView.h"
#import "UIImageView+WebCache.h"
#import "KWTopics.h"
#import "SVProgressHUD.h"

@interface KWShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 进度条 */
@property (weak, nonatomic) IBOutlet KWProgressView *progressView;
/** 照片*/
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation KWShowPictureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW =  KWScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > KWScreenH)
    { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }
    else
    {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = KWScreenH * 0.5;
    }
    
    /**
     *  此处实现了，cell的XIB中图片下载进度 与 大图的图片下载进度 一致。
     */
    //立即显示最新的图片下载的进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //加载图片内容
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  self.progressView.hidden = NO;
                                  CGFloat progress = 1.0 * receivedSize / expectedSize;
                                  [self.progressView setProgress:progress animated:YES];
                              }
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 self.progressView.hidden = YES;
                             }];
    
}

//点击返回上一页
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存图片到本地相册
- (IBAction)savePicture
{
    //优化:当图片尚未加载完成时，提示“图片未加载完”
    if (self.imageView.image == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"图片未加载完"];
        return;
    }
    //保存图片到本地的方法
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
