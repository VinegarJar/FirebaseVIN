//
//  VINCapturePreView.h
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/22.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMacros.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CaptureStyleType){
    
       CaptureStyleSup,
       CaptureStyleSer,
};


@class VINCapturePreView;

@protocol CapturePreDelegate <NSObject>

@optional

/**@brief 开关手电筒*/
- (void)openFlashlight:(VINCapturePreView*)flashlight;

/**@brief 返回或者关闭当前页面*/
- (void)dismissViewController:(VINCapturePreView*)controller;

@end

@interface VINCapturePreView : UIView

+ (instancetype)vinCapturePreviewWithFrame:(CGRect)frame delegate:(id<CapturePreDelegate>)delegate;
@property (nonatomic, weak) id<CapturePreDelegate> delegate;
@property (nonatomic, assign) CaptureStyleType styleType;
@end

NS_ASSUME_NONNULL_END
