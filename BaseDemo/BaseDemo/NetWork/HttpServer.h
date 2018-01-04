//
//  HttpServer.h
//  Tool
//
//  Created by 朴子hp on 2017/3/22.
//  Copyright © 2017年 iOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpServer : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;
//请求成功的时候的block
typedef void (^ResultBlock)(id responseObject);
//请求失败的时候的block
typedef void (^ErrorBlock)(NSError *error);
//get请求
+(void)requestGetWithMethod:(NSString *)methond withParams:(NSDictionary *)params withSuccessBlock:(ResultBlock)successBlock withFailBlock:(ErrorBlock)failBlock;
//post请求
+(void)requestPostWithMethod:(NSString *)methond withParams:(NSDictionary *)params withSuccessBlock:(ResultBlock)successBlock withFailBlock:(ErrorBlock)failBlock;

@end
