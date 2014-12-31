//
//  NSString+Help.h
//  ;
//
//  Created by Holyen Zou on 13-7-9.
//  Copyright (c) 2013年 cn.gaialine. All rights reserved.
//

#import <Foundation/Foundation.h>
# define LINE_BREAK_TAIL_TRUNCATION UILineBreakModeTailTruncation
@interface NSString (Help)

- (id)nilOrObject;
- (NSString *)convertToString;

- (NSDate *)dateFromString;

- (NSDate *)dateFromJavaDateString;

- (NSString *)standardDateFormateFromJaveFormateString;



- (NSString *)trim;

- (CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font;

- (BOOL)lengthBetween:(NSInteger)less and:(NSInteger)more;

+ (BOOL)isNilOrEmpty:(NSString *)string;

+ (NSString *)nilOrStringValue:(NSString *)string;

+ (NSString *)emptyOrStringValue:(NSString *)string;

+ (NSString *)urlcombineWithBefore:(NSString *)before
                             after:(NSString *)after;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)countCovert:(long long)count;

+ (BOOL)isPureInt:(NSString *)string;
- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size;
@end
