//
//  HttpServer.h
//  Tool
//
//  Created by 朴子hp on 2017/3/22.
//  Copyright © 2017年 iOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpServer : NSObject

//请求成功的时候的block
typedef void (^HttpRequestSuccess) (id responseCache);
//请求失败的时候的block
typedef void (^HttpRequestFailed) (NSError *error);
//数据缓存回调的block
typedef void (^HttpRequestCache)  (id response);

/**
 get请求
 
 @param url 拼接url
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 get请求带有缓存
 
 @param url 拼接url
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 post请求
 
 @param url 拼接url
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 post请求带有缓存
 
 @param url 拼接url
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 单张图片上传
 
 @param image 上传的图片
 @param params 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
//+ (void)uploadPictureWithImage:(UIImage *)image params:(NSDictionary *)params withSuccessBlock:(SuccessfulBlock)successBlock withFailureBlock:(ErrorBlock)failureBlock;

@end

