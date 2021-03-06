//
//  NetworkState.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/17.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "NetworkStatus.h"

static NSString * const AppNetBaseURL = @"https://www.baidu.com";

@implementation NetworkStatus

+(instancetype)startMonitoringNetworkStatus
{
    static NetworkStatus *netState = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        netState = [[NetworkStatus alloc]initWithBaseURL:[NSURL URLWithString:AppNetBaseURL]];
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变了, 就会调用这个block
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    
                    [ProgressHUD showMessage:@"未知网络"];
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNetworkStatus object:nil userInfo:@{@"NetworkStatus":@"Unknown"}]];
                    
                    break;
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    
                    [ProgressHUD showMessage:@"网络出了点问题"];
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNetworkStatus object:nil userInfo:@{@"NetworkStatus":@"NotReachable"}]];
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    
                    [ProgressHUD showMessage:@"当前是3G网络,注意您的网络套餐"];
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNetworkStatus object:nil userInfo:@{@"NetworkStatus":@"3G|4G"}]];
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    
                    [ProgressHUD showMessage:@"Wi-Fi环境放心使用"];
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNetworkStatus object:nil userInfo:@{@"NetworkStatus":@"WiFi"}]];
                    
                    break;
            }
            
        }];
        [netState.reachabilityManager startMonitoring];
    });
    return netState;
}

@end
