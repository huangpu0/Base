//
//  LPTitleModel.h
//  PenFan
//
//  Created by iOS on 16/5/16.
//  Copyright © 2016年 kaifa001. All rights reserved.
//


#import "BaseModel.h"

@interface LPTitleModel : BaseModel
@property (nonatomic, assign) NSInteger tID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *route;
- (instancetype)initWithDic:(NSDictionary *)dictinorey;
+ (NSArray *)modelWithDataArray:(NSArray *)array;
@end
