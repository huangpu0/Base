//
//  NSDate+LPEctension.m
//  PenFan
//
//  Created by iOS on 16/5/28.
//  Copyright © 2016年 kaifa001. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)dayInTheNextMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self date] options:0];
}

+ (NSDate *)dayInTheLastMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self date] options:0];
}

+ (NSDate *)dayInTheNextDayForCount:(NSInteger)count
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = count;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self date] options:0];
}

+ (NSDate *)dayInTheLastDayForCount:(NSInteger)count
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -count;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[self date] options:0];
}
+ (NSInteger)today:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return comp.day;
}
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

+ (NSInteger)weekdayInThisDay:(NSDate *)date;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

@end
