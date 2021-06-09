//
//  ZeroSDCycleView.h
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/7.
//  Copyright © 2017年 2966497308@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZeroSDCycleViewPageContolAlimentRight,
    ZeroSDCycleViewPageContolAlimentCenter
}  ZeroSDCycleViewPageContolAliment;


typedef enum {
    ZeroSDCycleViewPageContolStyleClassic,        // 系统原点样式
    ZeroSDCycleViewPageContolStyleAnimated,    // 自己定义原点样式
    ZeroSDCycleViewPageContolStyleNone            // 不显示pagecontrol
}  ZeroSDCycleViewPageContolStyle;


@class ZeroSDCycleView;
@protocol ZeroSDCycleViewDelegate <NSObject>

@optional

/** 点击图片回调 */
- (void)cycleScrollView:(ZeroSDCycleView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)cycleScrollView:(ZeroSDCycleView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

@interface ZeroSDCycleView : UIView

/** 初始轮播图（推荐使用） */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<ZeroSDCycleViewDelegate>)delegate ;

@property (nonatomic, weak) id<ZeroSDCycleViewDelegate> delegate;
/** 本地图片数组 */
@property (nonatomic, copy) NSArray *imagePathsGroup;

/** 网络图片 url string 数组 */
@property (nonatomic, copy) NSArray *arrayStringUrl;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否无限循环,默认NO */
@property(nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认YES */
@property(nonatomic,assign) BOOL autoScroll;

/** 是否显示分页控件,默认YES */
@property (nonatomic, assign) BOOL showPageControl;

/** 外部设置当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 外部设置其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 分页控件位置 */
@property (nonatomic, assign) ZeroSDCycleViewPageContolAliment pageControlAliment;
/** pagecontrol 样式，默认为动画样式 */
@property (nonatomic, assign) ZeroSDCycleViewPageContolStyle pageControlStyle;

/** 清除图片缓存（此次升级后统一使用SDWebImage管理图片加载和缓存)*/
+ (void)clearImagesCache;
/** 清除图片缓存（兼容旧版本方法） */
- (void)clearCache;
@end
