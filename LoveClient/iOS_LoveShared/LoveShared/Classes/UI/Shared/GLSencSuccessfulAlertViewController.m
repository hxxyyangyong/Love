//
//  GLSencSuccessfulAlertViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-7-31.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLSencSuccessfulAlertViewController.h"
#import "HomeViewController.h"
//#import "GLMainAppViewController.h"#Im
#import "WXApi.h"
#import "UIImage+Help.h"
//@"http://a.app.qq.com/o/simple.jsp?pkgname=cn.gaialine.talkage&g_f=994783"
#define D_SharedContent_Format  @"大家快来看看是不是真有这样的人啊，真是太有趣了！这里还能免费兑换奖品，真的是天上掉馅饼啊！"
@interface GLSencSuccessfulAlertViewController ()


//@property (nonatomic, strong) GLUtil_BlogShare      *sinaShareUtil;
@end

@implementation GLSencSuccessfulAlertViewController

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
    [self registerNotification];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    
}

- (void)loadView
{
    [super loadView];
    [self.favirateButton setBackgroundColorNormal:[UIColor colorWithHexString:@"#58c071"] highlightedColor:[UIColor colorWithHexString:@"#41a85a"]];
    [self.againCreateButton setBackgroundColorNormal:[UIColor colorWithHexString:@"#f47a75"] highlightedColor:[UIColor colorWithHexString:@"#ce5b56"]];
    [self.gotocardShowButton setBackgroundColorNormal:[UIColor colorWithHexString:@"#1fbba6"] highlightedColor:[UIColor colorWithHexString:@"#03917e"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self unregisterNotification];
}

- (void)registerNotification
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharecallback:) name:NOTIFY_WeiBoSharedNotification_Key object:nil];
//   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharecallback:) name:NOTIFY_WeiXinSharedNotification_Key object:nil];
}

- (void)unregisterNotification
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_WeiBoSharedNotification_Key object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_WeiXinSharedNotification_Key object:nil];
}

#pragma mark 
#pragma mark 分享回调

- (void)sharecallback:(NSNotification *)notifity
{
//    NSDictionary *dict = [notifity object];
//    if (dict) {
//        NSString *sharedChannel  = [dict objectForKey:D_SharedChannelKey];
//        NSNumber *sharedStatus = [dict objectForKey:D_SharedStatusKey];
//        if (sharedStatus) {
//            
//        }else{
//            sharedStatus = [NSNumber numberWithInt:61177077];
//        }
//        NSString *sharedResult = [dict objectForKey:D_SharedResultKey];
//        if ([sharedChannel isEqualToString:D_SharedChannel_WEIXIN]) {
//            
//            if ([sharedStatus integerValue] != 61177077) {//失败
//                [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//            }else{
//                [self dismissViewControllerAnimated:YES completion:^{
//                    if (_delegateControl && [_delegateControl respondsToSelector:@selector(controlWithButtonIndex:)]) {
//                        [_delegateControl controlWithButtonIndex:2];
//                        
//                    }
//                }];
//
//            }
//        }else if ([sharedChannel isEqualToString:D_SharedChannel_WEIBO]){
//            
//            
//            switch ([sharedStatus integerValue]) {
//                case WeiboSDKResponseStatusCodeSuccess:
//                    //                    result = @"分享成功";
//                {
//                    [self dismissViewControllerAnimated:YES completion:^{
//                        if (_delegateControl && [_delegateControl respondsToSelector:@selector(controlWithButtonIndex:)]) {
//                            [_delegateControl controlWithButtonIndex:2];
//                            
//                        }
//                    }];
//                }
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeUserCancel:
//                    //                    result = @"你取消了分享";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeSentFail:
//                    //                    result = @"分享失败";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeAuthDeny:
//                    //                    result = @"授权失败";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeUserCancelInstall:
//                    //                    result = @"分享失败";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeUnsupport:
//                    //                    result = @"分享失败";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                case WeiboSDKResponseStatusCodeUnknown:
//                    //                    result = @"分享失败";
//                    [[LoadingViewManager sharedInstance] showHUDWithText:sharedResult inView:self.view duration:1.0f];
//                    break;
//                    
//                default:
//                    //                    result = @"分享失败";
//                    break;
//            }
//        }
//    }
}




- (IBAction)sharedToWeixinFriendAction:(id)sender
{
    
//    [self sendToWeixin];
//    [self wechatFriendShare];
    [self sendImageContent:WXSceneTimeline];
}


- (IBAction)sharedToWeiXinAction:(id)sender {
    [self sendImageContent:WXSceneSession];
//    [self sendToWeixin];
//    [self wechatShare];
}

- (IBAction)sharedToSinaAction:(id)sender {
    [self sendToWeixin];
    [self weiboShare];
}




- (IBAction)favirateToAblmAction:(id)sender {
    
    [self saveImageToAblm];
}

- (IBAction)againCreateAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        if(_delegateControl && [_delegateControl respondsToSelector:@selector(controlWithButtonIndex:)])
            [_delegateControl controlWithButtonIndex:4];
    }];
}

- (IBAction)gotoCardShowAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        if(_delegateControl && [_delegateControl respondsToSelector:@selector(controlWithButtonIndex:)])
            [_delegateControl controlWithButtonIndex:5];
    }];
}



//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NewCard_MustUpdateCardList object:nil];

//    successVC = nil;


#pragma mark 分享操作
- (void) sendImageContent:(int)wxscene
{
    WXMediaMessage *message = [WXMediaMessage message];
    
    
    CGFloat width = 300;
    UIImage *thumbImage = self.image;
    while (UIImagePNGRepresentation(thumbImage).length/1024 > 40) {
        CGSize size = thumbImage.size;
        float maxSide = MAX(size.width, size.height);
        if (maxSide == size.width) {
            thumbImage = [UIImage imageWithImageSimple:thumbImage scaledToSize:CGSizeMake(width, size.height / size.width *width)];
        }
        else
        {
            thumbImage = [UIImage imageWithImageSimple:thumbImage scaledToSize:CGSizeMake(size.width / size.height *width, width)];
        }
        width -= 20.0f;
    }
    
    [message setThumbImage:thumbImage];
    
    WXImageObject *ext = [WXImageObject object];
    
    ext.imageData = UIImagePNGRepresentation(self.image);
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = wxscene;
    [WXApi sendReq:req];
}




- (void)sendToWeixin
{
    
    // Do any additional setup after loading the view.
//    if (!_shareInfo) {
//        GLEntity_ShareInfo *shareInfo = [[GLEntity_ShareInfo alloc] init];
//        shareInfo.shareContent = D_SharedContent_Format;
//        shareInfo.shareImage = self.image;
//        shareInfo.shareUrl = self.sharedUrl;
//        shareInfo.shareUrlOfWechat = self.sharedUrl;
//        shareInfo.shareFaceImage = [GLImageCache cacheImageWithCache:[GLImageCache sharedCommonImageCache] imageId:[GLDataCenter sharedInstance].myBaseUserInfo.iconname currentSize:CGSizeMake(1, 1) smallSize:CGSizeMake(2, 2) imageType:@"png" andImageBseUrl:D_Login_BaseUrl];  //!to be sure
//        shareInfo.shareTitleOfWechatWithName = @"天啊！这是不是真的？！居然还有这样的人？！！！";
//        shareInfo.shareContentOfWechat = @"大家快来看看是不是真有这样的人啊，真是太有趣了！这里还能免费兑换奖品，真的是天上掉馅饼啊！";
//        
//        self.shareInfo = shareInfo;
//    }
//    
}


- (void)initShareInfo
{
//    GLEntity_ShareInfo *shareInfo = [[GLEntity_ShareInfo alloc] init];
//    shareInfo.shareContent = [GLDataCenter sharedInstance].tcardShareModel.content;//@"天啊！我才不会告诉你这里的商铺促销跟白送一样，优惠真是太给力啦，真是惊喜不断啊！";
//    shareInfo.shareImage = self.image;
//    shareInfo.shareUrl = self.sharedUrl;
//    
//    
//    shareInfo.shareUrlOfWechat = self.sharedUrl;
//    shareInfo.shareFaceImage = [GLImageCache cacheImageWithCache:[GLImageCache sharedCommonImageCache] imageId:[GLDataCenter sharedInstance].myBaseUserInfo.iconname currentSize:CGSizeMake(1, 1) smallSize:CGSizeMake(2, 2) imageType:@"png" andImageBseUrl:D_Login_BaseUrl];; //!to be sure
//    shareInfo.shareTitleOfWechatWithName = [GLDataCenter sharedInstance].tcardShareModel.title;//_merchant.merchantName;
//    shareInfo.shareContentOfWechat = [GLDataCenter sharedInstance].tcardShareModel.content;//@"天啊！我才不会告诉你这里的商铺促销跟白送一样，优惠真是太给力啦，真是惊喜不断啊！";
//    
//    self.shareInfo = shareInfo;
}


- (void)wechatShare
{
    
//    [LoadingViewManager showLoadViewInView:self.view];
//    [GLMainAppViewController fetchShareContentWithBlock:^(BOOL result) {
//        [LoadingViewManager hideLoadViewInView:self.view];
//        if (result) {
//            [self initShareInfo];
//            
//            [GLUtil_BlogShare wechatShare:WXSceneSession shareInfo:_shareInfo];
//        }
//        else
//        {
//            [[LoadingViewManager sharedInstance] showHUDWithText:LocalizedTuoTuoForKey(@"load_shareModel_Failed") inView:self.view duration:1];
//        }
//    }];
}

- (void)wechatFriendShare
{
    
//    [LoadingViewManager showLoadViewInView:self.view];
//    [GLMainAppViewController fetchShareContentWithBlock:^(BOOL result) {
//        [LoadingViewManager hideLoadViewInView:self.view];
//        if (result) {
//            [self initShareInfo];
//            
//            [GLUtil_BlogShare wechatShare:WXSceneTimeline shareInfo:_shareInfo];
//        }
//        else
//        {
//            [[LoadingViewManager sharedInstance] showHUDWithText:LocalizedTuoTuoForKey(@"load_shareModel_Failed") inView:self.view duration:1];
//        }
//    }];
}

- (void)weiboShare
{
//    [LoadingViewManager showLoadViewInView:self.view];
//    [GLMainAppViewController fetchShareContentWithBlock:^(BOOL result) {
//        [LoadingViewManager hideLoadViewInView:self.view];
//        if (result) {
//            [self initShareInfo];
//            
//            self.sinaShareUtil = [[GLUtil_BlogShare alloc] init];
//            [_sinaShareUtil weiboShare1111:_shareInfo];
//        }
//        else
//        {
//            [[LoadingViewManager sharedInstance] showHUDWithText:LocalizedTuoTuoForKey(@"load_shareModel_Failed") inView:self.view duration:1];
//        }
//    }];
    
    
}

- (void)saveImageToAblm
{
    [self saveTapHandler];
}
-(void) saveTapHandler{
    
    if (self.type == E_ModuleType_SmallCard) {
        NSString *tcardUrl = self.sharedUrl;
        //保存二维码
//        UIImage *qrImage = [QRCodeGenerator qrImageForString:tcardUrl imageSize:300];
//        UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil);
//        self.image = qrImage;
    }
    [[LoadingViewManager sharedInstance] showText:@"正在保存" inView:self.view];
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

#pragma mark
#pragma mark 再做一张

- (void)againCreate
{
    for (UIViewController *vc in self.navigationController.viewControllers)
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
    
    for (UIViewController *vc in self.navigationController.viewControllers)
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
    
//    for (UIViewController *vc in self.navigationController.viewControllers)
//    {
//        if ([vc class] == [ZYQAssetGroupViewController class]) {
//            [vc.navigationController popViewControllerAnimated:NO];
//            [vc.parentViewController dismissViewControllerAnimated:NO completion:^{
//                ZYQAssetPickerController *tempVC = (ZYQAssetPickerController *)vc.parentViewController;
//                [tempVC.vc.navigationController popViewControllerAnimated:NO];
//            }];
//            return;
//        }
//    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - savePhotoAlbumDelegate
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"恭喜";
        message = @"成功保存到相册";
    } else {
        title = @"失败";
        message = [error description];
    }
    [[LoadingViewManager sharedInstance] removeLoadingView:self.view];
    [[LoadingViewManager sharedInstance] showHUDWithText:message inView:self.view duration:0.5f];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //    [alert show];
}


- (void)dealloc
{

}

@end
