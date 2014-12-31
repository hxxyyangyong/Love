//
//  NSDate+Help.m
//  Tuotuo
//
//  Created by Holyen Zou on 13-7-9.
//  Copyright (c) 2013年 cn.gaialine. All rights reserved.
//

#import "NSDate+Help.h"


@implementation NSDate (Help)

- (NSString *)dateStringWithTodayFormatStr:(NSString *)todayFormatterStr
                      thisWeekFormatterStr:(NSString *)thisWeekFormatterStr
                      aWeekAgoFormatterStr:(NSString *)aWeekAgoFormatterStr
{
    if (!self) {
        return nil;
    }

    NSDateFormatter *todayFormatter = [[NSDateFormatter alloc] init];
    [todayFormatter setDateFormat:todayFormatterStr ? todayFormatterStr : @"HH:mm"];
    NSDateFormatter *thisWeekFormatter = [[NSDateFormatter alloc] init];
    [thisWeekFormatter setDateFormat:thisWeekFormatterStr ? thisWeekFormatterStr : @"EEE"];
    NSDateFormatter *aWeekAgoFormatter = [[NSDateFormatter alloc] init];
    [aWeekAgoFormatter setDateFormat:aWeekAgoFormatterStr ? aWeekAgoFormatterStr : @"yyyy-MM-dd"];
    
    NSDate *currentDate = [NSDate date];//现在的NSDate
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    [currentCalendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents * currentZeroDateComponents = [currentCalendar components:NSYearCalendarUnit |
                                                                              NSMonthCalendarUnit |
                                                                                NSDayCalendarUnit |
                                                                               NSHourCalendarUnit |
                                                                              NSMinuteCalendarUnit|
                                                                              NSSecondCalendarUnit
                                                                      fromDate:currentDate];
    [currentZeroDateComponents setHour:0];
    [currentZeroDateComponents setMinute:0];
    [currentZeroDateComponents setSecond:0];//当天00:00:00的时间元素.
    
    NSDate *currentZeroDate = [currentCalendar dateFromComponents:currentZeroDateComponents];//当天 00:00:00的NSDate
    NSTimeInterval currentToZeroOffsetTimeInterval = [currentDate timeIntervalSinceDate:currentZeroDate];//40000 //当天的妙数
    NSTimeInterval newToNowOffsetTimeInterval = - [self timeIntervalSinceNow];//120000 //新的时间跟现在的时间妙数差值.
    
    NSString *timeResultStr;
    if (newToNowOffsetTimeInterval < currentToZeroOffsetTimeInterval)//当天内的时间
    {
        //today
        timeResultStr = [todayFormatter stringFromDate:self];
    }
    else//比当天时间更早的时间点
    {
//        NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:self];
//        NSDate *localDate = [self dateByAddingTimeInterval:interval];//!!!FIX ME
        
        newToNowOffsetTimeInterval -= currentToZeroOffsetTimeInterval;
        NSTimeInterval oneDayTimeInterval = 86400;
        if (newToNowOffsetTimeInterval <= oneDayTimeInterval)
        {
            timeResultStr = @"昨天";//[NSString stringWithFormat:@"昨天 %@", [todayFormatter stringFromDate:localDate]];
        }
        else if (newToNowOffsetTimeInterval <= 86400 * 2)
        {
            timeResultStr = @"前天";//[NSString stringWithFormat:@"前天 %@", [todayFormatter stringFromDate:localDate]];
        }
        else if(newToNowOffsetTimeInterval > 86400 * 2 && newToNowOffsetTimeInterval < 7 * oneDayTimeInterval)
        {
            timeResultStr = [thisWeekFormatter stringFromDate:self];
        }
        else
        {
            timeResultStr = [aWeekAgoFormatter stringFromDate:self];
        }
    }
    return timeResultStr;
}

- (NSString *)IMDateStringWithTodayFormatStr:(NSString *)todayFormatterStr
                        thisWeekFormatterStr:(NSString *)thisWeekFormatterStr
                        aWeekAgoFormatterStr:(NSString *)aWeekAgoFormatterStr
{
    if (!self) {
        return nil;
    }
    
    NSDateFormatter *todayFormatter = [[NSDateFormatter alloc] init];
    [todayFormatter setDateFormat:todayFormatterStr ? todayFormatterStr : @"HH:mm"];
    NSDateFormatter *thisWeekFormatter = [[NSDateFormatter alloc] init];
    [thisWeekFormatter setDateFormat:thisWeekFormatterStr ? thisWeekFormatterStr : @"EEE"];
    NSDateFormatter *aWeekAgoFormatter = [[NSDateFormatter alloc] init];
    [aWeekAgoFormatter setDateFormat:aWeekAgoFormatterStr ? aWeekAgoFormatterStr : @"yyyy-MM-dd"];
    
    NSDate *currentDate = [NSDate date];//现在的NSDate
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    [currentCalendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents * currentZeroDateComponents = [currentCalendar components:NSYearCalendarUnit |
                                                    NSMonthCalendarUnit |
                                                    NSDayCalendarUnit |
                                                    NSHourCalendarUnit |
                                                    NSMinuteCalendarUnit|
                                                    NSSecondCalendarUnit
                                                                      fromDate:currentDate];
    [currentZeroDateComponents setHour:0];
    [currentZeroDateComponents setMinute:0];
    [currentZeroDateComponents setSecond:0];//当天00:00:00的时间元素.
    
    NSDate *currentZeroDate = [currentCalendar dateFromComponents:currentZeroDateComponents];//当天 00:00:00的NSDate
    NSTimeInterval currentToZeroOffsetTimeInterval = [currentDate timeIntervalSinceDate:currentZeroDate];//40000 //当天的妙数
    NSTimeInterval newToNowOffsetTimeInterval = - [self timeIntervalSinceNow];//120000 //新的时间跟现在的时间妙数差值.
    
    NSString *timeResultStr;
    if (newToNowOffsetTimeInterval < currentToZeroOffsetTimeInterval)//当天内的时间
    {
        //today
        timeResultStr = [NSString stringWithFormat:@"今天 %@", [todayFormatter stringFromDate:self]];
    }
    else//比当天时间更早的时间点
    {
        //        NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:self];
        //        NSDate *localDate = [self dateByAddingTimeInterval:interval];//!!!FIX ME
        
        newToNowOffsetTimeInterval -= currentToZeroOffsetTimeInterval;
        NSTimeInterval oneDayTimeInterval = 86400;
        if (newToNowOffsetTimeInterval <= oneDayTimeInterval)
        {
            timeResultStr = [NSString stringWithFormat:@"昨天 %@", [todayFormatter stringFromDate:self]];
        }
        else if (newToNowOffsetTimeInterval <= 86400 * 2)
        {
            timeResultStr = [NSString stringWithFormat:@"前天 %@", [todayFormatter stringFromDate:self]];
        }
        else if(newToNowOffsetTimeInterval > 86400 * 2 && newToNowOffsetTimeInterval < 7 * oneDayTimeInterval)
        {
            timeResultStr = [NSString stringWithFormat:@"%@ %@", [thisWeekFormatter stringFromDate:self], [todayFormatter stringFromDate:self]];
        }
        else
        {
            timeResultStr = [aWeekAgoFormatter stringFromDate:self];
        }
    }
    return timeResultStr;
}

- (NSString *)localDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:STANDARD_DATE_FORMAT];
    return [formatter stringFromDate:self];
}

- (NSString *)javaFormateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy hh:mm:ss a"];
    return [formatter stringFromDate:self];
}

@end
