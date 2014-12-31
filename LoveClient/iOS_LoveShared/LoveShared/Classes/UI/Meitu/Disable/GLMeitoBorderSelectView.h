//
//  GLMeitoBorderSelectView.h
//  Tuotuo
//
//  Created by yangyong on 14-7-22.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GLMeitoBorderSelectViewDelegate;
@interface GLMeitoBorderSelectView : UIView

//@property (nonatomic, strong) UIImageView          *BorderImageView;
@property (nonatomic, strong) GLAsyncImageView     *borderImageView;
@property (nonatomic, strong) UIImageView          *levelFlag;
@property (nonatomic, strong) UILabel              *borderNameLab;
@property (nonatomic, strong) UIImageView          *lockImageView;
@property (nonatomic, strong) GLEntity_Resource    *resourceInfo;
@property (nonatomic, strong) NSDictionary         *borderDict;
@property (nonatomic, assign) NSInteger             levelNum;
@property (nonatomic, strong) UIButton              *downLoadBtn;
@property (nonatomic, assign) BOOL                 isEnable;
@property (nonatomic, weak)   id<GLMeitoBorderSelectViewDelegate> delegateSelect;
@property (nonatomic, strong) NSString              *cacheKey;
@property (nonatomic, assign) BOOL                  isEmpty;
- (void)setNativeResourceImage:(UIImage *)image;

- (void)setResourceInfo:(GLEntity_Resource *)resourceInfo
              userLevel:(NSInteger)userLevel;

@end

@protocol  GLMeitoBorderSelectViewDelegate <NSObject>

- (void)didSelectBorderWith:(GLMeitoBorderSelectView *)sender;

- (void)downloadStartWith:(GLMeitoBorderSelectView *)sender;
- (void)downloadEndWith:(GLMeitoBorderSelectView *)sender;
- (void)downloadErrorWith:(GLMeitoBorderSelectView *)sender;

@end