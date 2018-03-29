//
//  FilesManager.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/3/26.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "FilesManager.h"

@implementation FilesManager

/**
 创建下载文件夹目录及文件名字
 
 @param dirName 文件目录
 @param fileName 文件名字
 @return 文件地址 filePath
 */
+ (NSString *)createDirectory:(NSString *)dirName withFilePath:(NSString *)fileName{
    //拼接缓存目录
    NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dirName ? dirName : @"Download"];
    //打开文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //创建自定义目录或Download目录
    [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
    //拼接文件路径
    NSString *filePath = [downloadDir stringByAppendingPathComponent:fileName];

    return filePath;
}

@end
