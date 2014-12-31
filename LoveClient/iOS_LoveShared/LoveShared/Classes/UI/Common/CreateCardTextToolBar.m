//
//  CreateCardTextToolBar.m
//  Tuotuo
//
//  Created by yongyang on 14-4-30.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "CreateCardTextToolBar.h"

@implementation CreateCardTextToolBar

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
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_texttoolbar_bg"]];
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 54, self.frame.size.height)];
    _contentView.clipsToBounds = YES;
    
//    _contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_texttoolbar_bg"]];
    NSArray *buttonImageNameArr = [NSArray arrayWithObjects:
                                   @"makecards_colorpress_icon",@"makecards_color_icon",
                                   @"makecards_fontpress_icon",@"makecards_font_icon",
                                   @"makecards_tif_effectpress_icon",@"makecards_tif_effect_icon",
                                   @"makecards_diary_press_font_icon",@"makecards_diary_font_icon",
                                   @"makecards_bubblepress_icon",@"makecards_bubble_icon",nil];
    CGFloat margin_padding = 5;
    CGFloat width =  44;
    CGFloat height = 44;
    for ( int i = 0; i < [buttonImageNameArr count]/2; i++) {
        UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(margin_padding+(margin_padding+width)*i,0, width, height)];
        [actionButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[buttonImageNameArr objectAtIndex:i*2+1]]] forState:UIControlStateNormal];
        [actionButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[buttonImageNameArr objectAtIndex:i*2]]] forState:UIControlStateHighlighted];
        [actionButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[buttonImageNameArr objectAtIndex:i*2]]] forState:UIControlStateSelected];
        [actionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [actionButton setTag:(E_TextBarAction_Type)(i+1)];
        if (i == 0) {
            [actionButton setSelected:YES];
        }

        if (i == [buttonImageNameArr count]/2 -2) {
            _textSizeButton = actionButton;
//            [_textSizeButton setHidden:YES];
        }
        if (i == [buttonImageNameArr count]/2 -1) {
            
            _bubbleButton = actionButton;
//            _bubbleButton.frame = CGRectMake(margin_padding+(margin_padding+width)*(i-1),0, width, height);
            [_bubbleButton setHidden:YES];
        }
        
        [self.contentView addSubview:actionButton];
        actionButton = nil;
    }
    if ((margin_padding + (margin_padding+width)*[buttonImageNameArr count])>_contentView.frame.size.width) {
        [_contentView setContentSize:CGSizeMake(margin_padding + (margin_padding+width)*[buttonImageNameArr count]/2,_contentView.frame.size.height)];
    }
    [self addSubview:_contentView];
    
    
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 44, 0, 44, 44)];
    [hiddenBtn addTarget:self action:@selector(hiddenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [hiddenBtn setImage:[UIImage imageNamed:@"makekards_white_turnoff_icon"] forState:UIControlStateSelected];
        [hiddenBtn setImage:[UIImage imageNamed:@"makekards_white_turnoff_icon"] forState:UIControlStateHighlighted];
    [hiddenBtn setImage:[UIImage imageNamed:@"makekards_turnoff_icon"] forState:UIControlStateNormal];
    
    [hiddenBtn setBackgroundImage:[ImageUtility imageWithStyleName:@"makekards_turnoff_text_bg_press"] forState:UIControlStateSelected];
    [hiddenBtn setBackgroundImage:[ImageUtility imageWithStyleName:@"makekards_turnoff_text_bg_press"] forState:UIControlStateHighlighted];
    [hiddenBtn setBackgroundImage:[ImageUtility imageWithStyleName:@"makekards_turnoff_text_bg_normal"] forState:UIControlStateNormal];
    
    [self addSubview:hiddenBtn];
    hiddenBtn =  nil;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [lab setBackgroundColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1]];
    [self addSubview:lab];
    lab = nil;
    
}

- (void)hiddenBtnAction:(id)sender
{

    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToHiddenAction:)]) {
        [_delegateAction responseToHiddenAction:self];
    }

}


- (void)buttonAction:(id)sender
{
    
    [_tempSelectBtn setSelected:NO];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    _tempSelectBtn = button;
    switch (button.tag) {
        case E_TextBarAction_Type_Color:
            [self buttonActionWithColor:button];
            break;
        case E_TextBarAction_Type_Font:
            [self buttonActionWithFont:button];
            break;
        case E_TextBarAction_Type_Magic:
            [self buttonActionWithMagic:button];
            break;
        case E_TextBarAction_Type_Size:
            [self buttonActionWithSize:button];
            break;
        case E_TextBarAction_Type_Bubble:
            [self buttonActionWithBubble:button];
            break;
        default:
            break;
    }
}
- (void)buttonActionWithColor:(id)sender
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToTextColorAction:)]) {
        [_delegateAction responseToTextColorAction:self];
    }
}

- (void)buttonActionWithFont:(id)sender
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToTextFontAction:)]) {
        [_delegateAction responseToTextFontAction:self];
    }
    
    
}

- (void)buttonActionWithSize:(id)sender
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToTextSizeAction:)]) {
        [_delegateAction responseToTextSizeAction:self];
    }
    
    
}


- (void)buttonActionWithMagic:(id)sender
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToTextMagicAction:)]) {
        [_delegateAction responseToTextMagicAction:self];
    }
    
}

- (void)buttonActionWithBubble:(id)sender
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(responseToTextBubbleAction:)]) {
        [_delegateAction responseToTextBubbleAction:self];
    }
    
    
}

- (void)dealloc
{
    [_contentView removeFromSuperview];
    _contentView = nil;
    _contentButtonArray = nil;
    [_tempSelectBtn removeFromSuperview];
    _tempSelectBtn = nil;
    [_bubbleButton removeFromSuperview];
    _bubbleButton = nil;
    [_textSizeButton removeFromSuperview];
    _textSizeButton = nil;


}



@end
