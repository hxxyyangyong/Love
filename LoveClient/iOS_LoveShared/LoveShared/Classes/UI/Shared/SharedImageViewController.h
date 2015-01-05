//
//  SharedImageViewController.h
//  ;
//
//  Created by yangyong on 14-4-25.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDStickerView.h"
//#import "CardWithJsonView.h"
//#import "UploadImageItem.h"
//#import "InsertTcardItem.h"
//#import "MusicSelectViewController.h"
//#import "GLEntity_ShareInfo.h"
//#import "GLUtil_BlogShare.h"
//#import "GLSencSuccessfulAlertViewController.h"
#import "WXApi.h"


@interface SharedImageViewController : UIViewController<UIActionSheetDelegate>
@property (nonatomic, strong) GLBlurBackgroundView  *backgroundView;
@property (nonatomic, strong) UIImageView   *sharedImageView;
@property (nonatomic, strong) UIScrollView  *contentView;
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSArray       *contentViewArr;
@property (nonatomic, strong) UIScrollView  *contentSuperView;
@property (nonatomic, strong) NSMutableDictionary  *uploadResourceInfoDict;
@property (nonatomic, assign) E_ModuleType     type;
@property (nonatomic, strong) NSString      *text;
@property (nonatomic, assign) BOOL          isCallback;


//@property (nonatomic, assign) E_MusicType               musictype;

//录音的地址
@property (nonatomic, strong) NSString              *recordPath;
@property (nonatomic, assign) NSTimeInterval        *recordTime;

@property (nonatomic, strong) NSDictionary              *musicDict;


@property (nonatomic, strong) GLEntity_Resource                  *specialEfficacyResourceInfo;
//特殊的view
@property (nonatomic, strong) GLEntity_Resource         *petInfo;

//装饰
@property (nonatomic, strong) GLEntity_Resource         *decorationInfo;
//底纹
@property (nonatomic, strong) GLEntity_Resource         *baseBoardInfo;

//@property (nonatomic, assign) E_PostToType              postTo;

@property (nonatomic, assign) long long                 callBackCardId;
@property (nonatomic, strong) NSString                  *sharedUrl;



//
@property (nonatomic, strong) UIImage                   *contentImage;
@property (nonatomic, strong) ZDStickerView             *petStickerView;
@property (nonatomic, strong) UIButton                  *commitButton;

@end
