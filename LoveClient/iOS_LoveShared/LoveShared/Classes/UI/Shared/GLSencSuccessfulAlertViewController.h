//
//  GLSencSuccessfulAlertViewController.h
//  Tuotuo
//
//  Created by yangyong on 14-7-31.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GLEntity_ShareInfo.h"
//#import "GLUtil_BlogShare.h"
#import "ZYQAssetPickerController.h"
//#import "InsertTcardItem.h"
//#import "QRCodeGenerator.h"
//typedef enum e_moduletype
//{
//    E_ModuleType_Mood = 1,
//    E_ModuleType_Eassy = 2,
//    E_ModuleType_Meitu = 3,
//    E_ModuleType_Diary = 4,
//    E_ModuleType_SmallCard = 5
//    
//}E_ModuleType;



@protocol  GLSencSuccessfulAlertViewControllerDelegate;
@interface GLSencSuccessfulAlertViewController : UIViewController

@property (nonatomic, strong) UIImage       *image;
//@property (nonatomic, strong) GLEntity_ShareInfo *shareInfo;
@property (nonatomic, weak)   id<GLSencSuccessfulAlertViewControllerDelegate> delegateControl;
@property (nonatomic, assign) E_ModuleType     type;
@property (nonatomic, strong) NSString      *sharedUrl;

@property (strong, nonatomic) IBOutlet UIButton *weixinFriend;
@property (strong, nonatomic) IBOutlet UIButton *weixnButton;
@property (strong, nonatomic) IBOutlet UIButton *sinaButton;
@property (strong, nonatomic) IBOutlet UIButton *favirateButton;
@property (strong, nonatomic) IBOutlet UIButton *againCreateButton;
@property (strong, nonatomic) IBOutlet UIButton *gotocardShowButton;

- (IBAction)sharedToWeixinFriendAction:(id)sender;
- (IBAction)sharedToWeiXinAction:(id)sender;
- (IBAction)sharedToSinaAction:(id)sender;


- (IBAction)favirateToAblmAction:(id)sender;
- (IBAction)againCreateAction:(id)sender;
- (IBAction)gotoCardShowAction:(id)sender;

@end
@protocol  GLSencSuccessfulAlertViewControllerDelegate <NSObject>

- (void)controlWithButtonIndex:(NSInteger)index;

@end

