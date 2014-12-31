//
//  GLSmallPhotoInfo.h
//  Tuotuo
//
//  Created by yangyong on 14-7-3.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLSmallPhotoInfo : NSObject

//@property (nonatomic, assign) CGFloat   frame_orgin_x;
//@property (nonatomic, assign) CGFloat   frame_orgin_y;
//@property (nonatomic, assign) CGFloat   frame_size_width;
//@property (nonatomic, assign) CGFloat   frame_size_height;
//@property (nonatomic, assign) NSInteger buttontag;
//@property (nonatomic, assign) CGFloat   transform_angle;

@property (nonatomic, assign) CGRect     frame;
@property (nonatomic, assign) CGFloat    transform_angle;


+ (GLSmallPhotoInfo *)infoWithDict:(NSDictionary *)dict;
+ (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale;
+ (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale;
+ (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale;
@end
