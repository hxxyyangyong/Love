//
//  NSDate+Help.h
//  Tuotuo
//
//  Created by Holyen Zou on 13-7-9.
//  Copyright (c) 2013年 cn.gaialine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Help.h"
#define STANDARD_DATE_FORMAT                @"yyyy-MM-dd HH:mm:ss SSS"
#define yyyyMMddHHmmss                      @"yyyyMMddHHmmss"
#define yyyyMMddHHmmssSSS                      @"yyyyMMddHHmmssSSS"
@interface NSDate (Help)

- (NSString *)dateStringWithTodayFormatStr:(NSString *)todayFormatterStr
                      thisWeekFormatterStr:(NSString *)thisWeekFormatterStr
                      aWeekAgoFormatterStr:(NSString *)aWeekAgoFormatterStr;

- (NSString *)IMDateStringWithTodayFormatStr:(NSString *)todayFormatterStr
                        thisWeekFormatterStr:(NSString *)thisWeekFormatterStr
                        aWeekAgoFormatterStr:(NSString *)aWeekAgoFormatterStr;

- (NSString *)localDateString;

- (NSString *)javaFormateString;

@end
