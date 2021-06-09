//
//  ZeroSDCycleViewCell.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/7.
//  Copyright © 2017年 2966497308@qq.com. All rights reserved.
//

#import "ZeroSDCycleViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation ZeroSDCycleViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    _imageView.contentMode =   UIViewContentModeScaleToFill;
    [self.contentView addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

-(void)setImageUrl:(NSString*)url{
    [ _imageView sd_setImageWithURL:[NSURL URLWithString:url]
    placeholderImage:[UIImage imageNamed:@"4_Gods_pocket"]];
}

@end
