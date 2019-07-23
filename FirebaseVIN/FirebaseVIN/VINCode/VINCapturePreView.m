//
//  VINCapturePreView.m
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/22.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "VINCapturePreView.h"
#import "UIView+ViewController.h"

@interface VINCapturePreView ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong)UIView *navBar;
@property (nonatomic, strong)UIButton*goBack;
@property (nonatomic, strong)UIView *tabBar;
@property (nonatomic, strong)UIButton*flashlight;
@property (nonatomic, strong)UIButton*camera;
@property (nonatomic, strong)UIButton*album;

@property (nonatomic, assign) CGFloat m_width; //扫描框宽度
@property (nonatomic, assign) CGFloat m_higth; //扫描框高度
@end



@implementation VINCapturePreView

+ (instancetype)vinCapturePreviewWithFrame:(CGRect)frame delegate:(id<CapturePreDelegate>)delegate{
    VINCapturePreView *preview = [[self alloc] initWithFrame:frame];
    preview.delegate = delegate;
    return preview;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _styleType = CaptureStyleSup;
        [self initializeUI];

        self.m_width = (SCREEN_WIDTH - 40);
        self.m_higth = 80.0;
    }
    return self;
}


-(void)setStyleType:(CaptureStyleType)styleType{
     _styleType = styleType;
}



- (void)initializeUI{
     [self tipLabel];
     [self navBar];
     [self tabBar];
     [self goBack];
     [self tabBar];
     [self flashlight];
     [self camera];
     [self album];
}

- (void)initializeShapeLayer{
    
    //中间空心洞的区域
    CGRect cutRect = CGRectMake((SCREEN_WIDTH - _m_width)/2.0,150.0, _m_width, _m_higth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    
    // 挖空心洞 显示区域
    UIBezierPath *cutRectPath = [UIBezierPath bezierPathWithRect:cutRect];
    
    //将circlePath添加到path上
    [path appendPath:cutRectPath];
    path.usesEvenOddFillRule = YES;
    
    //显示遮罩层
    CAShapeLayer*fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.opacity = 0.6;//透明度
    fillLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:fillLayer];
    
    
    // 边界校准线
    CGFloat lineWidth = 2;
    CGFloat lineLength = 20;
    UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x - lineWidth,
                                                                         cutRect.origin.y - lineWidth,
                                                                         lineLength,
                                                                         lineWidth)];
    //追加路径
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x - lineWidth,
                                                                     cutRect.origin.y - lineWidth,
                                                                     lineWidth,
                                                                     lineLength)]];
    
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x + cutRect.size.width - lineLength + lineWidth,
                                                                     cutRect.origin.y - lineWidth,
                                                                     lineLength,
                                                                     lineWidth)]];
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x + cutRect.size.width ,
                                                                     cutRect.origin.y - lineWidth,
                                                                     lineWidth,
                                                                     lineLength)]];
    
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x - lineWidth,
                                                                     cutRect.origin.y + cutRect.size.height - lineLength + lineWidth,
                                                                     lineWidth,
                                                                     lineLength)]];
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x - lineWidth,
                                                                     cutRect.origin.y + cutRect.size.height,
                                                                     lineLength,
                                                                     lineWidth)]];
    
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x + cutRect.size.width,
                                                                     cutRect.origin.y + cutRect.size.height - lineLength + lineWidth,
                                                                     lineWidth,
                                                                     lineLength)]];
    [linePath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(cutRect.origin.x + cutRect.size.width - lineLength + lineWidth,
                                                                     cutRect.origin.y + cutRect.size.height,
                                                                     lineLength,
                                                                     lineWidth)]];
    
    CAShapeLayer*pathLayer = [CAShapeLayer layer];
    pathLayer.path = linePath.CGPath;// 从贝塞尔曲线获取到形状
    if (_styleType==CaptureStyleSup) {
        pathLayer.fillColor = UIColorFromRGB(UISupScanColor).CGColor;
    }else{
       pathLayer.fillColor = UIColorFromRGB(UISerScanColor).CGColor;
    }
    [self.layer addSublayer:pathLayer];
}



//自定义导航
-(UIView*)navBar{
    if (!_navBar) {
        _navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        [self addSubview:_navBar];
    }
    return _navBar;
}

//自定义导航返回
-(UIButton*)goBack{
    if (!_goBack) {
        _goBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBack.frame = CGRectMake(15, 5, 100, 60);
        _goBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIImage *theImage = [[UIImage imageNamed:@"goBack.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _goBack .tintColor = [UIColor whiteColor];
        [_goBack setImage:theImage forState:UIControlStateNormal];
        [_goBack addTarget:self action:@selector(clickedBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navBar addSubview:_goBack];
    }
    return _goBack;
}

//自定义导航title
-(UILabel*)tipLabel{
    if (!_tipLabel ) {
        _tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 88, 150, 60)];
        [_tipLabel setFont:    [UIFont systemFontOfSize:17.0f]];
        [_tipLabel  setText:@"对准目标扫描识别"];
        [_tipLabel  setTextColor:[UIColor whiteColor]];
        [_tipLabel  setTextAlignment: NSTextAlignmentCenter];
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}



//自定义底部导航
-(UIView*)tabBar{
    if (!_tabBar) {
        _tabBar = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-135, SCREEN_WIDTH, 135)];
        [_tabBar setBackgroundColor:UIColorFromRGB(0x000000)];
        _tabBar.alpha = 0.8;//透明度
        [self addSubview:_tabBar];
    }
    return _tabBar;
}


//自定义底部导航闪光灯按钮
-(UIButton*)flashlight{
    if (!_flashlight) {
        _flashlight = [UIButton buttonWithType:UIButtonTypeCustom];
        _flashlight.frame = CGRectMake(SCREEN_WIDTH-88, 0, 88, 135);
        _flashlight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_flashlight setImage:[UIImage imageNamed:@"light-close"] forState:UIControlStateNormal];
        [_flashlight setImage:[UIImage imageNamed:@"light-open"] forState:  UIControlStateSelected];
        [_flashlight addTarget:self action:@selector(flashlightClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:_flashlight];
    }
    return _flashlight;
}


//自定义底部导航相册按钮
-(UIButton*)album{
    if (!_album) {
        _album = [UIButton buttonWithType:UIButtonTypeCustom];
        _album.frame = CGRectMake(0, 0, 88, 135);
        _album.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_album setImage:[UIImage imageNamed:@"vin-picture"] forState:UIControlStateNormal];
        [_album addTarget:self action:@selector(albumClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:_album];
    }
    return _album;
}


//自定义底部导航相机按钮
-(UIButton*)camera{
    if (!_camera) {
        _camera = [UIButton buttonWithType:UIButtonTypeCustom];
        _camera.frame = CGRectMake((SCREEN_WIDTH-88)/2, 0, 88, 135);
       _camera.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if (_styleType==CaptureStyleSup) {
            [_camera setImage:[UIImage imageNamed:@"vin-photo-gys"] forState:UIControlStateNormal];
        }else{
             [_camera setImage:[UIImage imageNamed:@"vin-photo"] forState:UIControlStateNormal];
        }
        [_camera.imageView setContentMode:UIViewContentModeCenter];
        [_camera addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:_camera];
    }
    return _camera;
}



#pragma mark-点击事件处理
-(void)flashlightClick:(UIButton *)sender{
    if (!sender.isSelected) {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
}


-(void)albumClick:(UIButton *)sender{
    
}


-(void)cameraClick:(UIButton *)sender{
    
}


-(void)clickedBackBtn:(UIButton *)sender{
       [self.viewController  dismissViewControllerAnimated:YES completion:nil];
}




@end
