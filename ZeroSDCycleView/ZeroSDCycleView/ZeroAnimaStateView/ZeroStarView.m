//
//  ZeroStarView.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import "ZeroStarView.h"

@interface ZeroStarView ()
// 1-星星   2-圆圈
@property (nonatomic, assign) ZeroStarAnimation type;
@end

@implementation ZeroStarView

- (instancetype)initWithFrame:(CGRect)frame type:( ZeroStarAnimation)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:self.type == 1 ? @"Slice_0_180" : @"Slice_0_168"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)startAnimation{
    // 放大缩小
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.6;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.fromValue = [NSNumber numberWithFloat:0.1];
    animation.toValue = [NSNumber numberWithFloat:1];
    [self.layer addAnimation:animation forKey:nil];
}

#pragma mark - 旋转放大的动画 (大星星的动画)

- (instancetype)initWithFrameMaxStrat:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMaxStartAnimation];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = 0;
        animation.toValue = [NSNumber numberWithFloat:2*M_PI];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 1;
        
        
        CAKeyframeAnimation *kayAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        kayAnimation.keyTimes = @[@0,@0.6,@0.8,@1];
        kayAnimation.values = @[@0,@1.2,@0.85,@1];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[animation,kayAnimation];
        group.duration = 1.5;
        
        [self.layer addAnimation:group forKey:nil];
        
    }
    return self;
}

- (void)createMaxStartAnimation
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"Group"];
    [self addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 5;
    animation.fromValue = 0;
    animation.beginTime = CACurrentMediaTime() + 1.5;
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    animation.autoreverses = NO;
    animation.repeatCount = HUGE_VALF;
    [imageView.layer addAnimation:animation forKey:nil];
}


@end
