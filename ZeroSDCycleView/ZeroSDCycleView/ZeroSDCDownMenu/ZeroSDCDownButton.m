//
//  ZeroSDCDownButton.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/10/1.
//  Copyright © 2017年 陈美安. All rights reserved.
// down_Arrow

#import "ZeroSDCDownButton.h"

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation ZeroSDCDownButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
//        [self setTitleColor: HexRGB(0x333333) forState:UIControlStateNormal];
        [self setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"down_Arrow"] forState:UIControlStateNormal];
        [self setTitle:@"明细" forState:UIControlStateNormal];
         self.titleLabel.font = [UIFont systemFontOfSize:16];
//        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
//        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    }
    return self;
}



@end
