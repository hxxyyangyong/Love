//
//  NSString+Help.m
//  Tuotuo
//
//  Created by Holyen Zou on 13-7-9.
//  Copyright (c) 2013年 cn.gaialine. All rights reserved.
//

#import "NSString+Help.h"
#import "NSDate+Help.h"

@implementation NSString (Help)

- (id)nilOrObject
{
    if ([[NSNull null] isEqual:self] || self == Nil)
    {
        return nil;
    }
    return self;
}

- (NSString *)convertToString
{
    if (!self || [[NSNull null] isEqual:self] || self == Nil)
        return nil;
    else if ([self isKindOfClass:[NSString class]])
        return (id)self;
    else if([self isKindOfClass:[NSNumber class]])
        [(id)self stringValue];
    
    return [(id)self stringValue];
}

- (NSDate *)dateFromString
{
    if (self == nil)
        return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:STANDARD_DATE_FORMAT];
    NSDate *retDate = [dateFormatter dateFromString:self];
    if (retDate == nil)
    {
        return [self dateFromJavaDateString];
    }
    NSAssert(retDate, @"date is nil");
    return retDate;
}

- (NSDate *)dateFromJavaDateString
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date;
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"MMM d, yyyy hh:mm:ss a"];
    date = [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)standardDateFormateFromJaveFormateString
{
    NSDate *date = [self dateFromJavaDateString];
    return [date localDateString];
//    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
//    NSDate *localDate = [date dateByAddingTimeInterval:interval];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:STANDARD_DATE_FORMAT];
//    return [formatter stringFromDate:localDate];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)lengthBetween:(NSInteger)less and:(NSInteger)more
{
    if ([self length] < less || [self length] > more)
        return FALSE;
    return TRUE;
}

+ (BOOL)isNilOrEmpty:(NSString *)string
{
    return !string || [@"" isEqualToString:string] || [string isEqual:[NSNull null]];
}

+ (NSString *)nilOrStringValue:(NSString *)string
{
    if ([@"" isEqualToString:string] || [string isEqual:[NSNull null]] || self == Nil)
    {
        return nil;
    }
    return string;
}

+ (NSString *)emptyOrStringValue:(NSString *)string
{
    if (!string || [string isEqual:[NSNull null]] || string == Nil)
    {
        return @"";
    }
    return string;
}

- (CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font
{
    if (!self || self.length == 0)
        return CGSizeZero;
    
    CGSize contentSize;
    if (IOS7)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        contentSize =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
        contentSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];//ios7以上已经摒弃的这个方法
    }
    return contentSize;
}


+ (NSString *)urlcombineWithBefore:(NSString *)before
                             after:(NSString *)after
{
    BOOL beforeFlag  = [before hasSuffix:@"/"];
    BOOL afterFlag  = [after hasPrefix:@"/"];
    
    if (before.length > 0 && after.length <= 0) {
        return before;
    }
    
    
    if (after.length > 0 && before.length <= 0) {
        return after;
    }
    
    if (beforeFlag && afterFlag) {
        return [NSString stringWithFormat:@"%@%@",[before substringFromIndex:1],after];
    }
    
    if (!beforeFlag && !afterFlag) {
        return [NSString stringWithFormat:@"%@/%@",before,after];
    }
    
    if ((beforeFlag && !afterFlag) || (!beforeFlag && afterFlag)) {
        return [NSString stringWithFormat:@"%@%@",before,after];
    }
    
    return [NSString stringWithFormat:@"%@%@",before,after];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    if (!date)
        return nil;

    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [fmt setLocale:local];

    [fmt setDateFormat:format];
    NSString *strFromDate = [fmt stringFromDate:date];
    return strFromDate;
}

+ (NSString *)countCovert:(long long)count
{
    float ff = 0.0f;
    if (count > 9999999)
    {
        return @"999w";
    }
    else if(count > 9999)
    {
        ff = ((float)count)/10000.0f;
        return [NSString stringWithFormat:@"%.0fw", ff];
    }
    else if (count > 999)
    {
        ff = ((float)count)/1000.0f;
        return [NSString stringWithFormat:@"%.0fk", ff];
    }
    else
    {
       return [NSString stringWithFormat:@"%lld", count];
    }
}

+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}  


- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
    
}

@end
