//
//  TestModel.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/11/1.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

+ (NSArray *)modelArrayWithDataArray:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        TestModel *model = [[TestModel alloc]initWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
