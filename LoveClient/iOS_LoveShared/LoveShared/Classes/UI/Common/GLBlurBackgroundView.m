//
//  GLBlurBackgroundView.m
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLBlurBackgroundView.h"

@implementation GLBlurBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initResource];
        self.blurValue = 30;
    }
    return self;
}

- (void)initResource
{
//    _blurImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _downView = [[UIImageView alloc] initWithFrame:self.bounds];
//    self.image = [UIImage imageNamed:@"img_default_blurimage.png"];
    [self setBackgroundColor:[UIColor clearColor]];
//    [_downView setBackgroundColor:[[UIColor colorWithHexString:@"#4b4a4a"] colorWithAlphaComponent:0.7]];
    _blurView = [[FXBlurView alloc] init];
    _blurView.frame = _downView.bounds;
    _blurView.tintColor = [UIColor darkGrayColor];
    _blurView.dynamic = YES;
    _blurView.blurRadius = 30;
    [self addSubview:_downView];
    
    _grayView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_grayView setBackgroundColor:[[UIColor colorWithHexString:@"#6a6a6a"] colorWithAlphaComponent:0.6]];
    [self addSubview:_grayView];
    [_grayView setHidden:YES];
    
    
    

    
}


- (void)setBackgroundImage:(UIImage *)image gray:(BOOL)gray
{
    [self setBackgroundImage:image];
    if (gray) {
        [_grayView setHidden:NO];
    }
}

- (void)setBackgroundImage:(UIImage *)image
{
    if(image == nil){
        self.image = [UIImage imageNamed:@"img_default_blurimage.png"];
    }else{
        self.image = nil;
        [_blurView removeFromSuperview];
        [_downView setImage:image];
        [_downView addSubview:_blurView];
    }
}



- (void)dealloc
{
    [_downView removeFromSuperview];
    _downView  = nil;
    [_blurView removeFromSuperview];
    _blurView  = nil;
    
    
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
