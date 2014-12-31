//
//  GLCardBaseViewController.h
//  Tuotuo
//
//  Created by yangyong on 14-6-27.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDStickerView.h"
#import "ImageUtility.h"
#import "CardTextView.h"
#import "CardTextToolView.h"
#import "CRNavigationController.h"
//#import "CardCreateSmallCardViewController.h"
#import "GLCardBaseVCBottomBar.h"
#import "CardTextView.h"
#define D_ToolbarWidth      44
@interface GLCardBaseViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,GLCardBaseVCBottomBarDelegate,ZDStickerViewDelegate>

@property (nonatomic, strong) UIScrollView          *contentView;
@property (nonatomic, strong) UIImageView           *backgroundView;
@property (nonatomic, strong) CardTextView          *contentTextView;
//@property (nonatomic, strong) UIScrollView          *toolBarView;
@property (nonatomic, strong) GLCardBaseVCBottomBar *toolBarView;
@property (nonatomic, strong) NSArray               *buttonInfoArray;
@property (nonatomic, strong) GLBlurBackgroundView  *blurImageView;

//心情
@property (nonatomic, strong) ZDStickerView         *editingTextView;

//随笔的装饰按钮
@property (nonatomic, strong) UIButton              *decorationButton;
@property (nonatomic, assign) CGFloat               keyboardHeight;
- (void)initResource;
- (void)initTextView;
- (CGSize)calcContentSize;
- (UIImage *)captureScrollView:(UIScrollView *)scrollView;

@end
