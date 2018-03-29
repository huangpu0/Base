//
//  HttpServer.m
//  Tool
//
//  Created by 朴子hp on 2017/3/22.
//  Copyright © 2017年 iOS开发. All rights reserved.
//

#import "HttpServer.h"
#import "NetworkCache.h"
#import "FilesManager.h"
static AFHTTPSessionManager *manager;

@implementation HttpServer

+ (instancetype)sharedClient {
    static HttpServer *server = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        //发送json数据
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应json数据
        manager.responseSerializer  = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil];
        server = [[self alloc]init];
    });
    return server;
}

/**
 get请求
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]requestGetMethodWithURL:url withParameters:parameters withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
- (void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    //    NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
    //    [parameter setValue:methond forKey:@"FunctionName"];
    //    [parameter setValue:@"GetResult" forKey:@"Type"];
    //    [parameter setValue:[dic dictionaryToJson] forKey:@"QueryData"];
    //    URL: http://caiyiquan.082818.com/api/Client/ApiHandle.ashx?FunctionName=GetTalkGroupRecomList&QueryData=%7B%22UserID%22%3A%224827%22%7D&Type=GetResult
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求数据--%@",responseObject);
        successBlock(responseObject);
        //successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        failureBlock(error);
    }];
}

/**
 get请求带有缓存
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]requestGetMethodWithURL:url withParameters:parameters withResponseCache:cacheBlock withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
-(void)requestGetMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    
    [manager.requestSerializer setValue:@"ee0e1a20714194557fd8440e08844809" forHTTPHeaderField:@"Authorization"];
    NSDate *datenow = [NSDate date];
    NSString *currentSystemDate = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    [manager.requestSerializer setValue:currentSystemDate forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:@"develop" forHTTPHeaderField:@"Environment"];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"Version"];
    
    
    cacheBlock !=nil ? cacheBlock([NetworkCache httpCacheForURL:url parameters:parameters]) : nil;
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //对数据进行异步缓存
        cacheBlock !=nil ? [NetworkCache setHttpCache:responseObject URL:url parameters:parameters] : nil;
        
        NSLog(@"请求数据--%@",responseObject);
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        failureBlock(error);
    }];
    
}
/**
 post请求
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]requestPostMethodWithURL:url withParameters:parameters withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
- (void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求数据--%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        failureBlock(error);
    }];
}

/**
 post请求带有缓存
 
 @param url 请求地址
 @param parameters 参数
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+(void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]requestPostMethodWithURL:url withParameters:parameters withResponseCache:cacheBlock withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
-(void)requestPostMethodWithURL:(NSString *)url withParameters:(id )parameters withResponseCache:(HttpRequestCache)cacheBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    
    cacheBlock !=nil ? cacheBlock([NetworkCache httpCacheForURL:url parameters:parameters]) : nil;
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //对数据进行异步缓存
        cacheBlock !=nil ? [NetworkCache setHttpCache:responseObject URL:url parameters:parameters] : nil;
        
        NSLog(@"请求数据--%@",responseObject);
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        failureBlock(error);
    }];
}

/**
 上传单张照片
 
 @param url 请求地址
 @param parameters 参数
 @param image 图片
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)uploadPictureWithURL:(NSString *)url withParameters:(id)parameters withImage:(UIImage *)image withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]uploadPictureWithURL:url withParameters:parameters withImage:image withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
- (void)uploadPictureWithURL:(NSString *)url withParameters:(id)parameters withImage:(UIImage *)image withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:imageData name:@"PhotoData" fileName:fileName mimeType:@"image/jpeg/png/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求数据--%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        failureBlock(error);
    }];
}

/**
 上传多张照片
 
 @param url 请求地址
 @param parameters 参数
 @param imagesArray 图片数组
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)uploadPicturesWithURL:(NSString *)url  withParameters:(id )parameters  withImagesArray:(NSArray <UIImage *>*)imagesArray  withSuccessBlock:(HttpRequestSuccess)successBlock  withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]uploadPicturesWithURL:url withParameters:parameters withImagesArray:imagesArray withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
- (void)uploadPicturesWithURL:(NSString *)url  withParameters:(id )parameters  withImagesArray:(NSArray <UIImage *>*)imagesArray  withSuccessBlock:(HttpRequestSuccess)successBlock  withFailureBlock:(HttpRequestFailed)failureBlock;{
    
    for (int i = 0; i < imagesArray.count; i ++) {
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
            UIImage *image = imagesArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"PhotoData" fileName:fileName mimeType:@"image/jpeg/png/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求数据--%@",responseObject);
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败--%@",error);
            failureBlock(error);
        }];
    }
}

/**
 文件下载相关
 
 @param url 请求地址
 @param parameters 参数
 @param fileName 保存本地文件名字
 @param successBlock 成功的回调 block
 @param failureBlock 失败的回调 block
 */
+ (void)downloadFileWithURL:(NSString *)url  withParameters:(id )parameters  downloadLocalFileName:(NSString *)fileName withProgressBlock:(HttpRequestProgress)progressBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    [[HttpServer sharedClient]downloadFileWithURL:url withParameters:parameters  downloadLocalFileName:fileName withProgressBlock:progressBlock withSuccessBlock:successBlock withFailureBlock:failureBlock];
}
- (void)downloadFileWithURL:(NSString *)url withParameters:(id )parameters downloadLocalFileName:(NSString *)fileName withProgressBlock:(HttpRequestProgress)progressBlock withSuccessBlock:(HttpRequestSuccess)successBlock withFailureBlock:(HttpRequestFailed)failureBlock;{
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:requestURL progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock ? progressBlock(downloadProgress) : nil;
        });
        NSLog(@"下载进度:==%.2f",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:[FilesManager createDirectory:@"视频" withFilePath:response.suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(failureBlock && error) {failureBlock(error) ; return ;};
        successBlock ? successBlock(filePath.absoluteString /** NSURL->NSString*/) : nil;
    }];
    //开始下载
    [downloadTask resume];
}
@end

