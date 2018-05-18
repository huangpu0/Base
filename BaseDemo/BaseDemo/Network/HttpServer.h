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
typedef void (^HttpRequestSuccess)  (id response);

//请求失败的时候的block
typedef void (^HttpRequestFailed)  (NSError *error);

//请求数据进度的block Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^HttpRequestProgress)  (NSProgress *progress);

//请求数据缓存回调的block
typedef void (^HttpRequestCache)  (id responseCache);

/**
 get请求
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestGetMethodWithURL:(NSString *)url
                withParameters:(id )parameters
              withSuccessBlock:(HttpRequestSuccess)successBlock
              withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 get请求带有缓存
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestGetMethodWithURL:(NSString *)url
                withParameters:(id )parameters
             withResponseCache:(HttpRequestCache)cacheBlock
              withSuccessBlock:(HttpRequestSuccess)successBlock
              withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 post请求
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestPostMethodWithURL:(NSString *)url
                 withParameters:(id )parameters
               withSuccessBlock:(HttpRequestSuccess)successBlock
               withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 post请求带有缓存
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestPostMethodWithURL:(NSString *)url
                 withParameters:(id )parameters
              withResponseCache:(HttpRequestCache)cacheBlock
               withSuccessBlock:(HttpRequestSuccess)successBlock
               withFailureBlock:(HttpRequestFailed)failureBlock;


/**
 上传单张照片

 @param url 请求地址
 @param parameters 参数
 @param image 图片
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)uploadPictureWithURL:(NSString *)url
              withParameters:(id )parameters
                   withImage:(UIImage *)image
            withSuccessBlock:(HttpRequestSuccess)successBlock
            withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 上传多张照片
 
 @param url 请求地址
 @param parameters 参数
 @param imagesArray 图片数组
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)uploadPicturesWithURL:(NSString *)url
              withParameters:(id )parameters
             withImagesArray:(NSArray <UIImage *>*)imagesArray
            withSuccessBlock:(HttpRequestSuccess)successBlock
            withFailureBlock:(HttpRequestFailed)failureBlock;

/**
 文件下载相关

 @param url 请求地址
 @param parameters 参数
 @param dirName 保存本地文件名字
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)downloadFileWithURL:(NSString *)url
             withParameters:(id )parameters
      downloadCreateDirectoryName:(NSString *)dirName
          withProgressBlock:(HttpRequestProgress)progressBlock
           withSuccessBlock:(HttpRequestSuccess)successBlock
           withFailureBlock:(HttpRequestFailed)failureBlock;

@end

