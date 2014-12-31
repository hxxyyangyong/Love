//
//  GLPosterSelectView.m
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLPosterSelectView.h"

@interface GLPosterSelectView()

@property (nonatomic, strong) UIButton          *selectedPosterBtn;

@end


@implementation GLPosterSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initResource];
    }
    return self;
}

- (void)initResource
{
    _posterView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    
    [_posterView setBackgroundColor:[[UIColor colorWithHexString:@"#454545"] colorWithAlphaComponent:0.6]];
    [self addSubview:_posterView];
    
    CGFloat width = 116/2.0f;
    CGFloat height = 100/2.0f;
    self.iconCount = 7;
//    NSArray *imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle_storyboard1_icon",
//                               @"makecards_puzzle_storyboard2_icon",
//                               @"makecards_puzzle_storyboard3_icon",
//                               @"makecards_puzzle_storyboard4_icon",
//                               @"makecards_puzzle_storyboard5_icon",
//                               @"makecards_puzzle_storyboard6_icon",nil];
//    for (int i = 0; i < [imageNameArray count]; i++) {
    
    for (int i = 0; i <self.iconCount; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width+(width-37)/2.0f, 2.5f, 37, 45)];
        if (i != self.iconCount -1) {
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"poster_smallIcon_%d.jpg",i+1]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateSelected];
        }else{
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"makecards_free_add_icon.png"]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"makecards_free_green_add_icon.png"]] forState:UIControlStateSelected];
        }

//        [button setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateHighlighted];
//        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateSelected];
        
        
        [button addTarget:self action:@selector(posterAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i+1];

        [_posterView addSubview:button];
        button = nil;
    }
//    [_posterView setContentSize:CGSizeMake([imageNameArray count]*width, height)];
     [_posterView setContentSize:CGSizeMake(self.iconCount*width, height)];


}



/**
 *  边框的选择
 *
 *  @param sender
 */
- (void)posterAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button == _selectedPosterBtn && button.tag != self.iconCount) {
        return;
    }
    self.selectStyleIndex = button.tag;
    [_selectedPosterBtn setSelected:NO];
    _selectedPosterBtn = button;
    [_selectedPosterBtn setSelected:YES];
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectedPosterStyleIndex:)]) {
        [_delegateSelect didSelectedPosterStyleIndex:self.selectStyleIndex];
    }
}

- (void)dealloc
{
    [_posterView removeFromSuperview];
    _posterView = nil;
    _selectedPosterBtn = nil;
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
