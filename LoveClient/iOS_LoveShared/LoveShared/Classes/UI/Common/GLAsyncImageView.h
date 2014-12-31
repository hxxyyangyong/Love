//
//  GLAsyncImageView.h
//  TestAPP
//
//  Created by yangyong on 14-6-17.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "EMAsyncImageView.h"
//#import <GLCommon/NSString+Help.h>
//typedef enum e_imageusedtype
//{
//    E_ImageUsedType_Common = 1,
//    E_ImageUsedType_User = 2,
//    E_ImageUsedType_Other = 3
//    
//}E_ImageUsedType;


typedef enum
{
//    E_ImageUsedType_FaceImage = 1,
//    E_ImageUsedType_IMMessageImage = 2,
//    E_ImageUsedType_BackgoundImage = 3,
//    E_ImageUsedType_AdvertisementImage = 4,
//    
//    E_ImageUsedType_CommodityListImage = 5,
//    E_ImageUsedType_CommodityDetailImage = 6,
//    
//    E_ImageUsedType_FreshNewsListImage = 7,
//    E_ImageUsedType_FreshNewsDetailImage = 8,
//    
//    E_ImageUsedType_ShopPushListImage = 9,
//    E_ImageUsedType_ShopPushDetailImage = 10
    E_ImageUsedType_Common = 1,
    E_ImageUsedType_User = 2,
    E_ImageUsedType_Other = 3
    
} E_ImageUsedType;

@interface GLAsyncImageView : EMAsyncImageView
{
    UITapGestureRecognizer *_recognizer;
    
    
}
@property (nonatomic, assign) void (^FetchedImage) (UIImage *image);

@property (nonatomic, assign) BOOL              canShowBigImage;

@property (nonatomic, assign) long long          ownerid;
@property (nonatomic, assign) long long          imageId;
@property (nonatomic, assign) CGSize            smallSize;
@property (nonatomic, assign) E_ImageUsedType   imageUsedType;
@property (nonatomic, strong) NSString          *defaultImage;
@property (nonatomic, assign) BOOL              isChangeSize;

- (void)loadImageWithImageId:(long long)imageId
                     ownerId:(long long)ownerId
                 currentSize:(CGSize )currentSize
                   smallSize:(CGSize )smallSize
                defaultImage:(NSString *)defaultImage
               imageUsedType:(E_ImageUsedType)aImageUsedType
                   imageType:(NSString *)imageType;



@end
