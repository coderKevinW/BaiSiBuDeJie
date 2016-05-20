//
//  KWTopicsCell.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/12.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWTopicsCell.h"
#import "UIImageView+WebCache.h"
#import "KWTopics.h"
#import "KWTopicPictureView.h"
#import "KWTopicVoiceView.h"
#import "KWTopicVideoView.h"

@interface KWTopicsCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子XIB*/
@property (weak, nonatomic) KWTopicPictureView *topicPictureView;
/** 声音帖子XIB*/
@property (weak, nonatomic) KWTopicPictureView *topicVoiceView;
/** 视频帖子XIB*/
@property (weak, nonatomic) KWTopicVideoView *topicVideoView;

@end

@implementation KWTopicsCell

/**
 *  懒加载:topicPictureView仅创建1次
 *  懒加载:topicVoiceView仅创建1次
 */

- (KWTopicPictureView *)topicPictureView
{
    if (!_topicPictureView)
    {
        _topicPictureView = [KWTopicPictureView pictureView];
        [self.contentView addSubview:_topicPictureView];
        self.topicPictureView = _topicPictureView;
    }
    return _topicPictureView;
}

- (KWTopicVoiceView *)topicVoiceView
{
    if (!_topicVoiceView)
    {
        _topicVoiceView = [KWTopicVoiceView voiceView];
        [self.contentView addSubview:_topicVoiceView];
        self.topicVoiceView = _topicVoiceView;
    }
    return _topicVoiceView;
}

- (KWTopicVideoView *)topicVideoView
{
    if (!_topicVideoView)
    {
        _topicVideoView = [KWTopicVideoView videoView];
        [self.contentView addSubview:_topicVideoView];
        self.topicVideoView = _topicVideoView;
    }
    return _topicVideoView;
}

- (void)awakeFromNib
{
    //设置背景图片
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = backgroundView;
}

//重写topics的setter方法
- (void)setTopics:(KWTopics *)topics
{
    _topics = topics;
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 设置名字
    self.nameLabel.text = topics.name;
    
    //是否加sinaV
    self.sinaVView.hidden = !topics.sina_v;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topics.create_time;
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topics.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topics.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topics.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topics.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topics.text;
    
    // 根据TopicCellType加载中间自定义XIB的类型
    if (topics.type == KWTopicTypePicture)
    {
        self.topicPictureView.hidden = NO;
        //如果XIB是图片板块
        self.topicPictureView.topic = topics;
        self.topicPictureView.frame = topics.pictureF;
        
        self.topicVoiceView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
    else if (topics.type == KWTopicTypeVoice)
    {
        self.topicVoiceView.hidden = NO;
        //如果XIB是声音板块
        self.topicVoiceView.topic = topics;
        self.topicVoiceView.frame = topics.voiceF;
        
        self.topicPictureView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
    else if (topics.type == KWTopicTypeVideo)
    {
        self.topicVideoView.hidden = NO;
        //如果XIB是视频板块
        self.topicVideoView.topic = topics;
        self.topicVideoView.frame = topics.videoF;
        
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = YES;
    }
    else
    {
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
}

//重写setFrame方法调整cell页边距
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = KWTopicCellMargin;
    frame.origin.y += KWTopicCellMargin;
    frame.size.width -= 2*KWTopicCellMargin;
    frame.size.height -= KWTopicCellMargin;
    [super setFrame:frame];
}

//抽取处理数字的方法
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger )count placeholder:(NSString *)placeholder
{
    if (count > 10000)
    {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }
    else if (count > 0)
    {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}



@end
