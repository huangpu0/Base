//
//  HttpServer.m
//  Tool
//
//  Created by 朴子hp on 2017/3/22.
//  Copyright © 2017年 iOS开发. All rights reserved.
//

#import "HttpServer.h"
#import "HttpBaseModel.h"

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

+ (void)requestGetWithMethod:(NSString *)methond withParams:(NSDictionary *)params withSuccessBlock:(ResultBlock)successBlock withFailBlock:(ErrorBlock)failBlock;{
//    NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
//    [parameter setValue:methond forKey:@"FunctionName"];
//    [parameter setValue:@"GetResult" forKey:@"Type"];
//    [parameter setValue:[dic dictionaryToJson] forKey:@"QueryData"];
//    URL: http://caiyiquan.082818.com/api/Client/ApiHandle.ashx?FunctionName=GetTalkGroupRecomList&QueryData=%7B%22UserID%22%3A%224827%22%7D&Type=GetResult
    [manager GET:methond parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-数据-%@",responseObject);
        HttpBaseModel * model = [[HttpBaseModel alloc]initWithDic:responseObject];
        successBlock(model);
        //successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-失败-%@",error);
        failBlock(error);
    }];
}
+ (void)requestPostWithMethod:(NSString *)methond withParams:(NSDictionary *)params withSuccessBlock:(ResultBlock)successBlock withFailBlock:(ErrorBlock)failBlock;{
    [[HttpServer sharedClient]requestPostWithMethod:methond withParams:params withSuccessBlock:successBlock withFailBlock:failBlock];
}
- (void)requestPostWithMethod:(NSString *)methond withParams:(NSDictionary *)params withSuccessBlock:(ResultBlock)successBlock withFailBlock:(ErrorBlock)failBlock;{
    [manager POST:methond parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-数据-%@",responseObject);
        HttpBaseModel * model = [[HttpBaseModel alloc]initWithDic:responseObject];
        successBlock(model);
        //successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-失败-%@",error);
        failBlock(error);
    }];
}

@end
