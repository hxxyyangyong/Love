//
//  GLAsyncImageView.m
//  TestAPP
//
//  Created by yangyong on 14-6-17.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "GLAsyncImageView.h"
//#import "ImageZoomAndMove.h"

@implementation GLAsyncImageView

- (void)setCanShowBigImage:(BOOL)canShowBigImage
{
    if (_recognizer)
    {
        [self removeGestureRecognizer:_recognizer];
        _recognizer = nil;
    }
    
    _canShowBigImage = canShowBigImage;
    if (canShowBigImage) {
        _recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture:)];
        _recognizer.numberOfTouchesRequired = 1;
        _recognizer.numberOfTapsRequired = 1;
        _recognizer.delegate = self;
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:_recognizer];
    }
}

- (void)loadImageWithImageId:(long long)imageId
                     ownerId:(long long)ownerId
                 currentSize:(CGSize )currentSize
                   smallSize:(CGSize )smallSize
                defaultImage:(NSString *)defaultImage
               imageUsedType:(E_ImageUsedType)aImageUsedType
                   imageType:(NSString *)imageType
{
//    if (imageId == 0)
//    {
//        LOG(@"图片ID为0");
//        self.image = [UIImage imageNoCache:defaultImage];
//        return;
//    }
//    self.imageId = imageId;
//    self.ownerid = ownerId;
//    self.imageSize = currentSize;
//    self.smallSize = smallSize;
//    self.defaultImage = defaultImage;
//    self.imageUsedType = aImageUsedType;
//    self.imageType = imageType;
//    
////    self.imageUrl =  @"http://ww3.sinaimg.cn/large/ed4e87d1jw1eg2kamfmiwj20c81gh43e.jpg";
//    //[NSString stringWithFormat:@"%lld.%@",imageId,imageType];
//    //used -->cache
//    switch (self.imageUsedType) {
//        case E_ImageUsedType_Common:
//            self.imageCache = [GLImageCache sharedCommonImageCache];
//            break;
//        case E_ImageUsedType_User:
//            self.imageCache = [GLImageCache sharedUsersImageCache];
//            break;
//        case E_ImageUsedType_Other:
//            self.imageCache = [GLImageCache sharedOtherImageCache];
//            break;
//        default:
//            break;
//    }
//    //先取缓存 如果有 就不用设置其他属性
//    if ([self.imageCache hasDataForKey:self.imageCacheKey]) {
//        self.image = [UIImage imageWithData:[self.imageCache getDataForkey:self.imageCacheKey]];
////        if (self.imageDownLoadOverCallBack.target && [self.imageDownLoadOverCallBack.target respondsToSelector:self.imageDownLoadOverCallBack.action]) {
////            [self.imageDownLoadOverCallBack.target
////             performSelectorOnMainThread:self.imageDownLoadOverCallBack.action
////             withObject:nil waitUntilDone:YES];
////        }
//        return;
//    }
//    
//    //default image  取小的缩略图
//    if ([self.imageCache hasDataForKey:[self smallImageKey]]) {
//        self.image = [UIImage imageWithData:[self.imageCache getDataForkey:[self smallImageKey]]];
//    }else{
//        self.image = [UIImage imageNoCache:self.defaultImage];//[ImageUtility imageWithStyleName:self.defaultImage];
//    }
    //load image
    [self loadImageWithUrl:self.imageUrl andSize:self.imageSize];
}


- (NSString *)smallImageKey
{
    NSString  *imageCacheKey = nil;
//    [NSString stringWithFormat:@"%@_%d_%d%@%@",
//                     [self.imageUrl md5Hash],
//                     (int)self.smallSize.width,
//                     (int)self.smallSize.height,
//                               (self.imageType.length > 0 ? @".":@""),self.imageType];
    return imageCacheKey;
}


- (NSString *)imageUrl
{
    NSString *before = @"";
//    if (self.isChangeSize) {
//       before = [NSString stringWithFormat:@"%@?%@=%lld&picSize=%d",@"downloadFile",@"fileId",self.imageId,1,nil];
//    }else{
        before = [NSString stringWithFormat:@"%@?%@=%lld&picSize=%d",@"downloadFile",@"fileId",self.imageId,0,nil];
//    }
    
    
    
    NSString *retUrl  = nil;
    //[NSString urlcombineWithBefore:D_Login_BaseUrl after:before];
    return retUrl;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)showBigPicture:(id)sender
{
//    GLAsyncImageView *imageView = [[GLAsyncImageView alloc] initWithFrame:self.frame];
//    
//    imageView.imageId = self.imageId;
//    imageView.ownerid = self.ownerid;
//    imageView.imageSize = self.imageSize ;
//    imageView.smallSize = self.smallSize;
//    imageView.defaultImage = self.defaultImage ;
//    imageView.imageUsedType = self.imageUsedType;
//    imageView.imageType = self.imageType;
//    
//    CGRect rect = CGRectMake(0, 0, 320, SCREENHEIGHT);
//    switch (imageView.imageUsedType) {
//        case E_ImageUsedType_Common:
//            imageView.imageCache = [GLImageCache sharedCommonImageCache];
//            break;
//        case E_ImageUsedType_User:
//            imageView.imageCache = [GLImageCache sharedUsersImageCache];
//            break;
//        case E_ImageUsedType_Other:
//            imageView.imageCache = [GLImageCache sharedOtherImageCache];
//            break;
//        default:
//            break;
//    }
//    //先取缓存 如果有 就不用设置其他属性
//    UIImage *image = nil;
//    if ([imageView.imageCache hasDataForKey:imageView.imageCacheKey]) {
//        image = [UIImage imageWithData:[imageView.imageCache getDataForkey:imageView.imageCacheKey]];
//    }
//    
//    //default image  取小的缩略图
//    if (!image) {
//        image = [UIImage imageWithData:[imageView.imageCache getDataForkey:[imageView smallImageKey]]];
//    }
//    
//    if (!image) {
//        //load image
//        [imageView loadImageWithUrl:imageView.imageUrl andSize:imageView.imageSize];
//        image = [UIImage imageNamed:imageView.defaultImage];
//    }
//    imageView.image = image;
//    
//    ImageZoomAndMove *scro = [[ImageZoomAndMove alloc]init];
//    scro.frame = rect;
//    [scro setImageView:imageView];
//    
//    [[UIApplication sharedApplication].delegate.window addSubview:scro];
//    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}


@end
