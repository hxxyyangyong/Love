//
//  GLBlurBackgroundView.h
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+StackBlur.h"
#import "FXBlurView.h"
@interface GLBlurBackgroundView : UIImageView
@property (nonatomic, strong) FXBlurView    *blurView;
@property (nonatomic, strong) UIImageView   *grayView;
@property (nonatomic, strong) UIImageView   *downView;
@property (nonatomic, assign) NSUInteger     blurValue;
@property (nonatomic, assign) BOOL          isHiddenGray;

- (void)setBackgroundImage:(UIImage *)image;
- (void)setBackgroundImage:(UIImage *)image gray:(BOOL)gray;
@end
