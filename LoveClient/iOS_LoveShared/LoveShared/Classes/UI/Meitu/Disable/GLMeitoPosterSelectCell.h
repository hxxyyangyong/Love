//
//  GLMeitoPosterSelectCell.h
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMeitoPosterSelectView.h"
@interface GLMeitoPosterSelectCell : UITableViewCell

@property (nonatomic, strong) GLMeitoPosterSelectView *petOne;
@property (nonatomic, strong) GLMeitoPosterSelectView *petTwo;
@property (nonatomic, strong) GLMeitoPosterSelectView *petThree;

@property (nonatomic, weak)  id<GLMeitoPosterSelectViewDelegate>  delegateCell;


@end
