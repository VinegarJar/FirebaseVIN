//
//  ZeroRainbowView.h
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ZeroRainbowAnimation) {
    ZeroRainbowTypeDefault = 1,
    ZeroRainbowTypeOther ,
};

@interface ZeroRainbowView : UIView
@property (nonatomic, assign)ZeroRainbowAnimation type;
- (instancetype)initWithFrame:(CGRect)frame type:(ZeroRainbowAnimation)type;
@end
