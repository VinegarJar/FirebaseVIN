//
//  ZeroFireworkView.h
//  ZeroSDCycleView
//  
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 1-粗线   2-细线  3-右上角三条线
 */
typedef NS_ENUM(NSInteger, ZeroFireworkAnimation) {
    ZeroFireworkTypeVulgarLine = 1,
    ZeroFireworkTypeFineLine ,
    ZeroFireworkTypeMisumiLine ,
};

@interface ZeroFireworkView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(ZeroFireworkAnimation)type;


/**
 开始动画
 */
- (void)startAnimation;
@end
