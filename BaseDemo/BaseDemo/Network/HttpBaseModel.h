//
//  HttpBaseModel.h
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpBaseModel : NSObject

-(id)initWithDic:(NSDictionary *)dic;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
