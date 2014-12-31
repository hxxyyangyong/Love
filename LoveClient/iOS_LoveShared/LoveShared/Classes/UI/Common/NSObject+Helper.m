//
//  NSObject+Helper.m
//  Tuotuo
//
//  Created by Apple on 14-6-5.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)


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
@end
