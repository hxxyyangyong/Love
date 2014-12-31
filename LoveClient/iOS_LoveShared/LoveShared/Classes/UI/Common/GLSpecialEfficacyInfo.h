//
//  GLSpecialEfficacyInfo.h
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLSpecialEfficacyInfo : NSObject


@property (nonatomic, strong) NSArray   *gadientColors;
@property (nonatomic, strong) UIColor   *normalColor;
@property (nonatomic, assign) CGPoint   gradientStartPoint;
@property (nonatomic, assign) CGPoint   gradientEndPoint;

@property (nonatomic, assign) CGSize    innerShadowOffset;
@property (nonatomic, strong) UIColor   *innerShadowColor;
@property (nonatomic, assign) CGFloat   innerShadowRadius;
@property (nonatomic, assign) CGFloat   innerShadowOpacity;
@property (nonatomic, strong) CALayer   *layerStyle;

@property (nonatomic, strong) UIColor *gradientStartColor;
@property (nonatomic, strong) UIColor *gradientEndColor;



+ (void)setGLSpecialEfficacyInfo:(GLSpecialEfficacyInfo *)info label:(UITextView *)targert;

@end
