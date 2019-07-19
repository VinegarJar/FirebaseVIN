//
//  UIImage+Extend.m
//  FirebaseVIN
//
//  Created by 陈美安 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)
+ (UIImage *)getImageCVPixelBuffer:(CVPixelBufferRef)imageBuffer{
    
     //图片的原始宽度和高度
    CGFloat previewWidth = CVPixelBufferGetWidth(imageBuffer);
    CGFloat previewHeight = CVPixelBufferGetHeight(imageBuffer);
    
     //CVPixelBufferRef  CIImage 转换
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:imageBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    
    CGImageRef videoImage = [temporaryContext
                             createCGImage:ciImage
                             fromRect:CGRectMake(0, 0,previewWidth,previewHeight)];
    //CGImageRef  Image 转换
    UIImage *image = [UIImage imageWithCGImage:videoImage  scale:1.0f orientation:UIImageOrientationRight];
    
    //可以在此处保存到系统相册查看下是否为转换成功  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

    CGImageRelease(videoImage);
    return image;
}


+(UIImage*)cutImageBuffer:(UIImage*)image cutWithOptions:(NSDictionary*)options{
    
    //图片的原始宽度和高度(取值竖屏照片)
    CGFloat   fixelW = CGImageGetWidth(image.CGImage);
    CGFloat   fixelH = CGImageGetHeight(image.CGImage);
    
    //设备的宽高
    CGFloat   deviceWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat   deviceHeight = [UIScreen mainScreen].bounds.size.height;
    
    //需要剪切图片的位置参数
    CGFloat   deviceX = [[options objectForKey:@"x"] floatValue];
    CGFloat   deviceY = [[options objectForKey:@"y"] floatValue];
    CGFloat   imgeWidth = [[options objectForKey:@"width"] floatValue];
    CGFloat   imgeHeight = [[options objectForKey:@"height"] floatValue];
    
    //比例参数率
    double   measureW = (fixelW/deviceWidth );
    double   measureH = (fixelH/deviceHeight );
    
    
    CGFloat    height = imgeHeight*measureH;
    CGFloat    width  = imgeWidth*measureW;
    CGFloat   ponitX = deviceX;
    CGFloat   ponitY = deviceY*measureH*2;
    
    // Image 通过CGImageRef进行剪切操作
    CGRect  cutRect = CGRectMake(ponitX ,ponitY, width, height);
    CGImageRef  imageRef = CGImageCreateWithImageInRect([image fixOrientation].CGImage, cutRect);
    UIGraphicsBeginImageContext(cutRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, imageRef);
    
    //UIImageOrientationUp 需要设置向上的图片方向
    UIImage * clipImage = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    CFRelease(imageRef);
    return clipImage;
}



//设置图片方向旋转UIImageOrientationUp
- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
