//
//  ImageUtility.m
//  TestAPP
//
//  Created by yangyong on 14-5-26.
//  Copyright (c) 2014年 gainline. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import "ImageUtility.h"
#import "UIBezierPath-Points.h"
#import <UIKit/UIKit.h>
@implementation ImageUtility

+ (void)setStyleBundleName:(NSString *)bundleName
{
    [[NSUserDefaults standardUserDefaults] setObject:bundleName forKey:k_ImageBundle_UserDefaults];
        NSString *rootPath = [NSBundle mainBundle].resourcePath;
      NSString *bundlePath =  [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    [[NSUserDefaults standardUserDefaults] setObject:bundlePath forKey:k_ImageBundlePath_UserDefaults];
    
}

+ (void)setStyleBundlePath:(NSString *)bundlePath
{
    [[NSUserDefaults standardUserDefaults] setObject:bundlePath forKey:k_ImageBundlePath_UserDefaults];
}


+ (UIImage *)imageWithStyleName:(NSString *)imageName
{
    NSString *bundlePath = [[NSUserDefaults standardUserDefaults] objectForKey:k_ImageBundlePath_UserDefaults];
    if (bundlePath == nil || [bundlePath length] <= 0 || [bundlePath hasSuffix:@"(null)"]) {
        bundlePath =  [NSBundle mainBundle].resourcePath;
    }
    UIImage *image = [UIImage imageNamed:imageName];
                      //imageWithPath:bundlePath imageName:imageName];
    return image;
}

+ (UIImage *)imageWithPath:(NSString *)path imageName:(NSString *)imageName
{
    BOOL hasImageNameSuffix = NO;
    if (![[imageName lowercaseString] hasSuffix:@".png"] && ![[imageName lowercaseString] hasSuffix:@".jpg"]) {
        hasImageNameSuffix = YES;
    }
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@%@",path,imageName,hasImageNameSuffix ? @".png" : @""];
    UIImage *image = [UIImage  imageWithContentsOfFile:imagePath];
    return image;
}

+ (UIImage *)imageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName;
{
    NSString *rootPath = [NSBundle mainBundle].resourcePath;
    NSString *bundlePath =  [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    UIImage *image = [ImageUtility imageWithPath:bundlePath imageName:imageName];
    return image;
}




+ (UIImage *)deleteBackgroundOfImage:(UIImage *)image targetRect:(CGRect)taregetRect cropPath:(UIBezierPath *)path
{
    NSArray *points = [path points];
    CGRect rect = CGRectZero;
    rect.size = image.size;
    
    UIBezierPath *aPath;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    {
        [[UIColor blackColor] setFill];
        UIRectFill(rect);
        [[UIColor whiteColor] setFill];
        
        aPath = [UIBezierPath bezierPath];
        
        // Set the starting point of the shape.
        CGPoint p1 = [ImageUtility convertCGPoint:[[points objectAtIndex:0] CGPointValue] fromRect1:taregetRect.size toRect2:image.size];
        [aPath moveToPoint:CGPointMake(p1.x, p1.y)];
        
        for (uint i=1; i<points.count; i++)
        {
            CGPoint p = [ImageUtility convertCGPoint:[[points objectAtIndex:i] CGPointValue] fromRect1:taregetRect.size toRect2:image.size];
            [aPath addLineToPoint:CGPointMake(p.x, p.y)];
        }
        [aPath closePath];
        [aPath fill];
    }
    
    UIImage *mask = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    {
        CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask.CGImage);
        [image drawAtPoint:CGPointZero];
    }
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect croppedRect = aPath.bounds;
    croppedRect.origin.y = rect.size.height - CGRectGetMaxY(aPath.bounds);//This because mask become inverse of the actual image;
    
    croppedRect.origin.x = croppedRect.origin.x*2;
    croppedRect.origin.y = croppedRect.origin.y*2;
    croppedRect.size.width = croppedRect.size.width*2;
    croppedRect.size.height = croppedRect.size.height*2;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(maskedImage.CGImage, croppedRect);
    
    maskedImage = [UIImage imageWithCGImage:imageRef];
    
    return maskedImage;
}


+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2
{
    point1.y = rect1.height - point1.y;
    CGPoint result = CGPointMake((point1.x*rect2.width)/rect1.width, (point1.y*rect2.height)/rect1.height);
    return result;
}


+ (UIImage *)cutImageWithView:(UIView *)contentView
{
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(contentView.frame.size, NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(contentView.frame.size);
    }
    
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    static int index = 0;
//    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"cut_%@/%d.png",[NSDate date],index];
//    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
//        NSLog(@"Succeeded! /n %@",path);
//    }
//    else {
//        NSLog(@"Failed!");
//    }
    return image;
}

+ (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(scrollView.contentSize);
    }
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}




@end
