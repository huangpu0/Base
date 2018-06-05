//
//  LPUserModel.m
//  PenFan
//
//  Created by iOS on 16/5/17.
//  Copyright © 2016年 kaifa001. All rights reserved.
//

#import "LPUserModel.h"

@implementation LPUserModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.uID = [value integerValue];
    }
}
@end
