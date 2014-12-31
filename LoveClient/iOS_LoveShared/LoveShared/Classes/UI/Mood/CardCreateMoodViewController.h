//
//  CardCreateMoodViewController.h
//  TestAPP
//
//  Created by yangyong on 14-5-23.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
#import "ImageUtility.h"
#import "CardTextView.h"
#import "CardTextToolView.h"
//#import "SharedImageViewController.h"
//#import "CardCreateSmallCardViewController.h"
#import "GLTextEditViewController.h"
#import "FXBlurView.h"
#import "CRNavigationController.h"
#import "GLCardBaseViewController.h"
#define D_ToolbarWidth      44
@interface CardCreateMoodViewController : GLCardBaseViewController<ZDStickerViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,GLTextEditViewControllerDelegate>

{


}

@property (nonatomic, strong)     GLTextEditViewController *textVC;

@end
