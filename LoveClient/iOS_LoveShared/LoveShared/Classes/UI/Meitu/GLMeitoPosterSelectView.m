//
//  GLMeitoPosterSelectView.m
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLMeitoPosterSelectView.h"

@implementation GLMeitoPosterSelectView

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
    _posterImageView = [[GLAsyncImageView alloc] initWithFrame:self.bounds];
    _posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    _posterImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_posterImageView];
    
    
    _lockImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    //    _lockImageView.image = [UIImage imageNamed:@"lock"];
    [_lockImageView setBackgroundColor:[[UIColor colorWithHexString:@"1d1d1d"] colorWithAlphaComponent:0.4]];
    //    [_lockImageView setHidden:YES];
  [self addSubview:_lockImageView];
    
    
    _posterNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 22, self.bounds.size.width, 22)];
    [_posterNameLab setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
    [_posterNameLab setFont:[UIFont boldSystemFontOfSize:12.f]];
    [_posterNameLab.layer setShadowColor:[UIColor blackColor].CGColor];
    [_posterNameLab.layer setShadowOffset:CGSizeMake(1, 1)];
    [_posterNameLab setTextColor:[UIColor redColor]];
    [_posterNameLab setTextAlignment:UITextAlignmentLeft];
//    [self addSubview:_posterNameLab];
    
    
    
    
    _levelFlag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.width/2)];
    [_levelFlag setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_levelFlag];
    [self bringSubviewToFront:_levelFlag];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBaseboardAction:)];
    [self setUserInteractionEnabled: YES];
    [self addGestureRecognizer:tapRecognizer];
    
    _downLoadBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 24)/2.0f, (self.frame.size.height - 26)/2.0f, 24, 26)];
 [_downLoadBtn setImage:[ImageUtility imageWithStyleName:@"btn_download_icon.png"] forState:UIControlStateNormal];
    [_downLoadBtn setImage:[ImageUtility imageWithStyleName:@"btn_download_press_icon.png"] forState:UIControlStateHighlighted];
    [_downLoadBtn setImage:[ImageUtility imageWithStyleName:@"btn_download_press_icon.png"] forState:UIControlStateSelected];
    [_downLoadBtn setBackgroundColor:[UIColor clearColor]];
    [_downLoadBtn addTarget:self action:@selector(downLoadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_downLoadBtn];
    
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.cornerRadius = 2.0f;
    
    
}
- (void)downLoadAction:(id)sender
{
//    if (self.resourceInfo.resourceContent) {
//        GLGetResourceItem *item  = [[GLGetResourceItem alloc] init];
//        item.resourceInfo = self.resourceInfo;
//        item.resourceUsedType = E_ImageUsedType_Other;
//        item.resourceSuffix = @"png";
//        item.resourceDownSuccessCallBack = [BCInstanceMethodCallback callBackWithTarget:self action:@selector(successFull:)];
//        item.resourceDownFailedCallBack = [BCInstanceMethodCallback callBackWithTarget:self action:@selector(failedCallback:)];
//        
//        [item loadDownLoadResourceWithResourceInfo:self.resourceInfo];
//        
//        self.cacheKey = [NSString urlcombineWithBefore:[item.resourceCache cachePath] after:[item fileInfoCacheKey]];
//        if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(downloadStartWith:)]) {
//            [_delegateSelect downloadStartWith:self];
//        }
//        
//    }
}

- (void)successFull:(id)sender
{
    self.isEnable = YES;
    self.posterDict = [NSDictionary dictionaryWithObjectsAndKeys:self.cacheKey,@"PosterImagePath", self.resourceInfo.remake,@"BoardColor", nil];
    self.downLoadBtn.hidden = YES;
    [_lockImageView setHidden:YES];
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(downloadEndWith:)]) {
        [_delegateSelect downloadEndWith:self];
    }
}

- (void)failedCallback:(id)sender
{
    self.isEnable = NO;
    self.downLoadBtn.hidden = NO;
    [_lockImageView setHidden:NO];
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(downloadErrorWith:)]) {
        [_delegateSelect downloadErrorWith:self];
    }
}


- (void)setNativeResourceImage:(UIImage *)image
{
    
    [_levelFlag setHidden:YES];
    [_lockImageView setHidden:YES];
    [_downLoadBtn setHidden:YES];
    [_posterImageView setImage:image];
    self.isEnable = YES;
    self.isEmpty = YES;
}






- (void)setResourceInfo:(GLEntity_Resource *)resourceInfo
              userLevel:(NSInteger)userLevel
{
    
    self.resourceInfo= resourceInfo;
    [_posterImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"poster_list_%lld",resourceInfo.resourceId]]];
    _lockImageView.hidden = YES;
    _isEnable = YES;
    self.posterDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"poster_up_%lld",resourceInfo.resourceId],@"PosterImagePath", self.resourceInfo.remake,@"BoardColor", nil];

    
//    self.posterNameLab.text = [NSString stringWithFormat:@"¥%.2lf",self.resourceInfo.price];
//    self.levelNum = self.resourceInfo.level;
//    [self.levelFlag setImage:[UIImage imageNamed:[NSString stringWithFormat:@"makecard_lv%ld_baseboard_icon",self.levelNum]]];
//    if (userLevel >= self.levelNum) {
//        [_levelFlag setHidden:YES];
//        [_downLoadBtn setHidden:NO];
//    }else{
//        [_levelFlag setHidden:NO];
//        [_downLoadBtn setHidden:YES];
//    }
    
//    GLGetResourceItem *item  = [[GLGetResourceItem alloc] init];
//    item.resourceInfo = self.resourceInfo;
//    item.resourceUsedType = E_ImageUsedType_Other;
//    item.resourceSuffix = @"png";
//    if (item.isDownloaded) {
//        [_downLoadBtn setHidden:YES];
//        self.cacheKey = [NSString urlcombineWithBefore:[item.resourceCache cachePath] after:[item fileInfoCacheKey]];
//        self.posterDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"poster_up_%lld",resourceInfo.resourceId],@"PosterImagePath", self.resourceInfo.remake,@"BoardColor", nil];
//        self.isEnable = YES;
//        [_lockImageView setHidden:YES];
//    }else{
//        self.cacheKey = nil;
//        self.isEnable = NO;
//        self.posterDict = nil;
//        [_lockImageView setHidden:NO];
//    }
    
}



- (void)selectBaseboardAction:(UITapGestureRecognizer *)recognizer
{
    
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectPosterWith:)]) {
        [_delegateSelect didSelectPosterWith:self];
    }
}


- (void)dealloc
{
    
    [_posterImageView removeFromSuperview];
    [_levelFlag  removeFromSuperview];
    [_posterNameLab  removeFromSuperview];
    [_lockImageView removeFromSuperview];
    [_downLoadBtn removeFromSuperview];
    
    _posterImageView = nil;
    _levelFlag  = nil;
    _posterNameLab  = nil;
    _lockImageView = nil;
    _resourceInfo  = nil;
    _posterDict = nil;
    _downLoadBtn = nil;
    _cacheKey = nil;
}
@end
