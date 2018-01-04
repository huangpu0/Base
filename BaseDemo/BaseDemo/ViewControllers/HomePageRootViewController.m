//
//  HomePageRootViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "HomePageRootViewController.h"
#import "HomePageViewController.h"
@interface HomePageRootViewController ()

@end

@implementation HomePageRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomePageViewController *homeVC = [[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
    [self pushViewController:homeVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
