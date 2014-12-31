//
//  GLTextEditViewController.h
//  Tuotuo
//
//  Created by yangyong on 14-8-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
#import "CardTextToolView.h"
#import "CreateCardTextToolBar.h"
@protocol GLTextEditViewControllerDelegate;
@interface GLTextEditViewController : UIViewController<CardTextToolViewDelegate,CreateCardTextToolBarDelegate,UITextViewDelegate> {
}

@property (nonatomic, strong) UIView                   *controlView;
@property (nonatomic, strong) UIButton                 *dissMissBtn;
@property (nonatomic, strong) UILabel                  *titleLab;
@property (nonatomic, strong) UIButton                 *confirmBtn;
@property (nonatomic, strong) UIScrollView             *contentView;
@property (nonatomic, strong) UIView                   *boardView;
@property (nonatomic, strong) GCPlaceholderTextView    *editingTextField;

@property (nonatomic, strong) CreateCardTextToolBar    *textToolBar;
@property (nonatomic, strong) CardTextToolView         *textToolView;
@property (nonatomic, assign) CGFloat                  keyboardHeight;

@property (nonatomic, assign) id<GLTextEditViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL                     isEdit;
@property (nonatomic, strong) NSString                 *oldText;


@property (nonatomic, strong) UIFont                   *selectFont;
@property (nonatomic, strong) UIColor                  *selectColor;
@property (nonatomic, strong) NSString                 *fontName;
@property (nonatomic, assign) CGFloat                   fontSize;
@property (nonatomic, strong) NSDictionary             *frameDictInfo;
@property (nonatomic, assign) NSInteger                 bgStyleIndex;
@property (nonatomic, strong) GLSpecialEfficacyInfo    *speInfo;

@property (nonatomic, assign) BOOL                      isSmallCard;
@property (nonatomic, assign) NSInteger                 maxTextNum;
@property (nonatomic, strong) GLBlurBackgroundView      *backgroundView;
@property (nonatomic, strong) UIImage                   *blurImage;

- (void)setOldText:(NSString *)oldText
             color:(UIColor *)color
              font:(UIFont *)font
           speInfo:(GLSpecialEfficacyInfo *)speInfo
        thisBgtag:(NSInteger)tag;

- (void)setOldText:(NSString *)oldText
             color:(UIColor *)color
              font:(UIFont *)font
           speInfo:(GLSpecialEfficacyInfo *)speInfo
         styleInfo:(NSDictionary *)dict
         thisBgtag:(NSInteger)tag;

- (void)setBlurImage:(UIImage *)blurImage;

@end


@protocol GLTextEditViewControllerDelegate <NSObject>

- (void)didCreateTextView:(GLTextEditViewController *)sender;

@end