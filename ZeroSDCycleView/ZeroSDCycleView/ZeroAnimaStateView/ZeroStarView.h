//
//  ZeroStarView.h
//  ZeroSDCycleView
//  
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
  1-星星   2-圆圈
 */
typedef NS_ENUM(NSInteger, ZeroStarAnimation) {
    ZeroStarTypeStar = 1,
    ZeroStarTypeRound ,
};

@interface ZeroStarView : UIView
/**
 旋转放大星星 (大星星的动画)
 */
- (instancetype)initWithFrameMaxStrat:(CGRect)frame;


/**
 星星和圆圈的缩放动画
 */
- (instancetype)initWithFrame:(CGRect)frame type:(ZeroStarAnimation)type;

/**
 开始动画
 */
- (void)startAnimation;
@end
