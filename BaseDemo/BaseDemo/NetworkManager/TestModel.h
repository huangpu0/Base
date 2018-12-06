//
//  TestModel.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/11/1.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "HttpBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : HttpBaseModel

@property (copy, nonatomic) NSString *test;

+ (NSArray *)modelArrayWithDataArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
