//
//  MainNavigationController.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/15.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:attrs];
    
    UINavigationBar *navVar = [UINavigationBar appearance];
    [navVar setTitleTextAttributes:attrs];
    [navVar setBarTintColor:[UIColor orangeColor]];
    
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handleTransition =
    NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handleTransition];
    
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >0 ) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn sizeToFit];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_btn"] forState:UIControlStateNormal];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0,-40, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
