//
//  DateFormat.m
//  anyouyun
//
//  Created by 超冷 on 16/6/16.
//  Copyright © 2016年 ANSCloud. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat
+(NSDate*)getDateFromServiceString:(NSString *)string{
    string=[string substringToIndex:19];
    NSTimeZone *timezone=[[NSTimeZone alloc]initWithName:@"GMT+0800"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setTimeZone:timezone];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *result=[formatter dateFromString:string];
    return result;
}

+(NSString*)getServiceStringFromDate:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *string=[formatter stringFromDate:date];
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    long hour=timeZone.secondsFromGMT/60/60;
    if (hour>=0) {
        string=[NSString stringWithFormat:@"%@+%02ld:00",string,hour];
    }else{
        string=[NSString stringWithFormat:@"%@%02ld:00",string,hour];
    }
    return string;
}
+(NSString *)getDateStringFromString:(NSString *)dateString{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d= [DateFormat getDateFromServiceString:dateString];
    NSString *str1=[formatter stringFromDate:d];
    NSString *dataString = [formatter stringFromDate:[NSDate date]];
    dataString = [str1 substringToIndex:16];
    return dataString;
}
+(NSString *)getDateStringFromServiceString:(NSString *)dateString{
    NSString *timeString=@"";
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d= [DateFormat getDateFromServiceString:dateString];
    NSString *str1=[formatter stringFromDate:d];
    
    NSString *todayStr = [formatter stringFromDate:[NSDate date]];
    if (![[todayStr substringWithRange:NSMakeRange(1, 10)] isEqualToString:[str1 substringWithRange:NSMakeRange(1, 10)]]) {
        timeString = [str1 substringWithRange:NSMakeRange(5, 5)];
    }else{
        NSTimeInterval late=[d timeIntervalSince1970]*1;
        
        NSDate* dat = [NSDate date];
        NSTimeInterval now=[dat timeIntervalSince1970]*1;
        
        NSTimeInterval cha= fabs(now - late);
        
        if (cha/60 < 1) { //N<1分钟：刚刚
            timeString = @"刚刚";
        }
        
        if (cha/60 >=1 && cha/3600 < 1) { //1分钟<=N<1小时：N分钟前(ex:25分钟前)
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
        if (cha/3600>=1 && cha/86400<1) { //1小时<=N<=当天：HH:mm(ex:17:32)
            timeString = [str1 substringWithRange:NSMakeRange(11, 5)];
        }
        if (cha/86400>=1 && cha/31536000 < 1) //当天<N<=当年：MM-dd (ex:04-01)
        {
            timeString = [str1 substringWithRange:NSMakeRange(5, 5)];
        }
        
        if (cha/31536000 > 1) // N>当年：yy-MM-dd(ex:14-12-30)
        {
            timeString = [str1 substringWithRange:NSMakeRange(2, 8)];
        }
    }
    return timeString;
}

+(NSString *)getActiveTimeStringFromServiceString:(NSString *)dateString{
    NSString *timeString=@"";
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *result=[formatter dateFromString:dateString];
    NSTimeInterval late=[result timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha= fabs(now - late);
    
    if (cha/60 < 1) { //N<1分钟：刚刚
        timeString = @"刚刚";
        return timeString;
    }
    
    if (cha/60 >=1 && cha/3600 < 1) { //1分钟<=N<1小时：N分钟前(ex:25分钟前)
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        return timeString;
    }
    if (cha/3600>=1 && cha/86400<1) { //1小时<=N<1d：(ex:3小时前)
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        return timeString;
    }
    if (cha/86400>=1 && cha/86400 < 2) //1d<=N<2d：MM-dd (ex:1天前)
    {
        timeString = @"1天前";
        return timeString;
    }
    
    if (cha/86400>=2 && cha/86400 < 3) // 2d<=N<3d：MM-dd (ex:2天前)
    {
        timeString = @"2天前";
        return timeString;
    }
    if (cha/86400>=3 && cha/86400 < 4) // 3d<=N：MM-dd (ex:3天前)
    {
        timeString = @"3天前";
        return timeString;
    }
    if (cha/86400>=4 && cha/86400 < 5) // 3d<=N：MM-dd (ex:3天前)
    {
        timeString = @"4天前";
        return timeString;
    }
    if (cha/86400>=5 && cha/86400 < 6) // 3d<=N：MM-dd (ex:3天前)
    {
        timeString = @"5天前";
        return timeString;
    }
    if (cha/86400>=6 && cha/86400 < 7) // 3d<=N：MM-dd (ex:3天前)
    {
        timeString = @"6天前";
        return timeString;
    }
    if (cha/86400>=7) // 3d<=N：MM-dd (ex:3天前)
    {
        timeString = @"一周前";
        return timeString;
    }
    
    return @"";
}

+(NSString *)getYearMonthFromString:(NSString *)dateString{
    NSString *string;
    NSDate *now=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *d= [self getDateFromServiceString:dateString];
    NSString *serviceDay = [formatter stringFromDate:d];
    NSString *nowDay=[formatter stringFromDate:now];
    if ([[nowDay substringToIndex:4] isEqualToString:[serviceDay substringToIndex:4]]) {
        string = [serviceDay substringFromIndex:5];
    }else{
        string = serviceDay;
    }
    
    return string;
}

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"M月d日"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+ (NSString*)weekDayStr:(NSString *)format
{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";  
            break;  
    }  
    return weekDayStr;  
}

+(NSString *)getYearForDate:(NSDate *)date{
    NSString *year = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    year = [dateFormatter stringFromDate:date];
    return year;
}

+(NSString *)getMonthForDate:(NSDate *)date{
    NSString *month = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    month = [dateFormatter stringFromDate:date];
    return month;
}

+(NSString *)getDayForDate:(NSDate *)date{
    NSString *day = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    day = [dateFormatter stringFromDate:date];
    return day;
}

+(NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //前者大
        return 1;
    }
    else if (result == NSOrderedAscending){
        //前者小
        return -1;
    }
    //相等
    return 0;
}

+(NSDate *)getDateWithDateString:(NSString *)dateString{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *result=[formatter dateFromString:dateString];
    return result;
}

+(NSDate *)getDateForPointWithDateString:(NSString *)dateString{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *result=[formatter dateFromString:dateString];
    return result;
}

+(NSString *)getDateStringFromDate:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+(NSString *)getDateStringGFromDate:(NSDate *)date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:date];
}

+(NSInteger)weekdayFromDate:(NSDate *)date{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:[[DateFormat getYearForDate:date] integerValue]];
    [comps setMonth:[[DateFormat getMonthForDate:date] integerValue]];
    [comps setDay:[[DateFormat getDayForDate:date] integerValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *tempDate = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:tempDate];
    return [weekdayComponents weekday];
}

+(NSString *)getNDay:(NSInteger)n{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(n!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        }else{
            theDate = nowDate;
        }
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    return the_date_str;
}

+(NSString *)getDateWithYMDHMS:(NSString *)dateStr{
    NSDate *date = [self getDateWithDateString:dateStr];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd  HH:mm:ss"];
    return [formatter stringFromDate:date];
}
@end
