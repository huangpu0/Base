//
//  NSDate+LPEctension.h
//  PenFan
//
//  Created by iOS on 16/5/28.
//  Copyright © 2016年 kaifa001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
//下个月
+ (NSDate *)dayInTheNextMonth;
//上个月
+ (NSDate *)dayInTheLastMonth;
//明天
+ (NSDate *)dayInTheNextDayForCount:(NSInteger)count;
//昨天
+ (NSDate *)dayInTheLastDayForCount:(NSInteger)count;
//今天是几号
+ (NSInteger)today:(NSDate *)date;
//这个月一共几天
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;
//这一天周几
+ (NSInteger)weekdayInThisDay:(NSDate *)date;
@end
