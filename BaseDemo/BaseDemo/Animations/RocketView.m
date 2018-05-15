//
//  RocketView.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/12.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "RocketView.h"

@interface RocketView ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *rocketImage;

@property (weak, nonatomic) IBOutlet UIImageView *rocketFireImage;


@property (nonatomic, copy) NSMutableArray *animations;

@end

@implementation RocketView

+ (instancetype)loadRocketViewWithPoint:(CGPoint)point{
    RocketView *rocket = [[NSBundle mainBundle]loadNibNamed:@"RocketView" owner:self options:nil].lastObject;
    rocket.frame = CGRectMake(point.x, point.y, 60,150);
    [rocket setPlaneScrewImages:nil];
    return rocket;
}

- (void)addAnimationsMoveToPoint:(CGPoint)movePoints endPoint:(CGPoint)endPoint{
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, movePoints.x, movePoints.y);
    
    CGPathAddQuadCurveToPoint(path, NULL, endPoint.x, endPoint.y, endPoint.x, endPoint.y);
    position.path = path;
    position.duration = 3.f;
    position.speed = 0.6;
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    position.calculationMode = kCAAnimationCubicPaced;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 5.0f;
    animationGroup.delegate = self;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = 0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[scaleAnimation,position];
    [self.layer addAnimation:animationGroup forKey:@"rocketViews"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)setPlaneScrewImages:(NSArray *)imageArray{
    NSMutableArray* images = [NSMutableArray array];
    for(int i = 1;i<7;i++){
        [images addObject: [UIImage imageNamed:[NSString stringWithFormat:@"rocket-fire-%d",i]]];
    }
    _rocketFireImage.animationImages = images;
    _rocketFireImage.animationDuration = 0.05;
    _rocketFireImage.animationRepeatCount = 0;
    [_rocketFireImage startAnimating];
}

- (NSMutableArray *)animations{
    if (_animations == nil) {
        _animations = [[NSMutableArray alloc]init];
    }
    return _animations;
}



@end
