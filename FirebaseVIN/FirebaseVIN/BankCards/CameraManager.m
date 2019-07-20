//
//  CameraManager.m
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/20.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "CameraManager.h"

@implementation CameraManager



- (NSString *)sessionPreset {
    if (!_sessionPreset) {
        _sessionPreset = AVCaptureSessionPresetHigh;
    }
    return _sessionPreset;
}

@end
