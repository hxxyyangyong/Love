//
//  GLEntity_Resource.m
//  Tuotuo
//
//  Created by Apple on 14-6-16.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLEntity_Resource.h"

@implementation GLEntity_Resource

- (id)initWithResourceId:(NSString *)resourceId
            resourceType:(NSString *)resourceType
                   level:(NSString *)level
               levelName:(NSString *)levelName
                   price:(NSString *)price
           resourceOrder:(NSString *)resourceOrder
         resourceContent:(NSString *)resourceContent
              smallPicId:(NSString *)smallPicId
                   cTime:(NSString *)cTime
                   mTime:(NSString *)mTime
            resourceName:(NSString *)resourceName
{
    if (self = [super init]) {
        self.resourceId = [resourceId longLongValue];
        self.resourceType = [resourceType integerValue];
        self.level = [level integerValue];
        self.levelName = levelName;
        self.price = [price doubleValue];
        self.resourceOrder = [resourceOrder integerValue];
        self.resourceContent = [resourceContent longLongValue];
        self.smallPicId = [smallPicId longLongValue];
        self.cTime = [cTime dateFromString];
        self.mTime = [mTime dateFromString];
        self.resourceName = resourceName;
    }
    return self;
}

- (id)initWithResourceId:(NSString *)resourceId
            resourceType:(NSString *)resourceType
                   level:(NSString *)level
               levelName:(NSString *)levelName
                   price:(NSString *)price
           resourceOrder:(NSString *)resourceOrder
         resourceContent:(NSString *)resourceContent
              smallPicId:(NSString *)smallPicId
                   cTime:(NSString *)cTime
                   mTime:(NSString *)mTime
            resourceName:(NSString *)resourceName
                  remake:(NSString *)remake
{
    if (self = [super init]) {
        self.resourceId = [resourceId longLongValue];
        self.resourceType = [resourceType integerValue];
        self.level = [level integerValue];
        self.levelName = levelName;
        self.price = [price doubleValue];
        self.resourceOrder = [resourceOrder integerValue];
        self.resourceContent = [resourceContent longLongValue];
        self.smallPicId = [smallPicId longLongValue];
        self.cTime = [cTime dateFromString];
        self.mTime = [mTime dateFromString];
        self.resourceName = resourceName;
        self.remake = remake;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *resourceId = [[dictionary objectForKey:@"resourceId"] convertToString];
    NSString *resourceType = [[dictionary objectForKey:@"resourceType"] convertToString];
    NSDictionary *levelDict = [dictionary objectForKey:@"level"];
    NSString *level = @"";
    NSString *levelName = @"";
    if (levelDict) {
        level = [[levelDict objectForKey:@"levels"] convertToString];
        levelName = [[levelDict objectForKey:@"levelName"] convertToString];
    }else{
        level = [[dictionary objectForKey:@"levels"] convertToString];
    }
    NSString *price = [[dictionary objectForKey:@"price"] convertToString];
    NSString *resourceOrder = [[dictionary objectForKey:@"resourceOrder"] convertToString];
    NSString *resourceContent = [[dictionary objectForKey:@"resourceContent"] convertToString];
    NSString *smallPicId = [[dictionary objectForKey:@"smallPicId"] convertToString];
    NSString *cTime = [[dictionary objectForKey:@"cTime"] standardDateFormateFromJaveFormateString];
    NSString *mTime = [[dictionary objectForKey:@"mTime"] standardDateFormateFromJaveFormateString];
    NSString *resourceName = [[dictionary objectForKey:@"resourceName"] convertToString];
    NSString *remake = [[dictionary objectForKey:@"remake"] convertToString];
    return [self initWithResourceId:resourceId
                       resourceType:resourceType
                              level:level
                          levelName:levelName
                              price:price
                      resourceOrder:resourceOrder
                    resourceContent:resourceContent
                         smallPicId:smallPicId
                              cTime:cTime
                              mTime:mTime
                       resourceName:resourceName
                             remake:remake];
}


+ (NSArray *)resourcelistWithResultArray:(NSArray *)resultArray
{
    NSMutableArray *retArray = [NSMutableArray array];
    for (int i = 0;i <[resultArray count];i++)
    {
        NSDictionary *dic = [resultArray objectAtIndex:i];
        GLEntity_Resource *resource = [[GLEntity_Resource alloc] initWithDictionary:dic];
        resource.resourceId = i+1;
        [retArray addObject:resource];
    }
    return retArray;
}

@end
