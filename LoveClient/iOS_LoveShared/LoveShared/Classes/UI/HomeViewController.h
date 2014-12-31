//
//  HomeViewController.h
//  LoveShared
//
//  Created by Yong on 14/12/26.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryViewController.h"
#import "ZYQAssetPickerController.h"
#import "GuiideAnimationView.h"
@interface HomeViewController : UIViewController<UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate,ImageAddPreViewDelegate>

@property (nonatomic, strong) ZYQAssetPickerController *picker;

@property (weak, nonatomic) IBOutlet UIView *contentButtonView;
@property (strong, nonatomic) IBOutlet UIView *moodView;
@property (strong, nonatomic) IBOutlet UIView *essayView;
@property (strong, nonatomic) IBOutlet UIView *meituView;
@property (strong, nonatomic) IBOutlet UIView *diaryView;
@property (strong, nonatomic) IBOutlet UIView *smallView;

@property (nonatomic, strong) GuiideAnimationView    *guideView;

//@property (strong, nonatomic) IBOutlet OBShapedButton *moodBtn;
//@property (strong, nonatomic) IBOutlet OBShapedButton *essayBtn;
//@property (strong, nonatomic) IBOutlet OBShapedButton *meituButton;
//@property (strong, nonatomic) IBOutlet OBShapedButton *diaryBtn;
//@property (strong, nonatomic) IBOutlet OBShapedButton *smallBtn;


@end
