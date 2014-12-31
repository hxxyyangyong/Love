//
//  MeituOnceImageViewController.h
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GLMeitoPosterSelectViewController.h"
//#import "SharedImageViewController.h"
#import "MeituImageEditView.h"
//@interface MeituOnceImageViewController : UIViewController<GLMeitoPosterSelectViewControllerDelegate>
@interface MeituOnceImageViewController : UIViewController
@property (nonatomic, strong) ALAsset   *onceAsset;
@property (nonatomic, strong) GLBlurBackgroundView  *blurImageView;
@property (nonatomic, strong) UIScrollView      *contentView;
@property (nonatomic, strong) MeituImageEditView       *onceImageView;
@property (nonatomic, strong) UIImageView       *bringPosterView;
//边框  添加／删除按钮
@property (nonatomic, strong) UIView              *boardAndEditView;
@property (nonatomic, strong) UIButton            *boardbutton;
@property (nonatomic, strong) UIButton            *editbutton;




//ALAsset *asset = [self.assets objectAtIndex:j];
@end
