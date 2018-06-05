//
//  LPTitleModel.m
//  PenFan
//
//  Created by iOS on 16/5/16.
//  Copyright © 2016年 kaifa001. All rights reserved.
//

#import "LPTitleModel.h"

@implementation LPTitleModel
- (instancetype)initWithDic:(NSDictionary *)dictinorey
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictinorey];
    }
    return self;
}
+ (NSArray *)modelWithDataArray:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        LPTitleModel *model = [[LPTitleModel alloc]initWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.tID = [value integerValue];
    }
}
@end
