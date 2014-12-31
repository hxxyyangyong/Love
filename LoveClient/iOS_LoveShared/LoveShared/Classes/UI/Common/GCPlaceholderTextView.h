//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSpecialEfficacyInfo.h"
#import "GLColorView.h"
@interface GCPlaceholderTextView : UITextView 

@property (nonatomic, retain) NSString                      *placeholder;
@property (nonatomic, strong) GLSpecialEfficacyInfo         *speInfo;
- (void)setSpeInfo:(GLSpecialEfficacyInfo *)speInfo;
- (void)resetFontAndSize;
- (void)clearSpecialEfficacy;
@end
