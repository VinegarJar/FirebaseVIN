//
//  ZeroSDCAlertView.h
//  planGodDelgate
// 
//  Created by ZeroSmile on 2017/9/19.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import " ZeroSDCHeader.h"



typedef NS_ENUM(NSInteger,  ZeroSDCAlertAnimation) {
     ZeroSDCAlertAnimationTypeDefault,
     ZeroSDCAlertAnimationTypeCenter,
     ZeroSDCAlertAnimationTypeLine,
};


@class ZeroSDCAlertView;
@protocol ZeroSDCAlertDelegate <NSObject>

@optional
- (void)didSelectToIndex:(ZeroSDCAlertView *)didSelectToIndex
         toIndex:(NSInteger)index;
@end




@interface ZeroSDCAlertView : UIView
/** 初始话（推荐使用） */
+ (instancetype)zeroSDCAlertViewWithFrame:(CGRect)frame delegate:(id<ZeroSDCAlertDelegate>)delegate;
@property (nonatomic, weak) id<ZeroSDCAlertDelegate> delegate;
/*动画效果类型,默认为Defaul*/
@property(nonatomic,assign) ZeroSDCAlertAnimation  animationType;
/*开启动画*/
-(void)showWithController:(UIViewController *)viewController;
/*关闭动画*/
-(void)disMiss;


@end
