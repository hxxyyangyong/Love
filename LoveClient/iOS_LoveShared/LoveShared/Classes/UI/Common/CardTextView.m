//
//  CardTextView.m
//  Tuotuo
//
//  Created by yangyong on 14-5-12.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "CardTextView.h"

@interface CardTextView()


@end

@implementation CardTextView

- (id)initWithFrame:(CGRect)frame textColor:(UIColor *)color font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (color == nil) {
            self.selectedColor = [UIColor whiteColor];
        }else{
            self.selectedColor = color;
        }
        if (font == nil) {
            self.selectedFont = [UIFont systemFontOfSize:15.0f];
        }else{
            self.selectedFont = font;
        }
        
        [self initResource];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initResource];
    }
    return self;
}



- (void)initResource
{
    if (self.selectedColor == nil) {
        self.selectedColor = [UIColor whiteColor];
    }
    if (self.selectedFont == nil) {
        self.selectedFont = [UIFont systemFontOfSize:20.0f];
    }
    
    
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;

    
    _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    self.backgroundColor  = [UIColor clearColor];
    

    _textView = [[GCPlaceholderTextView alloc] initWithFrame:self.bounds];
	_textView.font = self.selectedFont;
//	_textView.delegate = self;
//    _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    _textView.backgroundColor = [UIColor clearColor];
//    _textView.placeholder = @"点击输入文字";
    _textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    _textView.textColor = self.selectedColor;
    [_textView setEditable:NO];
    [_textView setScrollEnabled:NO];
    [_textView setUserInteractionEnabled:NO];
    [_textView clearSpecialEfficacy];
    [self addSubview:_bgView];
    [self addSubview:_textView];
    
    self.maxTextNum = 140;
    self.bgStyleIndex = 100;
}

- (void)setText:(NSString *)text
          color:(UIColor *)color
           font:(UIFont *)font
        speInfo:(GLSpecialEfficacyInfo *)info
      styleInfo:(NSDictionary *)styleInfo
   bgStyleIndex:(NSInteger)bgStyleIndex
{
    [self.textView clearSpecialEfficacy];
    self.textView.text = text;
    self.selectedFont = font;
    self.selectedColor = color;
    self.speInfo = info;
    self.styleInfo = styleInfo;
    self.bgStyleIndex = bgStyleIndex;
}



- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor  = selectedColor;
    _textView.textColor = selectedColor;
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    _selectedFont = selectedFont;
    _textView.font = selectedFont;
}

- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo
{
    _speInfo  = speInfo;
    [_textView setSpeInfo:speInfo];
}

- (void)setStyleInfo:(NSDictionary *)styleInfo
{
    _styleInfo = styleInfo;
}




- (void)resetFrameWithInfo:(NSDictionary *)dict bgStyleIndex:(NSInteger)bgStyleIndex
{
    self.styleInfo = dict;
    self.bgStyleIndex = bgStyleIndex;
    if ([[_styleInfo objectForKey:@"ImageName"] length] > 0) {
        self.bgView.frame = self.bounds;
        self.bgView.image = [ImageUtility imageWithStyleName:[_styleInfo objectForKey:@"ImageName"]];
    }else{
        self.bgView.image = nil;
    }
    
    if ([[_styleInfo objectForKey:@"TextFrame"] length] > 0) {
        CGRect rect = CGRectFromString([_styleInfo objectForKey:@"TextFrame"]);
        self.textView.frame = rect;
    }else{
        self.textView.frame = self.bounds;
    }
}

- (UIImage *)cutImage
{
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    static int index = 0;
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"cut_%@/%d.png",[NSDate date],index];
    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
        NSLog(@"Succeeded! /n %@",path);
    }
    else {
        NSLog(@"Failed!");
    }

    return image;
}



//- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo
//{
//    _speInfo = nil;
//    _speInfo = speInfo;
//    if (speInfo) {
//        [self.textView setSpeInfo:speInfo];
//    }
//}

- (void)resetFontAndSize
{
    [self.textView resetFontAndSize];

}
- (void)dealloc
{
    [_bgView removeFromSuperview];
    _bgView = nil;
    
    [_textView removeFromSuperview];
    _textView  = nil;
    _styleInfo = nil;
    _selectedColor = nil;
    _selectedFont = nil;
    _speInfo = nil;
    NSLog(@"%@::::;dealloc",[self class]);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
