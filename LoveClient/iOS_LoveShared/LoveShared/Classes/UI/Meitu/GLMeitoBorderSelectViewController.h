//
//  GLMeitoBorderSelectViewController.h
//  Tuotuo
//
//  Created by yangyong on 14-7-22.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMeitoBorderSelectCell.h"
@protocol GLMeitoBorderSelectViewControllerDelegate;
@interface GLMeitoBorderSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GLMeitoBorderSelectViewDelegate>
{
    BOOL            _isNotablePullLoad;
    
}

@property (nonatomic, strong) UIView        *controlView;
@property (nonatomic, strong) UIView        *notNavView;
@property (nonatomic, strong) UIButton      *dissMissBtn;
@property (nonatomic, strong) UILabel       *titleLab;

@property (nonatomic, strong) GLBlurBackgroundView   *backgroundImageView;
@property (nonatomic, strong) UITableView   *petTableView;
@property (nonatomic, strong) NSMutableArray       *dataArray;
@property (nonatomic, weak)   id<GLMeitoBorderSelectViewControllerDelegate> delegateSelectPet;
@property (nonatomic, assign) NSInteger     userVipLevel;
@property (nonatomic, strong) UIImage       *blurImage;

@end


@protocol GLMeitoBorderSelectViewControllerDelegate <NSObject>

- (void)didSelectedWithBorder:(NSDictionary *)borderDict;
- (void)didSelectedWithBorder:(NSDictionary *)borderDict isEmpty:(BOOL)isEmpty;
@end