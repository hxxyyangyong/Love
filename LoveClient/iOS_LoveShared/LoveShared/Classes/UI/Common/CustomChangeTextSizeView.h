//
//  CustomChangeTextSizeView.h
//  TestAPP
//
//  Created by yangyong on 14-6-20.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSpecialEfficacyInfo.h"
#import "GLColorView.h"
@protocol CustomChangeTextSizeViewDelegate;
@interface CustomChangeTextSizeView : UITextView<UITextViewDelegate>
{
    NSString *placeholder;
    UIColor *placeholderColor;
}
@property (nonatomic, strong) UILabel   *placeHolderLabel;
@property (nonatomic, strong) NSString  *placeholder;
@property (nonatomic, strong) UIColor   *placeholderColor;
@property (nonatomic, strong) GLSpecialEfficacyInfo  *speInfo;
@property (nonatomic, assign) BOOL      isNotVerCenter;
@property (nonatomic, assign) BOOL      isNotChangeSize;
@property (nonatomic, assign) BOOL      isNotPlaceHolder;
@property (nonatomic, assign) NSInteger     lineNumber;
@property (nonatomic, assign) id<CustomChangeTextSizeViewDelegate> changeDelegate;

- (void)resetFontAndSize;
-(void)textChanged:(NSNotification*)notification;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end


@protocol CustomChangeTextSizeViewDelegate <NSObject>

- (void)changeSizeWithTextView:(id)sender;

@end