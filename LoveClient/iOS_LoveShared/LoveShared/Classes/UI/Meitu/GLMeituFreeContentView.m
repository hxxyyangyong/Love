//
//  GLMeituFreeContentView.m
//  Tuotuo
//
//  Created by yangyong on 14-8-21.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLMeituFreeContentView.h"

@implementation GLMeituFreeContentView

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
    self.backgroundColor = [UIColor whiteColor];
    
    _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_backImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_backImageView];
    
    
    _firstView = [[ZDStickerView alloc] initWithFrame:CGRectZero];
    _secondView = [[ZDStickerView alloc] initWithFrame:CGRectZero];
    _thirdView = [[ZDStickerView alloc] initWithFrame:CGRectZero];
    _fourthView = [[ZDStickerView alloc] initWithFrame:CGRectZero];
    _fifthView = [[ZDStickerView alloc] initWithFrame:CGRectZero];
    [self resetAllView];
    if (_contentViewArray == nil) {
        _contentViewArray = [NSMutableArray arrayWithCapacity:5];
    }
    
    _firstView.tag = 1;
    _secondView.tag = 2;
    _thirdView.tag = 3;
    _fourthView.tag = 4;
    _fifthView.tag = 5;
    
    
    [_contentViewArray addObject:_firstView];
    [_contentViewArray addObject:_secondView];
    [_contentViewArray addObject:_thirdView];
    [_contentViewArray addObject:_fourthView];
    [_contentViewArray addObject:_fifthView];
    
    
    [self addSubview:_firstView];
    [self addSubview:_secondView];
    [self addSubview:_thirdView];
    [self addSubview:_fourthView];
    [self addSubview:_fifthView];

    
}

- (void)resetAllView
{
    [self styleSettingWithView:_firstView];
    [self styleSettingWithView:_secondView];
    [self styleSettingWithView:_thirdView];
    [self styleSettingWithView:_fourthView];
    [self styleSettingWithView:_fifthView];
    
}


- (void)setBackgroundImage:(UIImage *)image
{
    [_backImageView setImage:image];
}


- (void)initData
{

    for (int i = 0; i < [self.assets count]; i++) {
        ALAsset *asset = [self.assets objectAtIndex:i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        CGSize size = image.size;
        if (size.width + 25> self.frame.size.width) {
            size.width = self.frame.size.width - 25;
            //image.size.width/((int)((image.size.width/(self.contentView.frame.size.width-25))+1));
            size.height = size.width*(image.size.height/image.size.width);
        }
        if (size.height  + 25 > self.frame.size.height) {
            size.height = self.frame.size.height -25;
            //image.size.height/((int)((image.size.height/(self.contentView.frame.size.height-25))+1));
            size.width = image.size.width*(size.height/image.size.height);
        }
        
        if (i < [self.assets count]) {
            ZDStickerView *tempView = (ZDStickerView *)[self.contentViewArray objectAtIndex:i];
            tempView.delegate = self;
            tempView.frame = CGRectMake(0, 10+i*10, size.width+25, size.height+25);
            UIImageView *imageView = tempView.imageView;
            if (imageView == nil) {
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                          0, size.width-25, size.height-25)];
            }
            tempView.contentView = imageView;
            [imageView setImage:image];
            [tempView hideEditingHandles];
            tempView.isShowBoarderControl = NO;
            tempView.isShowResizingControl = YES;
        }
    }
}



#pragma mark
#pragma mark 可移动的图的拖动delegate
- (void)stickerViewDidBeginEditing:(ZDStickerView *)sticker
{

    if (_delegateEdit && [_delegateEdit respondsToSelector:@selector(stickerIsEdit)]) {
        [_delegateEdit stickerIsEdit];
    }
}


- (void)longPressed:(ZDStickerView *)sticker
{
    [self sendSubviewToBack:sticker];
    [self sendSubviewToBack:self.backImageView];
}

- (void)allSingleTap:(ZDStickerView *)sticker
{
    [self.selectedView hideEditingHandles];
    if(sticker != self.selectedView){
        self.selectedView = sticker;
        [sticker showEditingHandles];
    }
    
}




- (void)styleSettingWithView:(ZDStickerView *)view
{
    view.frame = CGRectZero;
    view.delegate = self;
    view.contentView = nil;
}


- (void)releaseViewWith:(ZDStickerView *)view
{
    [view removeFromSuperview];
    view = nil;
    view.delegate = nil;
}

- (void)dealloc
{
    [_contentViewArray removeAllObjects];
    _contentViewArray = nil;
    _assets = nil;
    _styleFileName = nil;
    _styleDict = nil;
    
    [self releaseViewWith:_firstView];
    [self releaseViewWith:_secondView];
    [self releaseViewWith:_thirdView];
    [self releaseViewWith:_fourthView];
    [self releaseViewWith:_fifthView];
    
    [_backImageView removeFromSuperview];
    _backImageView = nil;
    
    NSLog(@"meitu content view release");
}

- (void)hiddenAllEditControls
{
    [_firstView hideEditingHandles];
    [_secondView hideEditingHandles];
    [_thirdView hideEditingHandles];
    [_fourthView hideEditingHandles];
    [_fifthView hideEditingHandles];

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
