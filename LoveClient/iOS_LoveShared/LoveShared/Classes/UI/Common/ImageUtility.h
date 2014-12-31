//
//  ImageUtility.h
//  TestAPP
//
//  Created by yangyong on 14-5-26.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <Foundation/Foundation.h>

#define k_ImageBundle_UserDefaults @"k_ImageBundle_UserDefaults"
#define k_ImageBundlePath_UserDefaults @"k_ImageBundlePath_UserDefaults"
#define D_LocalizedCardString(s) [[NSBundle mainBundle] localizedStringForKey:s value:nil table:@"CardToolLanguage"]

#define _TASK_IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define isIOS5                  ([[[UIDevice currentDevice]systemVersion]floatValue]<6)
#define D_BlurImageName             @"baseboard_eleven.jpg"
#define  D_Default_Userlevel    [GLDataCenter userLevel]
#import "LoadingViewManager.h"
//#import "MJRefresh.h"

@interface ImageUtility : NSObject
+ (void)setStyleBundleName:(NSString *)bundleName;
+ (void)setStyleBundlePath:(NSString *)bundlePath;
+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;
+ (UIImage *)imageWithStyleName:(NSString *)imageName;
+ (UIImage *)imageWithPath:(NSString *)path imageName:(NSString *)imageName;

+ (UIImage *)deleteBackgroundOfImage:(UIImage *)image
                          targetRect:(CGRect)taregetRect
                            cropPath:(UIBezierPath *)path;



+ (UIImage *)cutImageWithView:(UIView *)contentView;
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;

@end
