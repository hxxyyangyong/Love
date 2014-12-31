//
//  CardTextToolView.h
//  Tuotuo
//
//  Created by yangyong on 14-5-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZColorPicker.h"
#import "KZUnitSlider.h"
#import "GLColorView.h"
#import "GLSpecialEfficacyInfo.h"
#import "CustomChangeTextSizeView.h"
typedef enum e_texttool_type
{
    E_TextTool_Type_Picker = 1,
    E_TextTool_Type_Font = 2,
    E_TextTool_Type_Magic = 3,
    E_TextTool_Type_Size = 4,
    E_TextTool_Type_Bubble = 5


}E_TextTool_Type;


@protocol CardTextToolViewDelegate;
@interface CardTextToolView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView                  *contentView;
@property (nonatomic, strong) UITableView                   *fontTableView;
@property (nonatomic, strong) KZColorPicker                 *colorPicker;
@property (nonatomic, strong) UIView                        *bubbleView;
@property (nonatomic, strong) UIView                        *magicContentView;
@property (nonatomic, strong) UIView                        *magicView;

//选择之后的信息
@property (nonatomic, strong) UIColor                       *selectColor;
@property (nonatomic, strong) UIFont                        *selectFont;
@property (nonatomic, strong) NSString                      *fontName;
@property (nonatomic, assign) CGFloat                       fontSize;
@property (nonatomic, strong) NSDictionary                  *styleInfo;
@property (nonatomic, assign) NSInteger                     thisbuttonTag;
@property (nonatomic, strong) GLSpecialEfficacyInfo         *speInfo;

@property (nonatomic, weak)   id<CardTextToolViewDelegate>  delegateValueChange;
@property (nonatomic, strong) NSMutableArray                *fontNameArray;

@property (nonatomic, assign) E_TextTool_Type showtype;
@property (nonatomic, strong) NSString        *text;


@property (nonatomic, strong) UIView           *sizeView;
@property (nonatomic, strong) UISlider          *slider;
@property (nonatomic, strong) UILabel          *leftALab;
@property (nonatomic, strong) UILabel          *rightALab;


@property (nonatomic, strong) UIButton          *tempbutton;
//气泡背景的样式
@property (nonatomic, strong) NSDictionary      *bgDict;
//特效的数组
@property (nonatomic, strong) NSMutableArray    *spArray;






- (void)showViewWithType:(E_TextTool_Type)type;

@end


@protocol CardTextToolViewDelegate <NSObject>


- (void)colorWithChanged:(UIColor *)color;
- (void)fontWithChanged:(UIFont *)font;
- (void)borderColorWithChanged:(UIColor *)color;
- (void)bgImageWithChanged:(NSDictionary *)styleInfo;
- (void)effectChange:(GLSpecialEfficacyInfo *)info;


- (void)valueChangedWithView:(CardTextToolView *)toolView;
- (void)textColorWithChanged:(UIColor *)color;
- (void)textFontNameWithChanged:(NSString *)fontName;
- (void)textFontSizeWithChanged:(CGFloat)fontSize;
- (void)textFrameInfoWithChanged:(NSDictionary *)dict andTag:(NSInteger)tag;
- (void)textEffectWithChanged:(GLSpecialEfficacyInfo *)speinfo;


@end





