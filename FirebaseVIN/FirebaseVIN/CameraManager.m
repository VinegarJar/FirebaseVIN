//
//  CameraManager.m
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/20.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "CameraManager.h"
#import "GlobalMacros.h"

@interface CameraManager () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) BOOL isInProcessing;
@property (nonatomic, assign) BOOL isHasResult;

@end


@implementation CameraManager





- (void)resetParams {

    if ([self.captureSession canAddOutput:self.dataOutput]) {
        [self.captureSession addOutput:self.dataOutput];
        DEBUG_NSLog(@"captureSession addOutput");
    }
}


- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = self.sessionPreset;
        [self.captureSession beginConfiguration];
    }
    return _captureSession;
}


- (AVCaptureVideoDataOutput *)dataOutput {
    if (!_dataOutput) {
        _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
        NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
        NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
        NSDictionary* videoSettings = [NSDictionary
                                       dictionaryWithObject:value forKey:key];
         [_dataOutput setVideoSettings:videoSettings];
    }
    return _dataOutput;
}


- (NSString *)sessionPreset {
    if (!_sessionPreset) {
        _sessionPreset = AVCaptureSessionPresetHigh;
    }
    return _sessionPreset;
}


- (BOOL)setupSession{
    
     dispatch_queue_t queue = dispatch_queue_create("cameraQueue", NULL);
    
     NSError *error;
     //deviceInput  输入流
     self.deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self device] error:&error];
    if ( self.deviceInput) {
        if ([self.captureSession canAddInput: self.deviceInput]) {
             [self.captureSession addInput: self.deviceInput];
        }
    }
    else {
        return NO;
    }
    
    //dataOutput   输出流
    [self.dataOutput setSampleBufferDelegate:self queue:queue];
    if ([self.captureSession canAddOutput:self.dataOutput]) {
        [self.captureSession addOutput:self.dataOutput];
    }
    else {
        return NO;
    }
    
    [self.captureSession commitConfiguration];
    return YES;
}




- (void)startSession {
    if (![self.captureSession isRunning]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.captureSession startRunning];
        });
    }
}


- (void)stopSession {
    if ([self.captureSession isRunning]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.captureSession stopRunning];
        });
    }
}


- (AVCaptureDevice *)device {
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //指定使用后置摄像头
        _device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        NSError *error = nil;
        if ([_device lockForConfiguration:&error]) {
            if ([_device isSmoothAutoFocusSupported]) {// 平滑对焦
                _device.smoothAutoFocusEnabled = YES;
            }
            if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {// 自动持续对焦
                _device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            }
            if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure ]) {// 自动持续曝光
                _device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
            }
            if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {// 自动持续白平衡
                _device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
            }
            [_device unlockForConfiguration];
        }
    }
    return _device;
}


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}


/**@brief  处理视频回调数据代理*/
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

     CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if ([self.outputBufferDelegate respondsToSelector:@selector(didOutputResult:sampleBuffer:)]&&self.outputBufferDelegate) {
        [self.outputBufferDelegate didOutputResult:self sampleBuffer:(__bridge id)(imageBuffer)];
    }
}




@end
