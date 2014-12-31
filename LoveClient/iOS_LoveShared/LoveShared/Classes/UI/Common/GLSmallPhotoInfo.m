//
//  GLSmallPhotoInfo.m
//  Tuotuo
//
//  Created by yangyong on 14-7-3.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLSmallPhotoInfo.h"

@implementation GLSmallPhotoInfo



+ (GLSmallPhotoInfo *)infoWithDict:(NSDictionary *)dict
{
    GLSmallPhotoInfo *essayDecorationInfo = [[GLSmallPhotoInfo alloc] init];
//    if ([dict objectForKey:@"frame_orgin_x"]) {
//        essayDecorationInfo.frame_orgin_x = [[dict objectForKey:@"frame_orgin_x"] floatValue];
//    }
//    if ([dict objectForKey:@"frame_orgin_y"]) {
//        essayDecorationInfo.frame_orgin_y = [[dict objectForKey:@"frame_orgin_y"] floatValue];
//    }
//    if ([dict objectForKey:@"frame_size_width"]) {
//        essayDecorationInfo.frame_size_width = [[dict objectForKey:@"frame_size_width"] floatValue];
//    }
//    if ([dict objectForKey:@"frame_size_height"]) {
//        essayDecorationInfo.frame_size_height = [[dict objectForKey:@"frame_size_height"] floatValue];
//    }
//    if ([dict objectForKey:@"transform_angle"]) {
//        essayDecorationInfo.transform_angle = [[dict objectForKey:@"transform_angle"] floatValue];
//    }
//    if ([dict objectForKey:@"buttontag"]) {
//        essayDecorationInfo.buttontag = [[dict objectForKey:@"buttontag"] floatValue];
//    }

    if ([dict objectForKey:@"frame"]) {
        @try {
            essayDecorationInfo.frame = [GLSmallPhotoInfo rectScaleWithRect:CGRectFromString([dict objectForKey:@"frame"]) scale:2.0f];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    if ([dict objectForKey:@"transform_angle"]) {
        essayDecorationInfo.transform_angle = [[dict objectForKey:@"transform_angle"] floatValue];
    }
    return essayDecorationInfo;
}

+ (CGRect)rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x/scale;
    retRect.origin.y = rect.origin.y/scale;
    retRect.size.width = rect.size.width/scale;
    retRect.size.height = rect.size.height/scale;
    return  retRect;
}

+ (CGPoint)pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/scale;
    retPointt.y = point.y/scale;
    return  retPointt;
}


+ (CGSize)sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/scale;
    retSize.height = size.height/scale;
    return  retSize;
}



@end
