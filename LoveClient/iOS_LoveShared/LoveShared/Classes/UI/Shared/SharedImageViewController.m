//
//  SharedImageViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-4-25.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "SharedImageViewController.h"
//#import "CardCreateSmallCardViewController.h"
#import "HomeViewController.h"
#import "GLSencSuccessfulAlertViewController.h"
@interface SharedImageViewController ()<GLSencSuccessfulAlertViewControllerDelegate>

@property (nonatomic, assign) long long recordResourceId;

@end

@implementation SharedImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    }
    self.recordResourceId = -100;
    self.uploadResourceInfoDict = [NSMutableDictionary dictionary];
    [self initResource];
    [self initNavgationBar];
}







- (void)initResource
{
    self.view.backgroundColor = [UIColor whiteColor];
    _backgroundView = [[GLBlurBackgroundView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - iOS7AddStatusHeight)];
    [_backgroundView setBackgroundImage:self.image];
    [self.view addSubview:_backgroundView];
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - iOS7AddStatusHeight)];
    [self.view addSubview:_contentView];
    CGRect rect = CGRectZero;
    rect.origin.x = 0;
    rect.origin.y = 0;
    UIImage *image = self.image;
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    if (width > _contentView.frame.size.width) {
        rect.size.width = _contentView.frame.size.width;
        rect.size.height = height*(_contentView.frame.size.width /width);
    }else{
        rect.size.width = width;
        rect.size.height = height;
    }
    
    rect.origin.x = (_contentView.frame.size.width - rect.size.width)/2.0f;
    if (rect.size.height < self.contentView.frame.size.height) {
        rect.origin.y = (_contentView.frame.size.height - rect.size.height)/2.0f;
    }
    
    _sharedImageView = [[UIImageView alloc] initWithFrame:rect];
    _sharedImageView.image = image;
    [_contentView addSubview:_sharedImageView];
    _contentView.contentSize = CGSizeMake(_contentView.frame.size.width, rect.size.height);
}


- (void)initNavgationBar
{
    self.title = D_LocalizedCardString(@"nav_title_preview");
    _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_commitButton setTitle:@"发布" forState:UIControlStateNormal];
    [_commitButton addTarget:self
                      action:@selector(preViewBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preViewItem = [[UIBarButtonItem alloc] initWithCustomView:_commitButton];
    self.navigationItem.rightBarButtonItem = preViewItem;
    preViewItem = nil;
    
}

- (void)preViewBtnAction:(id)sender
{
//    SUIModalActionSheet *sendSelectSheet = [[SUIModalActionSheet alloc] initWithTitle:nil
//                                                                             delegate:nil
//                                                                    cancelButtonTitle:D_LocalizedCardString(@"Button_Cancel")
//                                                               destructiveButtonTitle:nil
//                                                                    otherButtonTitles:
//                                            D_LocalizedCardString(@"postTO_CardShowAndFriend"),
//                                            D_LocalizedCardString(@"postTO_Friend_Only"), nil];
//    [sendSelectSheet showInView:self.view];
//    if (sendSelectSheet._buttonIndex == 0) {
//        self.postTo = E_PostToType_CardShowAndFriend;
    
    
        [self sendTCardCardAction];
        _commitButton.enabled = NO;
//        [sendSelectSheet removeFromSuperview];
//    }else if(sendSelectSheet._buttonIndex == 1) {
//        self.postTo = E_PostToType_FriendOnly;
//        [self sendTCardCardAction];
//        [sendSelectSheet removeFromSuperview];
//    }
  
}



- (void)sendTCardCardAction
{
    [self sendOverAction];
//    [LoadingViewManager showLoadViewWithText:@"正在发布..." andShimmering:YES andBlurEffect:YES inView:self.view];
//    if (self.type == E_ModuleType_SmallCard) {
//        [self uploadManyImageActionContentImage];//        [self uploadManyImageActionContentImage];
//    }else{
//        [self insertNotCardDataToSever];
//    }
}



- (void)uploadManyImageActionContentImage
{
    /*
    NSInteger imageViewCount = 0;
    
    if(self.petInfo)
    {
        ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
        resourceInfo.resourceId = self.petInfo.resourceContent;
        [self.uploadResourceInfoDict setObject:resourceInfo
                                        forKey:[NSString stringWithFormat:@"%d",2]];
        resourceInfo = nil;
        imageViewCount += 1;
    }
    
    if (self.contentImage) {
        imageViewCount += 1;
    }
    
    //上传录音
    if (self.musictype == E_MusicType_Record) {
        if (self.recordPath.length > 0) {
            
            imageViewCount  += 1;//需要上传资源＋1；
            
            NSString *suffix = @"";
            NSData *uploadData = nil;
            uploadData = [NSData dataWithContentsOfFile:self.recordPath];
            suffix = @".mp3";
            
            UploadImageItem *imageItem = nil;
            if (uploadData != nil) {
                imageItem = [[UploadImageItem alloc] initWithImageData:uploadData suffix:suffix];
                imageItem.moduleType = E_Module_Type_Material;
                ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
                resourceInfo.contentType = E_MusicType_Record;
                resourceInfo.resourceIndex = -1;
                [imageItem setResourceInfo:resourceInfo];
                [imageItem setSuccessCallback:^(HttpBaseItem *item) {
                    UploadImageItem *tempItem = (UploadImageItem *)item;
                    ResourceUploadInfo *callbackresourceInfo = tempItem.resourceInfo;
                    if (item.resultStrWithResponseData) {
                        callbackresourceInfo.resourceId = [tempItem.resultStrWithResponseData longLongValue];
                        self.recordResourceId = callbackresourceInfo.resourceId;
                        [self.uploadResourceInfoDict setObject:callbackresourceInfo
                                                        forKey:[NSString stringWithFormat:@"%d",callbackresourceInfo.resourceIndex]];
                    }
                    if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
                        [self uploadContentViewDict];
                    }
                } failureCallback:^(HttpBaseItem *item) {
                    NSLog(@"failture!!!");
                    [self.uploadResourceInfoDict removeAllObjects];
                    [LoadingViewManager hideLoadViewInView:self.view];
                    [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
                    _commitButton.enabled = YES;
                }];
                HttpEngine *uploadEngine = [[HttpEngine alloc] initWithBaseUrlStr:D_API_DOMAIN_DEFAULT];
                [uploadEngine invokeUploadItem:imageItem];
                imageItem = nil;
                uploadEngine  = nil;
            }
        }
    }
    
    
    
    //主要是上传图片资源
//    for (int i = 0;  i < self.contentViewArr.count; i++) {
//        ZDStickerView *tempView = [self.contentViewArr objectAtIndex:i];
//        if (tempView.contentType == E_ContentViewType_ImageView ||
//            tempView.contentType == E_ContentViewType_Record || (tempView.contentType == E_ContentViewType_TextView && tempView.cardTextView.textView.text.length >0)) {
    if (self.contentImage) {
        NSString *suffix = @".png";
        NSData *uploadData = UIImagePNGRepresentation(self.contentImage);
        UploadImageItem *imageItem = nil;
        if (uploadData != nil) {
            imageItem = [[UploadImageItem alloc] initWithImageData:uploadData suffix:suffix];
            imageItem.moduleType = E_Module_Type_Material;
            ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
            resourceInfo.contentType = E_ContentViewType_ImageView;
            resourceInfo.resourceIndex = 1;
            //tempView.index;
            [imageItem setResourceInfo:resourceInfo];
            [imageItem setSuccessCallback:^(HttpBaseItem *item) {
                UploadImageItem *tempItem = (UploadImageItem *)item;
                ResourceUploadInfo *callbackresourceInfo = tempItem.resourceInfo;
                if (item.resultStrWithResponseData) {
                    callbackresourceInfo.resourceId = [tempItem.resultStrWithResponseData longLongValue];
                    [self.uploadResourceInfoDict setObject:callbackresourceInfo
                                                    forKey:[NSString stringWithFormat:@"%d",callbackresourceInfo.resourceIndex]];
                }
                if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
                    [self uploadContentViewDict];
                }
            } failureCallback:^(HttpBaseItem *item) {
                NSLog(@"failture!!!");
                [self.uploadResourceInfoDict removeAllObjects];
                [LoadingViewManager hideLoadViewInView:self.view];
                [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
                _commitButton.enabled = YES;
            }];
            HttpEngine *uploadEngine = [[HttpEngine alloc] initWithBaseUrlStr:D_API_DOMAIN_DEFAULT];
            [uploadEngine invokeUploadItem:imageItem];
            imageItem = nil;
            uploadEngine  = nil;
        }
        
    }
    
    if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
        [self uploadContentViewDict];
    }
     */
}



- (void)insertNotCardDataToSever
{
    
    /*
    UploadImageItem *imageItem = [[UploadImageItem alloc] initWithImageData:UIImageJPEGRepresentation(self.image, 1) suffix:@".jpg"];
    imageItem.moduleType = E_Module_Type_Preview;
    [imageItem setSuccessCallback:^(HttpBaseItem *item) {
        NSLog(@"item UploadImageItem response:%@",item.resultStrWithResponseData);
        NSString *preImageId = nil;
        if (item.resultStrWithResponseData) {
            preImageId = item.resultStrWithResponseData;
        }
        [self saveCardImageToCacheWithImage:UIImageJPEGRepresentation(self.image, 0.5) imageId:[preImageId longLongValue]];
        InsertTcardItem *cardItem = [[InsertTcardItem alloc] init];
        cardItem.type = self.type;
        cardItem.postedTo = self.postTo;
        cardItem.tcardImgId = [item.resultStrWithResponseData longLongValue];
        [cardItem setSuccessCallback:^(HttpBaseItem *item) {
            
            NSLog(@"－😉😉😉😉😉😉😉😉😉😉😉😉😉😉😉－－－－－－－%@",[item resultStrWithResponseData]);
            if ([[item resultStrWithResponseData] longLongValue] >= 0) {
                self.callBackCardId = [[item resultStrWithResponseData] longLongValue];
                  self.sharedUrl = [NSString stringWithFormat:@"%@%@/%lld/%lld", D_TCard_BaseUrl, [GLDataCenter sharedInstance].myBaseUserInfo.tno, [GLDataCenter sharedInstance].myBaseUserInfo.seccode, self.callBackCardId];
            }
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"发送成功" inView:self.view duration:1.0f];
            [self sendOverAction];
        } failureCallback:^(HttpBaseItem *item) {
            NSLog(@"failture!!!");
            [self.uploadResourceInfoDict removeAllObjects];
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
            _commitButton.enabled = YES;
        }];
        [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeItem:cardItem];
    } failureCallback:^(HttpBaseItem *item) {
        NSLog(@"failture!!!");
        [self.uploadResourceInfoDict removeAllObjects];
         [LoadingViewManager hideLoadViewInView:self.view];
        [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
        _commitButton.enabled = YES;
    }];
    [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeUploadItem:imageItem];
    imageItem = nil;
     */
    
}


- (void)uploadManyImageAction
{
    /*
    NSInteger imageViewCount = 0;
    for (int i = 0 ;i<[self.contentViewArr count];i++) {
        ZDStickerView *calcView = [self.contentViewArr objectAtIndex:i];
        if(calcView.contentType == E_ContentViewType_Decoration){
            ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
            resourceInfo.resourceId = self.decorationInfo.resourceContent;
            [self.uploadResourceInfoDict setObject:resourceInfo
                                            forKey:[NSString stringWithFormat:@"%d",calcView.index]];
            resourceInfo = nil;
        }else if(calcView.contentType == E_ContentViewType_Pet){
            ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
            resourceInfo.resourceId = self.petInfo.resourceContent;
            [self.uploadResourceInfoDict setObject:resourceInfo
                                            forKey:[NSString stringWithFormat:@"%d",calcView.index]];
            resourceInfo = nil;
        }
        if (calcView.contentType != E_ContentViewType_TextView) {
                imageViewCount++;
        }else{
            if (calcView.cardTextView.textView.text.length > 0) {
                imageViewCount++;
            }
        }
    }
    
    if (self.musictype == E_MusicType_Record) {
        if (self.recordPath.length > 0) {
            
            imageViewCount  += 1;//需要上传资源＋1；
            
            NSString *suffix = @"";
            NSData *uploadData = nil;
            uploadData = [NSData dataWithContentsOfFile:self.recordPath];
            suffix = @".mp3";
            
            UploadImageItem *imageItem = nil;
            if (uploadData != nil) {
                imageItem = [[UploadImageItem alloc] initWithImageData:uploadData suffix:suffix];
                imageItem.moduleType = E_Module_Type_Material;
                ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
                resourceInfo.contentType = E_MusicType_Record;
                resourceInfo.resourceIndex = -1;
                [imageItem setResourceInfo:resourceInfo];
                [imageItem setSuccessCallback:^(HttpBaseItem *item) {
                    UploadImageItem *tempItem = (UploadImageItem *)item;
                    ResourceUploadInfo *callbackresourceInfo = tempItem.resourceInfo;
                    if (item.resultStrWithResponseData) {
                        callbackresourceInfo.resourceId = [tempItem.resultStrWithResponseData longLongValue];
                        self.recordResourceId = callbackresourceInfo.resourceId;
                        [self.uploadResourceInfoDict setObject:callbackresourceInfo
                                                        forKey:[NSString stringWithFormat:@"%d",callbackresourceInfo.resourceIndex]];
                    }
                    if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
                        [self uploadContentViewDict];
                    }
                } failureCallback:^(HttpBaseItem *item) {
                    NSLog(@"failture!!!");
                    [self.uploadResourceInfoDict removeAllObjects];
                    [LoadingViewManager hideLoadViewInView:self.view];
                    [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
                    _commitButton.enabled  = YES;
                }];
                HttpEngine *uploadEngine = [[HttpEngine alloc] initWithBaseUrlStr:D_API_DOMAIN_DEFAULT];
                [uploadEngine invokeUploadItem:imageItem];
                imageItem = nil;
                uploadEngine = nil;
            }
        }
    }
    
    
    
    
    NSLog(@"sum upload Resources Count:%d",imageViewCount);
    //主要是上传图片资源
    for (int i = 0;  i < self.contentViewArr.count; i++) {
        ZDStickerView *tempView = [self.contentViewArr objectAtIndex:i];
        if (tempView.contentType == E_ContentViewType_ImageView ||
            tempView.contentType == E_ContentViewType_Record || (tempView.contentType == E_ContentViewType_TextView && tempView.cardTextView.textView.text.length >0)) {
            
            NSString *suffix = @"";
            NSData *uploadData = nil;
            
            if(tempView.contentType == E_ContentViewType_Record) {
                AudioPlayView *playAudioView = (AudioPlayView *)tempView.contentView;
                if(playAudioView.audioPath){
                    uploadData = [NSData dataWithContentsOfFile:playAudioView.audioPath];
                }
                suffix = @".mp3";
            }

            
            //上传图片资源
            if (tempView.contentType == E_ContentViewType_ImageView) {
                UIImageView *imageView = (UIImageView *)tempView.contentView;
                if (imageView.image) {
                    uploadData = UIImageJPEGRepresentation(imageView.image, 0.5);
                    
                    
                }
                suffix = @".jpg";
            }
            //上传图片资源
            if (tempView.contentType == E_ContentViewType_TextView) {
                CardTextView *imageView = (CardTextView *)tempView.contentView;
                if (imageView.cutImage) {
                    uploadData = UIImagePNGRepresentation(imageView.cutImage);
//                    [uploadData writeToFile:[NSString pathForLibraryResource:@"aa.png"] atomically:YES];
                }
                suffix = @".png";
            }
            
            
            UploadImageItem *imageItem = nil;
            if (uploadData != nil) {
                imageItem = [[UploadImageItem alloc] initWithImageData:uploadData suffix:suffix];
                imageItem.moduleType = E_Module_Type_Material;
                ResourceUploadInfo *resourceInfo = [[ResourceUploadInfo alloc] init];
                resourceInfo.contentType = tempView.contentType;
                resourceInfo.resourceIndex = tempView.index;
                //tempView.index;
                [imageItem setResourceInfo:resourceInfo];
                [imageItem setSuccessCallback:^(HttpBaseItem *item) {
                    UploadImageItem *tempItem = (UploadImageItem *)item;
                    ResourceUploadInfo *callbackresourceInfo = tempItem.resourceInfo;
                    if (item.resultStrWithResponseData) {
                        callbackresourceInfo.resourceId = [tempItem.resultStrWithResponseData longLongValue];
                        [self.uploadResourceInfoDict setObject:callbackresourceInfo
                                                        forKey:[NSString stringWithFormat:@"%d",callbackresourceInfo.resourceIndex]];
                    }
                    if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
                        [self uploadContentViewDict];
                    }
                } failureCallback:^(HttpBaseItem *item) {
                    NSLog(@"failture!!!");
                    [self.uploadResourceInfoDict removeAllObjects];
                    [LoadingViewManager hideLoadViewInView:self.view];
                    [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
                    _commitButton.enabled  = YES;
                }];
                HttpEngine *uploadEngine = [[HttpEngine alloc] initWithBaseUrlStr:D_API_DOMAIN_DEFAULT];
                [uploadEngine invokeUploadItem:imageItem];
                imageItem = nil;
                uploadEngine = nil;
            }
            
        }
    }
    if ([[self.uploadResourceInfoDict allKeys] count] == imageViewCount) {
        [self uploadContentViewDict];
    }
     */
}



- (void)uploadContentViewDict
{
    /*
    UploadImageItem *imageItem = [[UploadImageItem alloc] initWithImageData:UIImageJPEGRepresentation(self.image, 1) suffix:@".jpg"];
    imageItem.moduleType = E_Module_Type_Preview;
    [imageItem setSuccessCallback:^(HttpBaseItem *item) {
        NSLog(@"item UploadImageItem response:%@",item.resultStrWithResponseData);
        NSString *preImageId = nil;
        if (item.resultStrWithResponseData) {
            preImageId = item.resultStrWithResponseData;
        }
        
        [self saveCardImageToCacheWithImage:UIImageJPEGRepresentation(self.image, 0.5) imageId:[preImageId longLongValue]];
        
        InsertTcardItem *cardItem = [[InsertTcardItem alloc] init];
        cardItem.type = self.type;
        cardItem.tcardImgId = [item.resultStrWithResponseData longLongValue];
        
  
        NSMutableArray *canvasBeansArray = [NSMutableArray array];
        if (self.petInfo) {
            CanvasBeansInfo *info = [CanvasBeansInfo viewCanvasInfoWithSubView:self.petStickerView
                                                                     superView:self.contentSuperView];
            
            
            ResourceUploadInfo *resourceInfo  = (ResourceUploadInfo *)[self.uploadResourceInfoDict objectForKey:[NSString stringWithFormat:@"%d",2]];
            if (resourceInfo) {
                info.canvasContent = [NSString stringWithFormat:@"%lld",resourceInfo.resourceId];
            }
            info.canvasIndex = 2;
            [canvasBeansArray addObject:[info viewDict]];
        }
        
        
        if (self.contentImage) {
            CanvasBeansInfo *info = [[CanvasBeansInfo alloc] init];
            info.canvasScale_x = 0;
            info.canvasScale_y = 0;
            info.canvasWidth = 1;
            info.canvasHeight = 4.0f/3.0f;
            info.canvasAngle = 0.0f;
            info.canvasIndex = 1;
            info.canvasType = E_ContentViewType_ImageView;
            ResourceUploadInfo *resourceInfo  = (ResourceUploadInfo *)[self.uploadResourceInfoDict objectForKey:[NSString stringWithFormat:@"%d",1]];
            if (resourceInfo) {
                info.canvasContent = [NSString stringWithFormat:@"%lld",resourceInfo.resourceId];
            }
            [canvasBeansArray addObject:[info viewDict]];
        }
    
        //底纹的添加
        if(self.baseBoardInfo){
            CanvasBeansInfo *baseBoardInfo = [CanvasBeansInfo baseBoardViewCanvasInfoWithResourceInfo:self.baseBoardInfo];
            baseBoardInfo.canvasIndex = 0;//最底层的标记
            baseBoardInfo.canvasType = E_ContentViewType_Baseboard;
            [canvasBeansArray addObject:[baseBoardInfo viewDict]];
        }
        //特效的添加
        if(self.specialEfficacyResourceInfo){
            CanvasBeansInfo *seInfo = [[CanvasBeansInfo alloc] init];
            seInfo.canvasContent  = [NSString stringWithFormat:@"%lld",self.specialEfficacyResourceInfo.resourceContent];
            seInfo.canvasType = E_ContentViewType_SpecialEfficacy;
            seInfo.canvasIndex = -3;
            [canvasBeansArray addObject:[seInfo viewDict]];
            seInfo = nil;
        }
        
        /*
         音效的添加
         1.音乐——Music
         2.录音--Record
         */
    /*
        if(self.musictype == E_MusicType_Music){
            if (self.musicDict) {
                long long songId = [[self.musicDict objectForKey:@"musicId"] longLongValue];
                CanvasBeansInfo *musicInfo = [[CanvasBeansInfo alloc] init];
                musicInfo.canvasContent  = [NSString stringWithFormat:@"%lld",songId];
                musicInfo.canvasType = E_ContentViewType_Music;
                musicInfo.canvasIndex = -1;
                [canvasBeansArray addObject:[musicInfo viewDict]];
                musicInfo = nil;
            }
            
        }else if(self.musictype == E_MusicType_Record){
            if (self.recordResourceId >0) {
                CanvasBeansInfo *recordInfo = [[CanvasBeansInfo alloc] init];
                recordInfo.canvasContent  = [NSString stringWithFormat:@"%lld",self.recordResourceId];
                recordInfo.canvasType = E_ContentViewType_Record;
                recordInfo.canvasIndex = -2;
                [canvasBeansArray addObject:[recordInfo viewDict]];
                recordInfo = nil;
            }
        }
        
        cardItem.canvasBeans = [canvasBeansArray JSONString];
        [cardItem setSuccessCallback:^(HttpBaseItem *item) {
            NSLog(@"－－－－😉😉😉😉😉😉😉😉😉😉😉😉😉😉😉－－－－%@",[item resultStrWithResponseData]);
            if ([[item resultStrWithResponseData] longLongValue] >= 0) {
                self.callBackCardId = [[item resultStrWithResponseData] longLongValue];
                
                self.sharedUrl = [NSString stringWithFormat:@"%@%@/%lld/%lld", D_TCard_BaseUrl, [GLDataCenter sharedInstance].myBaseUserInfo.tno, [GLDataCenter sharedInstance].myBaseUserInfo.seccode, self.callBackCardId];
            }
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"发送成功" inView:self.view duration:1.0f];
            [self sendOverAction];
        } failureCallback:^(HttpBaseItem *item) {
            NSLog(@"failture!!!");
            [self.uploadResourceInfoDict removeAllObjects];
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
            _commitButton.enabled  = YES;
        }];
        [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeItem:cardItem];
        cardItem = nil;
    } failureCallback:^(HttpBaseItem *item) {
        NSLog(@"failture!!!");
        [self.uploadResourceInfoDict removeAllObjects];
        [LoadingViewManager hideLoadViewInView:self.view];
        [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
        _commitButton.enabled  = YES;
    }];
    [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeUploadItem:imageItem];
    imageItem = nil;
    */

}





- (void)uploadContentViewDict2
{
  /*  UploadImageItem *imageItem = [[UploadImageItem alloc] initWithImageData:UIImageJPEGRepresentation(self.image, 0.5) suffix:@".jpg"];
    imageItem.moduleType = E_Module_Type_Preview;
    [imageItem setSuccessCallback:^(HttpBaseItem *item) {
        NSLog(@"item UploadImageItem response:%@",item.resultStrWithResponseData);
        NSString *preImageId = nil;
        if (item.resultStrWithResponseData) {
            preImageId = item.resultStrWithResponseData;
        }
        
        [self saveCardImageToCacheWithImage:UIImageJPEGRepresentation(self.image, 0.5) imageId:[preImageId longLongValue]];
        
        InsertTcardItem *cardItem = [[InsertTcardItem alloc] init];
        cardItem.type = self.type;
        cardItem.tcardImgId = [item.resultStrWithResponseData longLongValue];
        
        
        NSMutableArray *canvasBeansArray = [CardJsonFactory viewToJsonWithViews:self.contentViewArr
                                                                         supuerView:self.contentSuperView
                                                                    resourceIdDicts:self.uploadResourceInfoDict];
        //底纹的添加
        if(self.baseBoardInfo){
            CanvasBeansInfo *baseBoardInfo = [CanvasBeansInfo baseBoardViewCanvasInfoWithResourceInfo:self.baseBoardInfo];
            baseBoardInfo.canvasIndex = 0;//最底层的标记
            baseBoardInfo.canvasType = E_ContentViewType_Baseboard;
            [canvasBeansArray addObject:[baseBoardInfo viewDict]];
        }
        //特效的添加
        if(self.specialEfficacyResourceInfo){
            CanvasBeansInfo *seInfo = [[CanvasBeansInfo alloc] init];
            seInfo.canvasContent  = [NSString stringWithFormat:@"%lld",self.specialEfficacyResourceInfo.resourceContent];
            seInfo.canvasType = E_ContentViewType_SpecialEfficacy;
            seInfo.canvasIndex = -3;
            [canvasBeansArray addObject:[seInfo viewDict]];
        }
        
        /*
         音效的添加
         1.音乐——Music
         2.录音--Record
        */
     /*   if(self.musictype == E_MusicType_Music){
            if (self.musicDict) {
                long long songId = [[self.musicDict objectForKey:@"musicId"] longLongValue];
                CanvasBeansInfo *musicInfo = [[CanvasBeansInfo alloc] init];
                musicInfo.canvasContent  = [NSString stringWithFormat:@"%lld",songId];
                musicInfo.canvasType = E_ContentViewType_Music;
                musicInfo.canvasIndex = -1;
                [canvasBeansArray addObject:[musicInfo viewDict]];
            }
            
        }else if(self.musictype == E_MusicType_Record){
            if (self.recordResourceId >0) {
                CanvasBeansInfo *recordInfo = [[CanvasBeansInfo alloc] init];
                recordInfo.canvasContent  = [NSString stringWithFormat:@"%lld",self.recordResourceId];
                recordInfo.canvasType = E_ContentViewType_Record;
                recordInfo.canvasIndex = -2;
                [canvasBeansArray addObject:[recordInfo viewDict]];
            }
        }
        
        cardItem.canvasBeans = [canvasBeansArray JSONString];
        [cardItem setSuccessCallback:^(HttpBaseItem *item) {
           NSLog(@"－－－－－－－－%@",[item resultStrWithResponseData]);
            if ([[item resultStrWithResponseData] longLongValue] >= 0) {
                self.callBackCardId = [[item resultStrWithResponseData] longLongValue];
                
                self.sharedUrl = [NSString stringWithFormat:@"%@%@/%lld/%lld", D_TCard_BaseUrl, [GLDataCenter sharedInstance].myBaseUserInfo.tno, [GLDataCenter sharedInstance].myBaseUserInfo.seccode, self.callBackCardId];
            }
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"发送成功" inView:self.view duration:1.0f];
            [self sendOverAction];
        } failureCallback:^(HttpBaseItem *item) {
            NSLog(@"failture!!!");
            [self.uploadResourceInfoDict removeAllObjects];
            [LoadingViewManager hideLoadViewInView:self.view];
            [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
            _commitButton.enabled  = YES;
        }];
        [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeItem:cardItem];
        cardItem = nil;
    } failureCallback:^(HttpBaseItem *item) {
        NSLog(@"failture!!!");
        [self.uploadResourceInfoDict removeAllObjects];
        [LoadingViewManager hideLoadViewInView:self.view];
        [[LoadingViewManager sharedInstance] showHUDWithText:@"你的网络不畅,请检查你的网络！" inView:self.view duration:1.0f];
        _commitButton.enabled  = YES;
    }];
    [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeUploadItem:imageItem];
    imageItem = nil;
      */
    
}





- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)sendOverAction
{
    _commitButton.enabled = YES;
    [self.uploadResourceInfoDict removeAllObjects];
    
    GLSencSuccessfulAlertViewController *successVC = [[GLSencSuccessfulAlertViewController alloc] initWithNibName:@"GLSencSuccessfulAlertViewController" bundle:[NSBundle mainBundle]];
    successVC.image = self.image;
    successVC.sharedUrl = self.sharedUrl;
    successVC.type = self.type;
    successVC.delegateControl = self;
    [self presentViewController:successVC animated:YES completion:^{
        
    }];
    
//    [GLDataCenter sharedInstance].myBaseUserInfo.tcardNum += 1;
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_FETCH_MYUSERINFO object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NewCard_MustUpdateCardList object:nil];

//    successVC = nil;
}

//发玩tuo卡之后生成的card的对象
- (void)cardEntityWithCardId:(long long)cardId  cardImageId:(long long)imageId
{
    


}
/**
 *  将发送完的图片保存到缓存中
 *
 *  @param image
 *  @param imageId
 */
- (void)saveCardImageToCacheWithImage:(NSData *)imageData imageId:(long long)imageId
{
    
//    [GLImageCache cacheImageWithCache:[GLImageCache sharedCommonImageCache] imageId:[GLDataCenter sharedInstance].myBaseUserInfo.iconname currentSize:CGSizeMake(1, 1) smallSize:CGSizeMake(2, 2) imageType:@"png" andImageBseUrl:D_Login_BaseUrl];
//        
//    NSString *after = @"";
//    after = [NSString stringWithFormat:@"%@?%@=%lld&picSize=%d",@"downloadFile",@"fileId",imageId,0,nil];
//    NSString *retUrl  = [NSString urlcombineWithBefore:D_Login_BaseUrl after:after];
//    
//    
//    NSString  *imageCacheKey = [NSString stringWithFormat:@"%@_%d_%d%@",
//                                [retUrl md5Hash],
//                                1,
//                                1,
//                                @".png"];
//    [[GLImageCache sharedCommonImageCache] addOrUpdateData:imageData forKey:imageCacheKey];
    
}




- (void)controlWithButtonIndex:(NSInteger)index
{
        
        switch (index) {
            case 0:
                [self gotoCardShow];
                break;
            case 1:
                [self gotoCardShow];
                break;
            case 2:
                [self gotoCardShow];
                break;
            case 3:
//                [self gotoCardShow];
                break;
            case 4:
                [self againCreate];
                break;
            case 5:
                [self gotoCardShow];
                break;
            default:
                break;
        }
    
}



#pragma mark
#pragma mark 再做一张

- (void)againCreate
{
    NSArray *array = self.navigationController.viewControllers;
    
    for (UIViewController *vc in array)
    {
        if ([vc class] == [ZYQAssetGroupViewController class]) {
            [vc.navigationController popToRootViewControllerAnimated:NO];
            [vc.parentViewController dismissViewControllerAnimated:NO completion:^{
            }];
            return;
        }else if([vc class] == [HomeViewController class]){
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

#pragma mark
#pragma mark 去卡秀看看

- (void)gotoCardShow
{
     NSArray *array = self.navigationController.viewControllers;
    for (UIViewController *vc in array)
    {
        if ([vc class] == [ZYQAssetGroupViewController class]) {
            [vc.navigationController popViewControllerAnimated:NO];
            [vc.parentViewController dismissViewControllerAnimated:NO completion:^{
                ZYQAssetPickerController *tempVC = (ZYQAssetPickerController *)vc.parentViewController;
                [tempVC.vc.navigationController popViewControllerAnimated:NO];
            }];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)dealloc
{

    [_backgroundView removeFromSuperview];
    [_sharedImageView removeFromSuperview];
    [_contentView removeFromSuperview];
    
    
    _backgroundView = nil;
    _sharedImageView = nil;
    _contentView = nil;
    _image = nil;
    _contentViewArr = nil;
    _contentSuperView = nil;
    _uploadResourceInfoDict = nil;
    _text = nil;
    _recordPath = nil;
    _recordTime = nil;
    _musicDict = nil;
    _specialEfficacyResourceInfo = nil;
    _petInfo = nil;
    _decorationInfo = nil;
    _baseBoardInfo = nil;
    _sharedUrl = nil;
    _contentImage = nil;
    _petStickerView = nil;
    

}


@end
