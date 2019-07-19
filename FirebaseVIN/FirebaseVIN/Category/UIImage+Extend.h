//
//  UIImage+Extend.h
//  FirebaseVIN
//
//  Created by 陈美安 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extend)

/**
 @ 获取视频流转换成图片,
 @imageBuffer 视频流数据
 @ UIImage 转换成返回的1080X1920的高清大图
 */
+ (UIImage *)getImageCVPixelBuffer:(CVPixelBufferRef)imageBuffer;

/**
 @ 将图片剪切成指定大小的图片
 @image 将要剪切的原图
 @options 剪切的参数 X,Y坐标和宽高
 @ UIImage 转换成返回的指定大小的图片
 */
+(UIImage*)cutImageBuffer:(UIImage*)image cutWithOptions:(NSDictionary*)options;

@end

NS_ASSUME_NONNULL_END
