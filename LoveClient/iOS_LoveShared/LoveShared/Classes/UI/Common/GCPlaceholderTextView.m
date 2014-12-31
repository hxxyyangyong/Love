//
//  GCPlaceholderTextView.m
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import "GCPlaceholderTextView.h"

@interface GCPlaceholderTextView () 

@property (nonatomic, retain) UIColor* realTextColor;
@property (nonatomic, readonly) NSString* realText;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;

@end

@implementation GCPlaceholderTextView

@synthesize realTextColor;
@synthesize placeholder;

#pragma mark -
#pragma mark Initialisation

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    self.realTextColor = [UIColor whiteColor];
    [self clearSpecialEfficacy];
}

#pragma mark -
#pragma mark Setter/Getters

- (void) setPlaceholder:(NSString *)aPlaceholder {
    if ([self.realText isEqualToString:placeholder]) {
        self.text = aPlaceholder;
    }
    
    [placeholder release];
    placeholder = [aPlaceholder retain];
    
    [self endEditing:nil];
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void) setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil) {
        super.text = self.placeholder;
        super.layer.shadowColor = [UIColor blackColor].CGColor;
        super.layer.shadowOffset = CGSizeMake(0, 1);
        [super.layer setShadowOpacity:1];
        [super.layer setShadowRadius:1];
    }
    else {
        super.text = text;
        super.layer.shadowColor = [UIColor clearColor].CGColor;
        super.layer.shadowOffset = CGSizeMake(0, 0);
        [super.layer setShadowOpacity:0];
        [super.layer setShadowRadius:0];
    }
    
    if ([text isEqualToString:self.placeholder]) {
        self.textColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        [self.layer setShadowOpacity:1];
        [self.layer setShadowRadius:1];
    }
    else {
        self.textColor = self.realTextColor;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        [self.layer setShadowOpacity:0];
        [self.layer setShadowRadius:0];
    }
}

- (NSString *) realText {
    return [super text];
}

- (void) beginEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
    }
}

- (void) endEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        super.text = self.placeholder;
        self.textColor = [UIColor whiteColor];
    }
}

- (void) setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:[UIColor whiteColor]]){
            [super setTextColor:textColor];
        }
        else{
            self.realTextColor = textColor;
        }
    }
    else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}


- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo
{
    _speInfo = nil;
    _speInfo = speInfo;
    if (speInfo) {
        [GLSpecialEfficacyInfo setGLSpecialEfficacyInfo:speInfo label:self];
    }else{
        [self clearSpecialEfficacy];
    }
}



- (void)resetFontAndSize
{
    
    CGFloat fontSize = self.font.pointSize;
    
    fontSize = self.font.pointSize;
    while (fontSize>0 && fontSize < self.frame.size.height) {
        
        CGFloat height = [self textHeightWithFont:self.font andtext:self.text content:self.frame.size.width andfontSize:fontSize];
        if (height >= self.frame.size.height) {
            break;
        }
        fontSize += 1.0f;
    }
    
    
    while (fontSize>0) {
        
        CGFloat height = [self textHeightWithFont:self.font andtext:self.text content:self.frame.size.width andfontSize:fontSize];
        if (height <= self.frame.size.height) {
            break;
        }
        fontSize -= 1.0f;
    }
    
    self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
    
}


- (CGFloat)textHeightWithFont:(UIFont *)targetfont andtext:(NSString *)text content:(CGFloat)width andfontSize:(CGFloat)fontSize
{
    CGFloat retHeight = 0;
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(width - fPadding, CGFLOAT_MAX);
    CGSize size = [text sizeWithFont:[UIFont fontWithName:targetfont.fontName size:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    retHeight = size.height+fPadding;
    return retHeight;
}

- (void)clearSpecialEfficacy
{
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowRadius = 0;
    self.layer.shadowOpacity = 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);


}




#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [realTextColor release];
    [placeholder release];
    realTextColor = nil;
    placeholder = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
