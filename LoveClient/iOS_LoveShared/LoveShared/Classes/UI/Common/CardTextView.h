//
//  CardTextView.h
//  Tuotuo
//
//  Created by yangyong on 14-5-12.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FXLabel.h"
#import "GCPlaceholderTextView.h"
#import "GLSpecialEfficacyInfo.h"
#import "GLColorView.h"
#define D_CardTextView_DefaultWidth     210
#define D_CardTextView_DefaultHeight    50

typedef enum e_cardtextviewtype
{
    E_CardTextViewType_Normal = 1,
    E_CardTextViewType_BG = 2,
    E_CardTextViewType_SpecialEfficacy = 3
}E_CardTextViewType;



@interface CardTextView : UIView<UITextViewDelegate>
{

}
@property (nonatomic, strong) UIImageView                   *bgView;
@property (nonatomic, strong) GCPlaceholderTextView         *textView;
@property (nonatomic, strong) NSDictionary                  *styleInfo;
@property (nonatomic, strong) UIColor                       *selectedColor;
@property (nonatomic, strong) UIFont                        *selectedFont;

@property (nonatomic, assign) BOOL                          isNotExpend;
@property (nonatomic, strong) GLSpecialEfficacyInfo         *speInfo;
@property (nonatomic, assign) NSInteger                     bgStyleIndex;
@property (nonatomic, assign) NSInteger                     maxTextNum;

- (id)initWithFrame:(CGRect)frame
          textColor:(UIColor *)color
               font:(UIFont *)font;


- (void)setText:(NSString *)text
          color:(UIColor *)color
           font:(UIFont *)font
        speInfo:(GLSpecialEfficacyInfo *)info
      styleInfo:(NSDictionary *)styleInfo
   bgStyleIndex:(NSInteger)bgStyleIndex;

- (void)resetFrameWithInfo:(NSDictionary *)dict bgStyleIndex:(NSInteger)bgStyleIndex;
- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo;
- (void)resetFontAndSize;


/**
 * 将文字提炼成图片
 */
- (UIImage *)cutImage;

+ (UIImage *)createGradientImageWithRect:(CGSize)size gadientColors:(NSArray *)gadientColors gradientStartPoint:(CGPoint)gradientStartPoint gradientEndPoint:(CGPoint)gradientEndPoint;

//- (void)showBorder;
//- (void)hiddenBorder;
@end


