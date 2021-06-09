//
//  ZeroLineView.m
//  ZeroSDCycleView
// 横排线
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import "ZeroLineView.h"


@interface ZeroLineView ()
@property (nonatomic, strong) UIImageView *imageView_1;
@property (nonatomic, strong) UIImageView *imageView_2;
@property (nonatomic, strong) UIImageView *imageView_3;

@property (nonatomic, assign) CGFloat width;
 @property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat imageLine_width;
@property (nonatomic, assign) CGFloat imageLine_height;
@property (nonatomic, assign) ZeroLineAnimation lineType;
@end


@implementation  ZeroLineView

- (instancetype)initWithFrame:(CGRect)frame lineType:(ZeroLineAnimation)lineType {
    self = [super initWithFrame:frame];
    if (self) {
        self.width = frame.size.width;
        self.height = frame.size.height;
        self.imageLine_width = frame.size.width*0.7;
        self.imageLine_height = 2;
        self.lineType = lineType;
        self.clipsToBounds = YES;
        [self createImageView];
    }
    return self;
}


- (void)createImageView{
    
    _imageView_1 = [self createImageViewWithFrame:CGRectMake(_width*0.15, 0, _imageLine_width,_imageLine_height)
                                        imageName:_lineType == 1 ? @"上1" : @"下1"];
    _imageView_2 = [self createImageViewWithFrame:CGRectMake(_width*0.05, 0.46*_height, _imageLine_width,_imageLine_height)
                                        imageName:_lineType == 1 ? @"上2" : @"下2"];
    _imageView_3 = [self createImageViewWithFrame:CGRectMake(_width*0.18, _height -_imageLine_height, _imageLine_width, _imageLine_height)
                                        imageName:_lineType == 1 ? @"上3" : @"下3"];
    
    [self addSubview:_imageView_1];
    [self addSubview:_imageView_2];
    [self addSubview:_imageView_3];
    
    if (_lineType == 0)
    {
        [self rightMoveAnimation];
    }
}


- (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

- (void)startLeftAnimation
{
    CGFloat duration = 1;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation1.keyTimes = @[@0,@1];
    animation1.values = @[@(0),@(-2*_width)];
    animation1.repeatCount = 1;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    animation1.duration = duration;
    [_imageView_1.layer addAnimation:animation1 forKey:nil];
    
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation2.keyTimes = @[@0,@1];
    animation2.values = @[@(0),@(-2*_width)];
    animation2.repeatCount = 1;
    animation2.removedOnCompletion = NO;
    animation2.beginTime = CACurrentMediaTime() + 0.1;
    animation2.fillMode = kCAFillModeForwards;
    animation2.duration = duration;
    [_imageView_2.layer addAnimation:animation2 forKey:nil];
    
    
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation3.keyTimes = @[@0,@1];
    animation3.values = @[@(0),@(-2*_width)];
    animation3.repeatCount = 1;
    animation3.removedOnCompletion = NO;
    animation3.duration = duration;
    animation3.fillMode = kCAFillModeForwards;
    animation3.beginTime = CACurrentMediaTime() + 0.2;
    [_imageView_3.layer addAnimation:animation3 forKey:nil];
}

- (void)rightMoveAnimation
{
    CGFloat duration = 1.6;
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation1.keyTimes = @[@0,
                            @0.5,
                            @0.52,
                            @0.54,
                            @1];
    animation1.values = @[@(-1*_width),
                          @(0.05*_width),
                          @(0.04*_width),
                          @(0.05*_width),
                          @(0.05*_width)];
    animation1.repeatCount = 1;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    animation1.duration = duration;
    [_imageView_1.layer addAnimation:animation1 forKey:nil];
    
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation2.keyTimes = @[@0,
                            @0.1,
                            @0.6,
                            @0.62,
                            @0.64,
                            @1];
    animation2.values = @[@(-1*_width),
                          @(-1*_width),
                          @(0.05*_width),
                          @(0.04*_width),
                          @(0.05*_width),
                          @(0.05*_width)];
    animation2.repeatCount = 1;
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    animation2.duration = duration;
    [_imageView_2.layer addAnimation:animation2 forKey:nil];
    
    
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation3.keyTimes = @[@0,
                            @0.2,
                            @0.72,
                            @0.74,
                            @0.76,
                            @1];
    animation3.values = @[@(-1*_width),
                          @(-1*_width),
                          @(0.05*_width),
                          @(0.04*_width),
                          @(0.05*_width),
                          @(0.05*_width)];
    animation3.repeatCount = 1;
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    animation3.duration = duration;
    [_imageView_3.layer addAnimation:animation3 forKey:nil];
}


@end
