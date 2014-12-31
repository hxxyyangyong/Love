//
//  GLMeituFreeContentView.h
//  Tuotuo
//
//  Created by yangyong on 14-8-21.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
@protocol GLMeituFreeContentViewDelegate;

@interface GLMeituFreeContentView : UIView<ZDStickerViewDelegate>

@property (nonatomic, strong) ZDStickerView *firstView;
@property (nonatomic, strong) ZDStickerView *secondView;
@property (nonatomic, strong) ZDStickerView *thirdView;
@property (nonatomic, strong) ZDStickerView *fourthView;
@property (nonatomic, strong) ZDStickerView *fifthView;


@property (nonatomic, strong) NSArray           *assets;
@property (nonatomic, strong) NSMutableArray    *contentViewArray;
@property (nonatomic, strong) NSString          *styleFileName;
@property (nonatomic, assign) NSInteger         styleIndex;
@property (nonatomic, strong) NSDictionary      *styleDict;

@property (nonatomic, strong) UIImageView       *backImageView;
@property (nonatomic, strong) ZDStickerView     *selectedView;
@property (nonatomic, weak) id<GLMeituFreeContentViewDelegate> delegateEdit;
- (void)initData;
- (void)setBackgroundImage:(UIImage *)image;
- (void)hiddenAllEditControls;
@end

@protocol GLMeituFreeContentViewDelegate <NSObject>

- (void)stickerIsEdit;

@end