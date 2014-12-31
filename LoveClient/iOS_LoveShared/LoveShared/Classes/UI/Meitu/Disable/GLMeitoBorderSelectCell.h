//
//  GLMeitoBorderSelectCell.h
//  Tuotuo
//
//  Created by yangyong on 14-7-22.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMeitoBorderSelectView.h"
@interface GLMeitoBorderSelectCell : UITableViewCell

@property (nonatomic, strong) GLMeitoBorderSelectView *petOne;
@property (nonatomic, strong) GLMeitoBorderSelectView *petTwo;
@property (nonatomic, strong) GLMeitoBorderSelectView *petThree;

@property (nonatomic, weak)  id<GLMeitoBorderSelectViewDelegate>  delegateCell;


@end
