//
//  GLColorView.h
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLColorView : UIView
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSArray *gadientColors;
@property (nonatomic, assign) CGPoint gradientStartPoint;
@property (nonatomic, assign) CGPoint gradientEndPoint;
- (id)initWithFrame:(CGRect)frame   gadientColors:(NSArray *)gadientColors gradientStartPoint:(CGPoint)gradientStartPoint gradientEndPoint:(CGPoint)gradientEndPoint;
@end
