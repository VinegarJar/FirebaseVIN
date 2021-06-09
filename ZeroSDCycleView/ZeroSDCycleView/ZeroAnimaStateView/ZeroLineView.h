//
//  ZeroLineView.h
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//  

#import <UIKit/UIKit.h>

/**
 线条效果,默认向右边移动
 */
typedef NS_ENUM(NSInteger, ZeroLineAnimation) {
     ZeroLineTypeAlimentRigh,
     ZeroLineTypeAlimentLeft,
};




@interface ZeroLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame lineType:(ZeroLineAnimation)lineType;

/**
 开始左移的动画
 */
- (void)startLeftAnimation;

@end
