//
//  SportsCarView.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/11.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsCarView : UIView

@property (nonatomic, strong, nullable) NSMutableArray *carArr;

@property (nonatomic, copy  , nullable) NSArray *curveControlAndEndPoints;

+ (nullable instancetype)loadCarViewWithPoint:(CGPoint)point;

- (void)addAnimationsMoveToPoint:(CGPoint)movePoints endPoint:(CGPoint)endPoint;


@end
