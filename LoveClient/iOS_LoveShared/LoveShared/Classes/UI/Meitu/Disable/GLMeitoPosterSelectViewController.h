//
//  GLMeitoPosterSelectViewController.h
//  Tuotuo
//
//  Created by yangyong on 14-7-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMeitoPosterSelectCell.h"
@protocol GLMeitoPosterSelectViewControllerDelegate;
@interface GLMeitoPosterSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GLMeitoPosterSelectViewDelegate>
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
@property (nonatomic, weak)   id<GLMeitoPosterSelectViewControllerDelegate> delegateSelectPet;
@property (nonatomic, assign) NSInteger     userVipLevel;
@property (nonatomic, strong) UIImage       *blurImage;
@end


@protocol GLMeitoPosterSelectViewControllerDelegate <NSObject>

- (void)didSelectedWithPoster:(NSDictionary *)posterDict;
- (void)didSelectedWithPoster:(NSDictionary *)posterDict isEmpty:(BOOL)isEmpty;

@end