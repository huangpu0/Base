//
//  LiveAnimationViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/16.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "LiveAnimationViewController.h"
#import "FireworksView.h"
#import "SportsCarView.h"
#import "PlaneView.h"
#import "RocketView.h"
#import "DiamondView.h"
#import "SnowView.h"
@interface LiveAnimationViewController ()

@end

@implementation LiveAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setNavigationWithTitle:@"动画效果" leftBtnWithTitle:nil];
    
    [self touchAnimation:self.tag];
}

- (void)touchAnimation:(NSInteger)tag;{
    switch (tag) {
        case 0:{
            //烟花
            FireworksView *fire = [[FireworksView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:fire];
        }
            break;
        case 1:
            //法拉利
        {
            SportsCarView *car = [SportsCarView loadCarViewWithPoint:CGPointZero];
            NSMutableArray *pointArrs = [[NSMutableArray alloc] init];
            CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
            [pointArrs addObject:NSStringFromCGRect(CGRectMake(width, 300, width, 300))];
            car.curveControlAndEndPoints = pointArrs;
            
            [car addAnimationsMoveToPoint:CGPointMake(self.view.bounds.size.width, 300) endPoint:CGPointMake(-166, 0)];
            [self.view addSubview:car];
            
        }
            break;
        case 2:
            //客机
        {
            PlaneView *plane = [PlaneView loadPlaneViewWithPoint:CGPointMake(kScreen_Width + 232, 0)];
            
            [plane addAnimationsMoveToPoint:CGPointMake(kScreen_Width, 100) endPoint:CGPointMake(-500, 410)];
            [self.view addSubview:plane];
            
        }
            break;
        case 3:
            //火箭
        {
            RocketView *rocket = [RocketView loadRocketViewWithPoint:CGPointMake(kScreen_Width/2, kScreen_Height + 150)];
            [rocket addAnimationsMoveToPoint:CGPointMake(self.view.centerX + 20, kScreen_Height + 150) endPoint:CGPointMake(self.view.centerX + 20, -150)];
            [self.view addSubview:rocket];
            
        }
            break;
        case 4:
            //钻石
        {
            DiamondView *diaView = [[DiamondView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:diaView];

            
        }
            break;
        case 5:
            //雪花
        {
            SnowView *snowView = [[SnowView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:snowView];
        }
            break;

        
        default:
           
            break;
    }
}

@end
