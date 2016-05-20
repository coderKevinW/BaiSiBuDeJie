//
//  KWTopicPictureView.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/15.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTopicVideoView.h"
#import "KWTopics.h"
#import "UIImageView+WebCache.h"
#import "KWProgressView.h"
#import "KWShowPictureViewController.h"

@interface KWTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end

@implementation KWTopicVideoView

/** 构造方法 */
+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    //消除系统自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    //    给图片添加监看:点击全屏显示图片
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
    
    //显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd 次播放",topic.playcount];
    //播放时间
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",minute,second];
    
}

@end
