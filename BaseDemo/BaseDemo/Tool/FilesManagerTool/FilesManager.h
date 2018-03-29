//
//  FilesManager.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/3/26.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilesManager : NSObject

/**
 创建下载文件夹目录及文件名字

 @param dirName 文件目录
 @param fileName 文件名字
 @return 文件地址 filePath
 */
+ (NSString *)createDirectory:(NSString *)dirName withFilePath:(NSString *)fileName;

@end
