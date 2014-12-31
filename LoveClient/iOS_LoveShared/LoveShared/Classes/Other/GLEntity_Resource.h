//
//  GLEntity_Resource.h
//  Tuotuo
//
//  Created by Apple on 14-6-16.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <Foundation/Foundation.h>

//* 1.心情
//* 2.随笔
//* 3.装饰
//* 4.小照片
//* 5.日记 底纹
//* 6.小卡片底版
//* 7.特效
//* 8.玩偶
//* 9.边框
//* 10.拨号键音乐
//* 11.美图背景
//* 12虚拟诞生地图片
//* 13 背景音乐
typedef enum e_resourcetype{
    E_ResourceType_Mood = 1,
    E_ResourceType_Essay = 2,
    E_ResourceType_DecorationList = 3,
    E_ResourceType_SmallPhotoList = 4,
    E_ResourceType_Diary = 5,
    E_ResourceType_BaseboardList = 6,
    E_ResourceType_SpecialEfficacyList = 7,
    E_ResourceType_DollList = 8,
    E_ResourceType_MeituBoardList = 9,
    E_ResourceType_CallMusic = 10,
    E_ResourceType_MeituBackground = 11,
    E_ResourceType_SelfHomepageBackground = 12,
    E_ResourceType_CardBackgroundMusic = 13,
    E_ResourceType_MeituPinjieBoardList = 14,
    E_ResourceType_CallTheme = 15
}E_ResourceType;


typedef enum e_resourcesuffix{

    E_ResourceSuffix_PNG = 1,
    E_ResourceSuffix_JPG = 2,
    E_ResourceSuffix_Gif = 3,
    E_ResourceSuffix_Other = 4
}E_ResourceSuffix;




@interface GLEntity_Resource : NSObject
/**
 * 主键
 */
@property (nonatomic, assign) long long             resourceId;

/*
 * 资源类型
 * 1.心情
 * 2.随笔
 * 3.装饰
 * 4.小照片
 * 5.日记 底纹
 * 6.小卡片底版
 * 7.特效
 * 8.玩偶
 * 9.海报边框
 * 10.拨号键音乐
 * 11.美图背景
 * 12虚拟诞生地图片
 * 13 背景音乐
 * 14 拼接边框
 * 15拨号键背景
 */

@property (nonatomic, assign) E_ResourceType             resourceType;


/**
 * 等级
 */
@property (nonatomic, assign) NSInteger             level;


/**
 * 等级名
 */
@property (nonatomic, strong) NSString              *levelName;


/**
 * 价格
 */
@property (nonatomic, assign) double                price;


/**
 * 排列顺序
 */
@property (nonatomic, assign) NSInteger             resourceOrder;


/**
 * 文件的id
 * 若文件为图片，则是大图ID
 */
@property (nonatomic, assign) long long             resourceContent;

/**
 * 图片的小图ID
 */
@property (nonatomic, assign) long long             smallPicId;


/**
 * 创建时间
 */
@property (nonatomic, strong) NSDate                *cTime;

/**
 * 修改时间
 */
@property (nonatomic, strong) NSDate                *mTime;
@property (nonatomic, strong) NSString              *resourceName;
//描述信息
@property (nonatomic, strong) NSString              *remake;


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
                  remake:(NSString *)remake;

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
            resourceName:(NSString *)resourceName;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)resourcelistWithResultArray:(NSArray *)resultArray;

@end
