//
//  MainRootTabBarController.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/15.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "MainRootTabBarController.h"
#import "MainNavigationController.h"
#import "HomePageRootViewController.h"
#import "ExploreRootViewController.h"
#import "ActivityRootViewController.h"
#import "PersonalCenterRootViewController.h"

@interface MainRootTabBarController ()

@end

@implementation MainRootTabBarController

+ (void)initialize{
    
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor orangeColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpMainTabBar];
}

#pragma MARK -- 建立主要的视图模块
- (void)setUpMainTabBar{
    
    HomePageRootViewController *homePageVC = [[HomePageRootViewController alloc]init];
    ExploreRootViewController *exploreVC = [[ExploreRootViewController alloc]init];
    ActivityRootViewController *activityVC = [[ActivityRootViewController alloc]init];
    PersonalCenterRootViewController *personVC = [[PersonalCenterRootViewController alloc]init];
    
    [self setUpChildController:homePageVC withTabBarImageNormal:@"tab_home" withTabBarImageSelected:@"tab_home_pre" withTabBarTitle:@"首页"];

    [self setUpChildController:exploreVC withTabBarImageNormal:@"tab_message" withTabBarImageSelected:@"tab_message_pre" withTabBarTitle:@"发现"];

    
    [self setUpChildController:activityVC withTabBarImageNormal:@"tab_flag" withTabBarImageSelected:@"tab_flag_pre" withTabBarTitle:@"活动"];
    
    [self setUpChildController:personVC withTabBarImageNormal:@"tab_user" withTabBarImageSelected:@"tab_user_pre" withTabBarTitle:@"个人中心"];
    
}

/**
 设置单个tabBarButton

 @param viewController 每一个按钮对应的子控制器
 @param normalImage 普通状态下图片
 @param selectedImage 选中状态下图片
 @param title 每一个按钮对应的标题
 */
- (void)setUpChildController:(UIViewController *)viewController withTabBarImageNormal:(NSString *)normalImage withTabBarImageSelected:(NSString *)selectedImage withTabBarTitle:(NSString *)title;{

    viewController.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *norImage = [UIImage imageNamed:normalImage];
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = norImage;
    
    UIImage *seleImage = [UIImage imageNamed:selectedImage];
    seleImage = [seleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = seleImage;
    
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    
    MainNavigationController *MainNav = [[MainNavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:MainNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
