//
//  GLMeitoPosterSelectView.h
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GLMeitoPosterSelectViewDelegate;
@interface GLMeitoPosterSelectView : UIView

//@property (nonatomic, strong) UIImageView          *PosterImageView;
@property (nonatomic, strong) GLAsyncImageView     *posterImageView;
@property (nonatomic, strong) UIImageView          *levelFlag;
@property (nonatomic, strong) UILabel              *posterNameLab;
@property (nonatomic, strong) UIImageView          *lockImageView;
@property (nonatomic, strong) GLEntity_Resource    *resourceInfo;
@property (nonatomic, strong) NSDictionary         *posterDict;
@property (nonatomic, assign) NSInteger             levelNum;
@property (nonatomic, strong) UIButton              *downLoadBtn;
@property (nonatomic, assign) BOOL                 isEnable;
@property (nonatomic, weak)   id<GLMeitoPosterSelectViewDelegate> delegateSelect;
@property (nonatomic, strong) NSString              *cacheKey;
@property (nonatomic, assign) BOOL                  isEmpty;
- (void)setNativeResourceImage:(UIImage *)image;

- (void)setResourceInfo:(GLEntity_Resource *)resourceInfo
              userLevel:(NSInteger)userLevel;

@end

@protocol  GLMeitoPosterSelectViewDelegate <NSObject>

- (void)didSelectPosterWith:(GLMeitoPosterSelectView *)sender;

- (void)downloadStartWith:(GLMeitoPosterSelectView *)sender;
- (void)downloadEndWith:(GLMeitoPosterSelectView *)sender;
- (void)downloadErrorWith:(GLMeitoPosterSelectView *)sender;
@end