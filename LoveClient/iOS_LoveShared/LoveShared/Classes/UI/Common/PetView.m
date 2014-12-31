//
//  PetView.m
//  Tuotuo
//
//  Created by yangyong on 14-5-6.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "PetView.h"

@implementation PetView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.gifPath = _filePath;
        [self initResource];
    }
    return self;
}


- (void)initResource
{
    [_gifView removeFromSuperview];
    _gifView = nil;
    _gifView = [[GifView alloc] initWithFrame:self.bounds filePath:self.gifPath];

    _gifView.clipsToBounds = YES;
    _gifView.userInteractionEnabled = NO;
    _gifView.backgroundColor = [UIColor clearColor];
    _gifView.contentMode = UIViewContentModeScaleAspectFit;
//    _gifView.layer.borderColor = [[UIColor colorWithRed:200 green:200 blue:200 alpha:1] CGColor];
//    _gifView.layer.borderWidth = 1;
//    _gifView.layer.cornerRadius = 5;
    [self addSubview:_gifView];
}


- (void)setGifPath:(NSString *)gifPath
{
    _gifPath = gifPath;
    [self initResource];
}


- (void)dealloc
{
    [_gifView removeFromSuperview];
    _gifView = nil;
    _gifPath = nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
