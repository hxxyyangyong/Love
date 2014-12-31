//
//  GLCardBaseVCBottomBar.h
//  Tuotuo
//
//  Created by yangyong on 14-6-27.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "SharedImageViewController.h"

@protocol GLCardBaseVCBottomBarDelegate;

@interface GLCardBaseVCBottomBar : UIView

@property (nonatomic, strong) UIButton          *flagView;
@property (nonatomic, strong) NSArray           *buttonInfoArray;
@property (nonatomic, strong) UIScrollView      *buttonSrcView;
@property (nonatomic, weak)   id<GLCardBaseVCBottomBarDelegate> delegateAction;
@property (nonatomic, strong) UIButton          *selectButton;
@property (nonatomic, assign)   E_ModuleType    moudleType;
@end

@protocol GLCardBaseVCBottomBarDelegate <NSObject>

- (void)didSelectWithButtonTag:(NSInteger)tag info:(NSDictionary *)dict;

@end