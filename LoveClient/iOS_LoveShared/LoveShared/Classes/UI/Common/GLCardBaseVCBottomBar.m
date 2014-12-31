
//
//  GLCardBaseVCBottomBar.m
//  Tuotuo
//
//  Created by yangyong on 14-6-27.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLCardBaseVCBottomBar.h"



@implementation GLCardBaseVCBottomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initResource];
    }
    return self;
}

- (void)setButtonInfoArray:(NSArray *)buttonInfoArray
{
    _buttonInfoArray = buttonInfoArray;
    if([_buttonInfoArray count]>0){
        NSDictionary *imageDict = [buttonInfoArray objectAtIndex:0];
        NSString *buttonTitle = D_LocalizedCardString([imageDict objectForKey:@"ButtonTitle"]);
        NSString *buttonImageNName = [imageDict objectForKey:@"ImageName_Normal"];
//        NSString *buttonImageHName = [imageDict objectForKey:@"ImageName_HighLight"];
//        NSString *buttonBackImageNName = [imageDict objectForKey:@"BackgroundImageName_Normal"];
//        NSString *buttonBackImageHName = [imageDict objectForKey:@"BackgroundImageName_HighLight"];
        UIImage *normalImage = [UIImage imageNamed:buttonImageNName];
        //[ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonImageNName];
//        UIImage *highLightImage = [ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonImageHName];
        [_flagView.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [_flagView setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
        [_flagView setTitleEdgeInsets:UIEdgeInsetsMake(14.0,
                                                    -_flagView.titleLabel.bounds.size.width-normalImage.size.width,
                                                    0.0,
                                                    0.0)];
        [_flagView setImageEdgeInsets:UIEdgeInsetsMake(-24,
                                                    (_flagView.bounds.size.width - normalImage.size.width)/2,
                                                    0.0,
                                                    (_flagView.bounds.size.width - normalImage.size.width)/2)];
        [_flagView setTitle:buttonTitle forState:UIControlStateNormal];
        [_flagView setImage:normalImage forState:UIControlStateNormal];
        [_flagView setEnabled:NO];
    }
    [self initToolbarView];
    
}


- (void)initResource
{
    
    self.backgroundColor = [[UIColor colorWithHexString:@"#1d1d1d"] colorWithAlphaComponent:0.9];
    //[UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:0.8];
    _flagView = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              58,
                                                              58)];
    [_flagView.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [_flagView setContentMode:UIViewContentModeCenter];
    [_flagView setTitleEdgeInsets:UIEdgeInsetsMake(14.0,
                                                -58,
                                                0.0,
                                                0.0)];
    [_flagView setImageEdgeInsets:UIEdgeInsetsMake(-24,
                                                0,
                                                0.0,
                                                0.0)];
//    [_flagView setBackgroundColor:[[UIColor colorWithHexString:@"#454545"] colorWithAlphaComponent:0.8]];
    [_flagView setBackgroundImage:[UIImage imageNamed:@"toolbar_title_flagview_bg_icon"] forState:UIControlStateNormal];
    [self addSubview:_flagView];
    
    _buttonSrcView = [[UIScrollView alloc] initWithFrame:CGRectMake(58,
                                                                    0,
                                                                    self.bounds.size.width - 58,
                                                                    self.bounds.size.height)];
    [self addSubview:_buttonSrcView];
}


- (void)initToolbarView
{
    
    //数组第一个是标示的图片
    for (int i = 1; i < _buttonInfoArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i-1)*(116/2.0+1) + 0, 0, 116/2.0, 116/2.0)];//+(i==0?7:0)
        button.tag = i;
        NSDictionary *dict = [_buttonInfoArray objectAtIndex:i];
        NSString *buttonTitle = D_LocalizedCardString([dict objectForKey:@"ButtonTitle"]);
        NSString *buttonImageNName = [dict objectForKey:@"ImageName_Normal"];
        NSString *buttonImageHName = [dict objectForKey:@"ImageName_HighLight"];
        NSString *buttonBackImageNName = [dict objectForKey:@"BackgroundImageName_Normal"];
        NSString *buttonBackImageHName = [dict objectForKey:@"BackgroundImageName_HighLight"];

        UIImage *normalImage = [UIImage imageNamed:buttonImageNName];
        //[ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonImageNName];
        UIImage *highLightImage = [UIImage imageNamed:buttonImageHName];
        //[ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonImageHName];
        
       
        
        if(self.moudleType == E_ModuleType_Eassy||self.moudleType == E_ModuleType_Diary){
            
            UIImage *normalBackImage = [ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonBackImageNName];
            UIImage *highLightBackImage = [ImageUtility imageWithPath:[[NSBundle mainBundle] resourcePath] imageName:buttonBackImageHName];
            [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
            [button setBackgroundImage:highLightBackImage forState:UIControlStateHighlighted];
            [button setBackgroundImage:highLightBackImage forState:UIControlStateSelected];
        }
        [button setImage:normalImage forState:UIControlStateNormal];
        [button setImage:highLightImage forState:UIControlStateHighlighted];
        [button setImage:highLightImage forState:UIControlStateSelected];
        
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(14.0,
                                                    -button.titleLabel.bounds.size.width-normalImage.size.width,
                                                    0.0,
                                                    0.0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-24,
                                                    (button.bounds.size.width - normalImage.size.width)/2,
                                                    0.0,
                                                    (button.bounds.size.width - normalImage.size.width)/2)];
        
            
       
        [button setTitleColor:[UIColor colorWithHexString:@"#cbcbcb"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#1fbba6"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithHexString:@"#1fbba6"] forState:UIControlStateSelected];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:UITextAlignmentCenter];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            self.selectButton = button;
            [button setSelected:YES];
        }
        [_buttonSrcView addSubview:button];
        button = nil;
    }
    [_buttonSrcView setContentSize:CGSizeMake((_buttonInfoArray.count -1) * (116/2.0),CGRectGetHeight(_buttonSrcView.frame))];
    [self didselectWithTag:1];
    
}


- (void)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    [self.selectButton setSelected:NO];
    [button setSelected:YES];
    self.selectButton = button;
    [self didselectWithTag:tag];
   
}

- (void)didselectWithTag:(NSInteger)tag
{
    if (_delegateAction && [_delegateAction respondsToSelector:@selector(didSelectWithButtonTag:info:)]) {
        [_delegateAction didSelectWithButtonTag:tag info:[_buttonInfoArray objectAtIndex:tag]];
    }
}




- (void)restButtonStatus
{
    

}


- (void)dealloc
{
    for (UIView *view  in _buttonSrcView.subviews) {
        [view removeFromSuperview];
    }

    [_flagView removeFromSuperview];
    _flagView = nil;
    _buttonInfoArray = nil;
    [_buttonSrcView removeFromSuperview];
    _buttonSrcView = nil;
    _selectButton = nil;

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
