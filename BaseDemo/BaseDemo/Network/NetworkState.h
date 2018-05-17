//
//  NetworkState.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/17.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface NetworkState : AFHTTPSessionManager

/**
 全局检测app网络状态
 */
+(instancetype)startMonitoringNetworkStatus;

@end
