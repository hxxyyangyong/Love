//
//  AppDelegate.h
//  LoveShared
//
//  Created by Yong on 14/12/26.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageAddPreView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ImageAddPreView   *preview;


- (void)showPreView;
- (void)hiddenPreView;

@end

