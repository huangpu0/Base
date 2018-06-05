//
//  Convert.m
//
//  Created by Studio Johnny on 15/1/13.
//  Copyright (c) 2015年 cn.chono. All rights reserved.
//
#import "Convert.h"


@implementation Convert


+(BOOL)isNull:(id)object{
    if(object==nil||object==[NSNull null]){
        return YES;
    }else if([object isKindOfClass:[NSString class]]){
        NSString *string=object;
        if ([string isEqual:@""]) {
            return YES;
        }
    }else if([object isKindOfClass:[NSData class]]){
        NSData *data=object;
        if (data.length==0) {
            return YES;
        }
    }else if([object isKindOfClass:[NSDictionary class]]){
        NSDictionary *dictionary=object;
        if (dictionary.count==0) {
            return YES;
        }
    }else if([object isKindOfClass:[NSArray class]]){
        NSArray *array=object;
        if (array.count==0) {
            return YES;
        }
    }
    return NO;
}

+(NSArray*)getLoadingAnimation{
    NSMutableArray *array=[NSMutableArray array];
    for (int i=0; i<2; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]]];
    }
    return array;
}

@end
