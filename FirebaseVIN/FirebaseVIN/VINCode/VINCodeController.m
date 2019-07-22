//
//  VINCodeController.m
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/22.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "VINCodeController.h"
#import "Firebase.h"
#import "CameraManager.h"
#import "VINCapturePreView.h"


@interface VINCodeController ()<CapturePreDelegate,CameraOutputSampleBufferDelegate>
// 是否打开手电筒
@property (nonatomic,assign,getter = isTorchOn) BOOL torchOn;
@property (nonatomic, strong) CameraManager *manager;
@property (nonatomic, strong) VINCapturePreView *overlayView;
@end

@implementation VINCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![self.manager.captureSession isRunning]) {
        [self.manager startSession];
        [self.manager resetParams];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if ([self.manager.captureSession isRunning]) {
        [self.manager stopSession];
    }
}


-(CameraManager *)manager{
    if (!_manager) {
        _manager = [[CameraManager alloc] init];
    }
    return _manager;
}


-(VINCapturePreView *)overlayView{
    if (!_overlayView) {
        _overlayView = [VINCapturePreView vinCapturePreviewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) delegate:self];        
    }
    return _overlayView;
}
@end
