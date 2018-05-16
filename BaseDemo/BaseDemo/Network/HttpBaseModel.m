//
//  HttpBaseModel.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "HttpBaseModel.h"

@implementation HttpBaseModel

-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //空实现
}
@end
