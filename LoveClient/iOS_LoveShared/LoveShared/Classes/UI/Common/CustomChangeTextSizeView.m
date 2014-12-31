//
//  CustomChangeTextSizeView.m
//  TestAPP
//
//  Created by yangyong on 14-6-20.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "CustomChangeTextSizeView.h"

@implementation CustomChangeTextSizeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        [self setContentInset:UIEdgeInsetsMake(10, 10, 10, 10)];//设置UITextView的内边距
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.scrollEnabled = NO;
        [self setTextAlignment:NSTextAlignmentLeft];//并设置左对齐
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor whiteColor]];

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        if (!_isNotVerCenter) {
//         [self addObserver:self forKeyPath:@"contentSize"options:NSKeyValueObservingOptionNew context:nil];
        }

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!_isNotVerCenter) {
    UITextView *mTrasView = object;
    CGFloat topCorrect = ([self bounds].size.height - [self contentSize].height);
    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
    self.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};  
    }
    
}

- (void)resetFontAndSize
{
    if (!_isNotChangeSize) {
    UIFont *targetFont = [UIFont fontWithName:self.font.fontName size:[self sizeExpandWithText:self.text targetFrame:self.frame.size maxSize:self.frame.size.height minSize:self.font.lineHeight]];
    self.font = targetFont;

    targetFont = [UIFont fontWithName:self.font.fontName size:[self sizeNarrowWithText:self.text targetFrame:self.frame.size maxSize:self.font.lineHeight minSize:2]];
    self.font = targetFont;
    [self setContentInset:UIEdgeInsetsMake(-2*(self.font.lineHeight - self.font.pointSize), 0, -2*(self.font.lineHeight - self.font.pointSize), 0)];//设置UITextView的内边距
    }
    [self setNeedsLayout];
}


- (CGFloat)sizeNarrowWithText:(NSString *)text
                  targetFrame:(CGSize)rect
                      maxSize:(CGFloat)maxSize
                      minSize:(CGFloat)minSize
{
    CGFloat retSize = 0;
    for (int i = maxSize; i >= minSize; i--) {
        CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:self.font.fontName size:i] constrainedToSize:CGSizeMake(rect.width-10, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        if (tempSize.height < rect.height) {
            retSize = i-1;
            break;
        }
    }
    if(retSize <= 0){
        retSize = (self.frame.size.height - 10)/2.0f;
    }
    return retSize;
}


- (CGFloat)sizeExpandWithText:(NSString *)text
                  targetFrame:(CGSize)rect
                      maxSize:(CGFloat)maxSize
                      minSize:(CGFloat)minSize
{
    CGFloat retSize = 0;
    for (int i = minSize; i <= maxSize; i++) {
        CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:self.font.fontName size:i] constrainedToSize:CGSizeMake(rect.width-10, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

        if (tempSize.height > rect.height) {
            retSize = i ;
            break;
        }
    }
    if(retSize <= 0){
        retSize = (self.frame.size.height - 10)/2.0f;
    }
    return retSize;
}




- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [self resetFontAndSize];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (!_isNotChangeSize) {
   
        if ([text isEqualToString:@"\n"]) {
            CGRect old = self.frame;
            old.size.height = self.frame.size.height + self.font.lineHeight;
            self.frame = old;
            if (_changeDelegate && [_changeDelegate respondsToSelector:@selector(changeSizeWithTextView:)]) {
                [_changeDelegate changeSizeWithTextView:self];
            }
            return YES;
        }
    UIFont *targetFont = [UIFont fontWithName:self.font.fontName size:[self sizeExpandWithText:[NSString stringWithFormat:@"%@%@",textView.text,text] targetFrame:self.frame.size maxSize:self.frame.size.height minSize:self.font.pointSize]];
    self.font = targetFont;
    targetFont = [UIFont fontWithName:self.font.fontName size:[self sizeNarrowWithText:[NSString stringWithFormat:@"%@%@",textView.text,text] targetFrame:self.frame.size maxSize:self.font.pointSize minSize:2]];
    self.font = targetFont;
    }
    return YES;
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    [self resetFontAndSize];
    
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [self resetFontAndSize];
    
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    if (!_isNotVerCenter) {
        [self textChanged:nil];
    }
}

- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeholder] length] == 0)
        
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
    
}


- (void)drawRect:(CGRect)rect

{
    if (!_isNotPlaceHolder) {
        
        if( [[self placeholder] length] > 0 )
            
        {
            
            if ( self.placeHolderLabel == nil )
                
            {
                self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,self.bounds.size.height - 8)];
                self.placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
                self.placeHolderLabel.numberOfLines = 0;
                self.placeHolderLabel.font = self.font;
                self.placeHolderLabel.backgroundColor = [UIColor clearColor];
                self.placeHolderLabel.textColor = self.placeholderColor;
                self.placeHolderLabel.alpha = 0;
                self.placeHolderLabel.tag = 999;
                self.placeHolderLabel.textAlignment = NSTextAlignmentCenter;
                self.placeHolderLabel.shadowColor  = [UIColor colorWithHexString:@"#0b0205"];
                self.placeHolderLabel.shadowOffset = CGSizeMake(0, 1);
                self.placeHolderLabel.layer.shadowRadius = 0.2;
                self.placeHolderLabel.layer.shadowOffset = CGSizeMake(0, 1);
                self.placeHolderLabel.layer.shadowOpacity = 0.2;
                [self addSubview:self.placeHolderLabel];
                
            }
            
            self.placeHolderLabel.text = self.placeholder;
            [self.placeHolderLabel sizeToFit];
            [self sendSubviewToBack:self.placeHolderLabel];
        }
        if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        {
            [[self viewWithTag:999] setAlpha:1];
        }
    }
    
    [super drawRect:rect];
}

//

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
//
//{
//    
//    if ([text isEqualToString:@"\n"]) {
//        
//        [m_textView resignFirstResponder];
//        
//        return NO;
//        
//    }
//    
//    return YES;  
//    
//}

- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo
{
    _speInfo = nil;
    _speInfo = speInfo;
    if (speInfo) {
        [GLSpecialEfficacyInfo setGLSpecialEfficacyInfo:speInfo label:self];
    }
}




- (void)dealloc

{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _placeHolderLabel = nil;
    _placeholderColor = nil;
    _placeholder = nil;
    
}

@end
