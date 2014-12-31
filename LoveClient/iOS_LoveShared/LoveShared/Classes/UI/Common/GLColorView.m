//
//  GLColorView.m
//  Tuotuo
//
//  Created by yangyong on 14-6-26.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLColorView.h"
//#import "CardCreateSmallCardViewController.h"
@implementation GLColorView

- (id)initWithFrame:(CGRect)frame   gadientColors:(NSArray *)gadientColors gradientStartPoint:(CGPoint)gradientStartPoint gradientEndPoint:(CGPoint)gradientEndPoint
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.gadientColors = gadientColors;
        self.gradientStartPoint = gradientStartPoint;
        self.gradientEndPoint = gradientEndPoint;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //apply insets
    rect = self.bounds;
    //get label size
    CGRect textRect = rect;
    UIColor *textColor = nil;
    textColor = textColor ?: [UIColor clearColor];
    BOOL hasGradient = [_gadientColors count] > 1;
    BOOL needsMask = hasGradient;
    CGImageRef alphaMask = NULL;
    if (needsMask)
    {
        //clip the context
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextClipToMask(context, rect, alphaMask);
        if (hasGradient)
        {
            //create array of pre-blended CGColors
            NSMutableArray *colors = [NSMutableArray arrayWithCapacity:[_gadientColors count]];
            for (UIColor *color in _gadientColors)
            {
                UIColor *blended = [self color:color.CGColor blendedWithColor:textColor.CGColor];
                [colors addObject:(__bridge id)blended.CGColor];
            }
            
            //draw gradient
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextTranslateCTM(context, 0, -rect.size.height);
            CGGradientRef gradient = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)colors, NULL);
            CGPoint startPoint = CGPointMake(textRect.origin.x + _gradientStartPoint.x * textRect.size.width,
                                             textRect.origin.y + _gradientStartPoint.y * textRect.size.height);
            CGPoint endPoint = CGPointMake(textRect.origin.x + _gradientEndPoint.x * textRect.size.width,
                                           textRect.origin.y + _gradientEndPoint.y * textRect.size.height);
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint,
                                        kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
            CGGradientRelease(gradient);
        }
        else
        {
            //fill text
            [textColor setFill];
            CGContextFillRect(context, textRect);
        }
        
        //end clipping
        CGContextRestoreGState(context);
        CGImageRelease(alphaMask);
    }
    
}
- (UIImage *)image
{
    UIImage *retImage = [ImageUtility cutImageWithView:self];
//    [UIImagePNGRepresentation(retImage) writeToFile:[NSString pathForLibraryResource:@"aa.png"] atomically:YES];
    return retImage;
}


- (UIColor *)color:(CGColorRef)a blendedWithColor:(CGColorRef)b
{
    CGFloat aRGBA[4];
    [self getComponents:aRGBA forColor:a];
    CGFloat bRGBA[4];
    [self getComponents:bRGBA forColor:b];
    CGFloat source = aRGBA[3];
    CGFloat dest = 1.0f - source;
    return [UIColor colorWithRed:source * aRGBA[0] + dest * bRGBA[0]
                           green:source * aRGBA[1] + dest * bRGBA[1]
                            blue:source * aRGBA[2] + dest * bRGBA[2]
                           alpha:bRGBA[3] + (1.0f - bRGBA[3]) * aRGBA[3]];
}


- (void)getComponents:(CGFloat *)rgba forColor:(CGColorRef)color
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(color));
    const CGFloat *components = CGColorGetComponents(color);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        default:
        {
            NSLog(@"Unsupported gradient color format: %i", model);
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}


- (void)dealloc
{
    _image = nil;
    _gadientColors = nil;


}

@end
