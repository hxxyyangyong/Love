//
//  CreateCardTextToolBar.h
//  Tuotuo
//
//  Created by yongyang on 14-4-30.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum e_textBarAction_type
{
    E_TextBarAction_Type_Color = 1,
    E_TextBarAction_Type_Font = 2,
    E_TextBarAction_Type_Magic = 3,
    E_TextBarAction_Type_Size = 4,
    E_TextBarAction_Type_Bubble = 5
}E_TextBarAction_Type;


@protocol CreateCardTextToolBarDelegate;



@interface CreateCardTextToolBar : UIView


@property (nonatomic, strong) UIScrollView  *contentView;
@property (nonatomic, strong) NSArray       *contentButtonArray;
@property (nonatomic, assign) id<CreateCardTextToolBarDelegate> delegateAction;
@property (nonatomic, weak) UIButton      *tempSelectBtn;
@property (nonatomic, weak) UIButton      *bubbleButton;
@property (nonatomic, weak) UIButton      *textSizeButton;

@end


@protocol CreateCardTextToolBarDelegate <NSObject>

- (void)responseToTextColorAction:(CreateCardTextToolBar *)sender;
- (void)responseToTextFontAction:(CreateCardTextToolBar *)sender;
- (void)responseToTextSizeAction:(CreateCardTextToolBar *)sender;
- (void)responseToTextMagicAction:(CreateCardTextToolBar *)sender;
- (void)responseToTextBubbleAction:(CreateCardTextToolBar *)sender;

- (void)responseToHiddenAction:(CreateCardTextToolBar *)sender;

@end