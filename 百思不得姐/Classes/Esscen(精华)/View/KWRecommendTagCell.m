//
//  KWRecommendTagCell.m
//  百思不得姐
//
//  Created by 王鑫 on 16/5/10.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWRecommendTagCell.h"
#import "KWRecommendTag.h"
#import "UIImageView+WebCache.h"

@interface KWRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImgView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation KWRecommendTagCell

//重写tags的setter方法
- (void)setTags:(KWRecommendTag *)tags
{
    _tags = tags;
    [self.imageListImgView sd_setImageWithURL:[NSURL URLWithString:tags.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = tags.theme_name;
    //优化数字
    NSString *subNumber = nil;
    if (tags.sub_number < 10000)
    {
        //若数字大于10000，直接显示
        subNumber = [NSString stringWithFormat:@"%zd人已订阅",tags.sub_number];
    }
    else
    {
        //若数字大于10000，显示X.X万人已订阅
        subNumber = [NSString stringWithFormat:@"%.1f万人已订阅",tags.sub_number/10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

//重写setFrame:方法来调整cell
/** 不管外部如何更改frame都会回到这里设置好frame然后交个super父类布局*/
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
