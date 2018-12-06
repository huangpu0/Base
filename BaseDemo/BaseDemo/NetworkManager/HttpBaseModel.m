//
//  HttpBaseModel.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "HttpBaseModel.h"

@implementation HttpBaseModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //空实现
}

+ (NSArray *)modelArrayWithDataArray:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HttpBaseModel *model = [[HttpBaseModel alloc]initWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
