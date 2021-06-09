//
//  ZeroBubbleView.m
//  ZeroSDCycleView
//  泡泡背景
//  Created by ZeroSmile on 2017/9/21.
//  Copyright © 2017年 陈美安. All rights reserved.
//  

#import "ZeroBubbleView.h"

@implementation ZeroBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self qipao];
    }
    return self;
}

- (void)qipao{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    
    // 生成粒子的位置
    emitter.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 60);
   // 生成粒子的区域大小
    emitter.emitterSize = CGSizeMake(self.bounds.size.width, 0);
    emitter.emitterZPosition = -1;//发射源的z坐标位置
   // 设置粒子源的形状
    emitter.emitterShape = kCAEmitterLayerLine;
    //粒子如何混合, 这里是直接重叠
    emitter.emitterMode = kCAEmitterLayerAdditive;
    emitter.preservesDepth = YES;//粒子是平展在层上
    emitter.emitterDepth = 10;//决定粒子形状的深度联系
    
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.birthRate = 2; // 每秒生成例子频率
    cell.lifetime = 20; // 粒子系统的生命周期
    cell.lifetimeRange = 5;
    cell.velocity = 30;// 粒子速度
    cell.velocityRange = 10;// 粒子速度范围
    cell.yAcceleration = -2;//粒子x方向的加速度分量
    cell.zAcceleration = -2;//粒子z方向的加速度分量
    cell. yAcceleration = -2;//粒子y方向的加速度分量
    cell.enabled = YES;
    cell.scale = 1;//粒子的缩放比例
    cell.scaleRange = 0.2;//缩放比例范围
    cell.scaleSpeed = 0.1;//缩放比例速度
    cell.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"bubble"] CGImage]);
    emitter.emitterCells = @[cell];//emitterCells: 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；
   [self.layer addSublayer:emitter];
}

@end
