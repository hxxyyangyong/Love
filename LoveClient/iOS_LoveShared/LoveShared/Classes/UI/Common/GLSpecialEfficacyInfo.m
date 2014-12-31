//
//  GLSpecialEfficacyInfo.m
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLSpecialEfficacyInfo.h"
#import "GLColorView.h"
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue]>=7)
@implementation GLSpecialEfficacyInfo


- (void)dealloc
{
    _gadientColors = nil;
    _normalColor = nil;
    _innerShadowColor = nil;
    _layerStyle = nil;
    
    _gradientStartColor = nil;
    _gradientEndColor = nil;
}


+ (void)setGLSpecialEfficacyInfo:(GLSpecialEfficacyInfo *)info label:(UITextView *)targert
{
    targert.textColor = info.normalColor;
    if (info.gradientStartColor && info.gradientEndColor) {
        GLColorView *view = [[GLColorView alloc] initWithFrame:targert.bounds gadientColors:[NSArray arrayWithObjects:info.gradientStartColor,info.gradientEndColor,nil] gradientStartPoint:CGPointMake(0.0f, 0.0f) gradientEndPoint:CGPointMake(0.0f, 1.0f)];
        [view drawRect:targert.bounds];
        [targert setTextColor:isIOS7?[UIColor colorWithPatternImage:view.image]:info.normalColor];
    }else  if ([info.gadientColors count] > 0) {
        GLColorView *view = [[GLColorView alloc] initWithFrame:targert.bounds gadientColors:info.gadientColors gradientStartPoint:info.gradientStartPoint gradientEndPoint:info.gradientEndPoint];
        [view drawRect:targert.bounds];
        [targert setTextColor:isIOS7?[UIColor colorWithPatternImage:view.image]:info.normalColor];
    }
    
    if (info.innerShadowColor) {
        [targert.layer setShadowOffset:info.innerShadowOffset];
        [targert.layer setShadowColor:info.innerShadowColor.CGColor];
        [targert.layer setShadowOpacity:1];
        [targert.layer setShadowRadius:1];
    }
    
}


@end
