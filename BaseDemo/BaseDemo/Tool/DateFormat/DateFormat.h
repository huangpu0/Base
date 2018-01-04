
//--------------------------------------时间格式化类---------------------------------------//

#import <Foundation/Foundation.h>

@interface DateFormat : NSObject
+(NSDate*)getDateFromServiceString:(NSString*)string;
+(NSString*)getServiceStringFromDate:(NSDate*)date;
//年月日小时分钟
+(NSString *)getDateStringFromString:(NSString *)dateString;
//将时间格式化为：刚刚，多少分钟前等
//常规时间格式
+(NSString *)getDateStringFromServiceString:(NSString *)dateString;
//活跃时间格式
+(NSString *)getActiveTimeStringFromServiceString:(NSString *)dateString;
//同一年---不显示年  否则显示年
+(NSString *)getYearMonthFromString:(NSString *)dateString;
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date;
//根据日期 得到年数：yyyy
+(NSString *)getYearForDate:(NSDate *)date;
//根据日期 得到年数：MM
+(NSString *)getMonthForDate:(NSDate *)date;
//根据日期 得到年数：dd
+(NSString *)getDayForDate:(NSDate *)date;


//比较两个日期的大小
+(NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
//时间字符串转化为nsdate "yyyy-MM-dd"
+(NSDate *)getDateWithDateString:(NSString *)dateString;
//时间字符串转化为nsdate "yyyy.MM.dd"
+(NSDate *)getDateForPointWithDateString:(NSString *)dateString;

//得到时间字符串
+(NSString *)getDateStringFromDate:(NSDate *)date;
//2012/02/02
+(NSString *)getDateStringGFromDate:(NSDate *)date;
//根据日期得到周几
+(NSInteger)weekdayFromDate:(NSDate *)date;
//获取n天后的日期（n为负数表示往前）
+(NSString *)getNDay:(NSInteger)n;
+(NSString *)getDateWithYMDHMS:(NSString *)dateStr;
@end
