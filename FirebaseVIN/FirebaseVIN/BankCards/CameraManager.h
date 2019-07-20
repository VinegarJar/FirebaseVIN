//
//  CameraManager.h
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/20.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface CameraManager : NSObject

/** 捕捉会话,执行输入设备和输出设备之间的数据传递*/
@property (nonatomic, strong) AVCaptureSession *captureSession;

/** 用于从AVCaptureDevice对象捕获数据,是输入流数据*/
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;

/** 视频流数据输出*/
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;

/** 捕捉预览,用来预览画面*/
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

/** 图片质量大小,输出照片铺满屏幕*/
@property (nonatomic, copy) NSString *sessionPreset;

/** 摄像头设备*/
@property (nonatomic,strong) AVCaptureDevice *device;

@end


