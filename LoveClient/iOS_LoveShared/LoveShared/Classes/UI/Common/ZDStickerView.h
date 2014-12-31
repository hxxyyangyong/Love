//
//  ZDStickerView.h
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetView.h"
#import "CardTextView.h"

@protocol ZDStickerViewDelegate;

/**
                ImageView = 1,图片
                TextView = 2,文本
                Baseboard = 3,底纹
                Decoration = 4,装饰
                Pet = 5,玩偶
                Music = 6,音乐 :正数是资源  负数是音乐接口
                Record = 7,录音
                SpecialEfficacy = 8 特效
 */

typedef enum e_contentViewType
{
    E_ContentViewType_ImageView = 1,
    E_ContentViewType_TextView = 2,
    E_ContentViewType_Baseboard = 3,
    E_ContentViewType_Decoration = 4,
    E_ContentViewType_Pet = 5,
    E_ContentViewType_Music = 6,
    E_ContentViewType_Record = 7,
    E_ContentViewType_SpecialEfficacy = 8
}E_ContentViewType;


@interface ZDStickerView : UIView<UIGestureRecognizerDelegate>
{
//    SPGripViewBorderView *borderView;
}
@property CGFloat lastRotation;
@property (assign, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView    *borderView;
//@property (strong, nonatomic) SPGripViewBorderView *borderView;
@property (nonatomic) BOOL preventsPositionOutsideSuperview; //default = YES
@property (nonatomic) BOOL preventsResizing; //default = NO
@property (nonatomic) BOOL preventsDeleting; //default = NO

@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic) CGFloat   maxWidth;
@property (nonatomic) CGFloat   maxHeight;


@property (nonatomic, assign) E_ContentViewType contentType;
@property (nonatomic, assign) NSInteger         index;
@property (nonatomic, assign) CGFloat           angleValue;


//control
@property (strong, nonatomic) UIImageView *resizingControl;
@property (strong, nonatomic) UIImageView *deleteControl;
@property (strong, nonatomic) UIImageView *editControl;

@property (assign, nonatomic) id <ZDStickerViewDelegate> delegate;

@property (assign, nonatomic) BOOL          isNotEditable;
@property (assign, nonatomic) BOOL          isNotMoveEnable;
@property (assign, nonatomic) BOOL          isNotExpend;
@property (assign, nonatomic) BOOL          isNotPinchExpend;
@property (assign, nonatomic) BOOL          isNotRotationExpend;


@property (strong, nonatomic) UIImageView       *imageView;
@property (strong, nonatomic) CardTextView      *cardTextView;
@property (nonatomic, assign) BOOL          isShowDeleteControl;
@property (nonatomic, assign) BOOL          isShowResizingControl;
@property (nonatomic, assign) BOOL          isShowBoarderControl;
@property (nonatomic, assign) BOOL          isShowEditControl;



- (void)setSelectRedBoardColor;

//- (void)setSelect;
//- (void)setNormal;

- (void)hideEditingHandles;
- (void)showEditingHandles;

- (void)showBoarderView;
- (void)hiddenBoarderView;





@end

@protocol ZDStickerViewDelegate <NSObject>
@required
@optional


- (void)stickerViewDidBeginEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidEndEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidCancelEditing:(ZDStickerView *)sticker;
- (void)stickerViewDidClose:(ZDStickerView *)sticker;

- (void)longPressed:(ZDStickerView *)sticker;
- (void)doubleTaped:(ZDStickerView *)sticker;
- (void)allSingleTap:(ZDStickerView *)sticker;
- (void)textFrameChanged;

/**
 *  编辑按钮的点击
 *
 *  @param userResizableView
 */
- (void)stickerViewDidEdit:(ZDStickerView *)sticker;



@end





