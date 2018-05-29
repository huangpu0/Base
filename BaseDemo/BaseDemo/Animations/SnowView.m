//
//  SnowView.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/21.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "SnowView.h"

@implementation SnowView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSnowAnimation];
    }
    return self;
}
#pragma mark -- 添加相关雪花动画
- (void)addSnowAnimation{
    //添加背景图
//    UIImageView *snowBgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snow_bg"]];
//    [self addSubview:snowBgImage];
    
    //粒子图层
    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
    snowLayer.backgroundColor = [UIColor redColor].CGColor;
    //发射器位置
    snowLayer.emitterPosition = CGPointMake(0, 0);
    //发射源的尺寸
    snowLayer.emitterSize = CGSizeMake(640, 1);
    //发射源的形状
    snowLayer.emitterShape = kCAEmitterLayerLine;
    //发射器模式
    snowLayer.emitterMode = kCAEmitterLayerOutline;
    //创建雪花粒子
    CAEmitterCell *snowFlake = [CAEmitterCell emitterCell];
    //粒子的名称
    snowFlake.name = @"snow";
    //粒子参数的速度乘数因子。越大出现的越快
    snowFlake.birthRate = 1.0;
    //存活的时间
    snowFlake.lifetime = 120.0f;
    //粒子速度
    snowFlake.velocity = - 10.0;
    //粒子速度范围
    snowFlake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowFlake.yAcceleration = 2;
    //周围发射的角度
    snowFlake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowFlake.spinRange = 0.25 * M_PI;
    //粒子图片
    snowFlake.contents = (id) [[UIImage imageNamed:@"snow"] CGImage];
    //粒子颜色
    snowFlake.color = [[UIColor whiteColor] CGColor];
    
    //设置阴影
    snowLayer.shadowOpacity = 1.0;
    snowLayer.shadowRadius  = 0.0;
    snowLayer.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowLayer.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // 将粒子添加到粒子发射器上
    snowLayer.emitterCells = [NSArray arrayWithObject:snowFlake];
    [self.layer insertSublayer:snowLayer atIndex:0];
    
}
@end
