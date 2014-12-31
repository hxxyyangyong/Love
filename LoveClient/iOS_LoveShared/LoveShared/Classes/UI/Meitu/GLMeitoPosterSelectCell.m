//
//  GLMeitoPosterSelectCell.m
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLMeitoPosterSelectCell.h"

@implementation GLMeitoPosterSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initResource];
    }
    return self;
}


- (void)initResource
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat padingWidth = ([UIScreen mainScreen].bounds.size.width - 3*80)/4;
    _petOne = [[GLMeitoPosterSelectView alloc] initWithFrame:CGRectMake((padingWidth*1+80*0), 15, 80, 107)];
    _petTwo = [[GLMeitoPosterSelectView alloc] initWithFrame:CGRectMake((padingWidth*2+80*1), 15, 80, 107)];
    _petThree = [[GLMeitoPosterSelectView alloc] initWithFrame:CGRectMake((padingWidth*3+80*2), 15, 80, 107)];
    
    [self.contentView addSubview:_petOne];
    [self.contentView addSubview:_petTwo];
    [self.contentView addSubview:_petThree];
}

- (void)setDelegateCell:(id<GLMeitoPosterSelectViewDelegate>)delegateCell
{
    _petOne.delegateSelect = delegateCell;
    _petTwo.delegateSelect = delegateCell;
    _petThree.delegateSelect = delegateCell;
}


- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    
    [_petOne removeFromSuperview];
    [_petTwo removeFromSuperview];
    [_petThree removeFromSuperview];
    
    _petOne = nil;
    _petTwo = nil;
    _petThree = nil;
}

@end
