//
//  NetWorkStatus.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "NetWorkStatus.h"
#import "SVProgressHUD.h"
static NSString * const AFAppNetBaseURL = @"https://www.baidu.com";
@implementation NetWorkStatus
+(void)startMonitoring
{
    static NetWorkStatus *netSatue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netSatue = [[NetWorkStatus alloc]init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变了, 就会调用这个block
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    [self addHUB:@"未知网络"];
                    break;
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    [self addHUB:@"网络发生错误,请检查您的网络设置"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    [self addHUB:@"手机3G网络,注意您的套餐流量"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    [self addHUB:@"目前使用的是WIFI,请放心使用"];
                    break;
            }
            
        }];
        [netSatue.reachabilityManager startMonitoring];
    });
    
}
+ (void)addHUB:(NSString *)title{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.8]];
    [SVProgressHUD showInfoWithStatus:title];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
@end
