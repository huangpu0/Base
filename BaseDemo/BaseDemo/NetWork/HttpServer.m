//
//  HttpServer.m
//  Tool
//
//  Created by 朴子hp on 2017/3/22.
//  Copyright © 2017年 iOS开发. All rights reserved.
//

#import "HttpServer.h"
#import "NetworkCache.h"

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
 
 @param url 拼接url
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
        NSLog(@"-数据-%@",responseObject);
        successBlock(responseObject);
        //successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-失败-%@",error);
        failureBlock(error);
    }];
}

/**
 get请求带有缓存
 
 @param url 拼接url
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
        
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
/**
 post请求
 
 @param url 拼接url
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
        NSLog(@"-数据-%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-失败-%@",error);
        failureBlock(error);
    }];
}

@end

