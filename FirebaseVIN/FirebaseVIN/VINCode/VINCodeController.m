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
#import "GlobalMacros.h"
#import "UIImage+Extend.h"

@interface VINCodeController ()<CapturePreDelegate,CameraOutputSampleBufferDelegate>
// 是否打开手电筒
@property (nonatomic,assign,getter = isTorchOn) BOOL torchOn;
@property (nonatomic, strong) CameraManager *manager;
@property (nonatomic, strong) VINCapturePreView *overlayView;
@property (nonatomic,assign) BOOL isFocus;
@property (nonatomic,assign) BOOL isInference;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong) FIRVisionTextRecognizer *textRecognizer;

@end

@implementation VINCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化识别器
    FIRVision *vision = [FIRVision vision];
    //这里仅仅使用离线识别功能。‼️如果要想使用在线识别，请到Firebase官网注册APP，并购买相关服务‼️
    _textRecognizer = [vision onDeviceTextRecognizer];
    
    
    
     [self.view insertSubview:self.overlayView atIndex:0];
    if ([self.manager setupSession]) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:view atIndex:0];
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.manager.captureSession];
        layer.frame = [[UIScreen mainScreen] bounds];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [view.layer addSublayer:layer];
        [self.manager startSession];
    }
    
    //扫描结果label
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - 100)/2.0, SCREEN_WIDTH, 100)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.numberOfLines = 0;
    
    _textLabel.font = [UIFont systemFontOfSize:19];
    
    _textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_textLabel];
    
    
    

    [ self.manager.device addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil];
    
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
    
    [ self.manager.device  removeObserver:self forKeyPath:@"adjustingFocus" context:nil];
}


-(CameraManager *)manager{
    if (!_manager) {
        _manager = [[CameraManager alloc] init];
        _manager.outputBufferDelegate = self;
    }
    return _manager;
}


-(VINCapturePreView *)overlayView{
    if (!_overlayView) {
        _overlayView = [VINCapturePreView vinCapturePreviewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) delegate:self];
        [_overlayView initializeShapeLayer];
    }
    return _overlayView;
}


-(void)didOutputResult:(CameraManager *)result sampleBuffer:(id)sampleBuffer{
    
    if (!_isFocus && !_isInference) {
        _isInference = YES;
        
        
        UIImage *subImg =  [UIImage getImageCVPixelBuffer:(__bridge CVPixelBufferRef _Nonnull)(sampleBuffer)];
        UIImage*cutImg = [UIImage cutImageBuffer:subImg cutWithOptions:@{@"x":@0,@"y":@150,@"width":@SCREEN_WIDTH,@"height":@100 }];
        
        FIRVisionImage *image = [[FIRVisionImage alloc] initWithImage:cutImg];
        
        //开始识别
        [_textRecognizer processImage:image
                          completion:^(FIRVisionText *_Nullable result,
                                       NSError *_Nullable error) {
                              if (error == nil && result != nil) {
                                  
                                  NSString *replacingText = [self getElementText:result];
                                  DEBUG_NSLog(@"replacingText结果=%@",replacingText);
                                  //过滤VIN识别规则字母o转为数字0
                                  NSString *upperText = [replacingText stringByReplacingOccurrencesOfString:@"O" withString:@"0"];
                                  //英文字母小写全部转换为大写字母
                                  NSString *elementText = [upperText uppercaseString];
                                  //识别17位的VIN码
                                  if (elementText.length == 17) {
                                      //连续两次识别结果一致，则输出最终结果
                                      //                                     if ([self->recognizedText isEqualToString:elementText]) {
                                      //停止扫描
                                     [self.manager stopSession];
                                      
                                      //播放音效
                                      NSURL *url=[[NSBundle mainBundle]URLForResource:@"scanSuccess.wav" withExtension:nil];
                                      SystemSoundID soundID=8787;
                                      AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
                                      AudioServicesPlaySystemSound(soundID);
                                      
                                      //在屏幕上输入结果
                                      self->_textLabel.text = elementText;
                                      //                                          DEBUG_NSLog(@"%@",self->recognizedText);
                                      //                                     }else{
                                      //                                         //马上再识别一次，对比结果对比
                                      //                                         self->recognizedText = elementText;
                                      //                                         self->isInference = NO;
                                      //                                     }
                                      return;
                                  }
                                  
                              }
                              //延迟100毫秒再继续识别,降低CPU功耗，省电‼️
                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                                  self->_isInference = NO;
                              });
                              
                          }];
        
    }

    
}


-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    //指示接收器是否被中断。可以使用KVO来观察这个属性的值。
    if([keyPath isEqualToString:@"adjustingFocus"]){
        BOOL adjustingFocus =[[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1]];
        _isFocus = adjustingFocus;
        DEBUG_NSLog(@"Is adjusting focus? %@", adjustingFocus ?@"YES":@"NO");
    }
}

-(NSString*)getElementText:(FIRVisionText *_Nullable )result{
    
    NSString *elementText = @"";
    for (FIRVisionTextBlock *block in result.blocks) {
        for (FIRVisionTextLine *line in block.lines) {
            for (FIRVisionTextElement *element in line.elements) {
                elementText = element.text;
            }
        }
    }
    return elementText;
}

@end
