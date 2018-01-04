//
//  AppDelegate.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageRootViewController.h"
#import "NetWorkStatus.h"
#import "Reachability.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [[HomePageRootViewController alloc]init];
    [NetWorkStatus startMonitoring];
//苹果官方的网络状态检测
//  Reachability *reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
//  NetworkStatus status = [reach currentReachabilityStatus];
//  UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[self strFromStatus:status] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//  [alertView show];
    [self.window makeKeyWindow];
    return YES;
}
//苹果官方的网络状态检测
-(NSString *)strFromStatus:(NetworkStatus)status
{
    NSString * string;
    switch (status) {
        case NotReachable:
            string = @"Not Reachable";
            break;
        case ReachableViaWiFi:
            string = @"WiFi";
            break;
        case ReachableViaWWAN:
            string = @"WWAN";
            break;
        default:
            string = @"....";
            break;
    }
    return string;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
