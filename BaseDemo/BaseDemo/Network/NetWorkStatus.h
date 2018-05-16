//
//  NetWorkStatus.h
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface NetWorkStatus : AFHTTPSessionManager
+(void)startMonitoring;
@end
