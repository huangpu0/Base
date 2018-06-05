//
//  Convert.h
//  
//  Created by Studio Johnny on 15/1/13.
//  Copyright (c) 2015年 cn.chono. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Convert : NSObject

//判空处理
+(BOOL)isNull:(id)object;
//获取下拉动画图片组
+(NSArray*)getLoadingAnimation;
@end
