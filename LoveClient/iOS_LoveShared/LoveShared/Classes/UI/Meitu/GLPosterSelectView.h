//
//  GLPosterSelectView.h
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLPosterSelectViewDelegate;
@interface GLPosterSelectView : UIView

@property (nonatomic, assign) id<GLPosterSelectViewDelegate> delegateSelect;
@property (nonatomic, strong) UIScrollView      *posterView;
@property (nonatomic, assign) NSInteger          selectStyleIndex;
@property (nonatomic, assign) NSInteger         iconCount;

- (id)initWithFrame:(CGRect)frame;

@end

@protocol GLPosterSelectViewDelegate <NSObject>

- (void)didSelectedPosterStyleIndex:(NSInteger)styleIndex;

@end
