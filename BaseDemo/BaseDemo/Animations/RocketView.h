//
//  RocketView.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/12.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RocketView : UIView

@property (nullable, nonatomic, copy) NSArray *curveControlAndEndPoints;

+ (nullable instancetype)loadRocketViewWithPoint:(CGPoint)point;

- (void)addAnimationsMoveToPoint:(CGPoint)movePoints endPoint:(CGPoint)endPoint;

@end
