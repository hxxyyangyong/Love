//
//  PetView.h
//  Tuotuo
//
//  Created by yangyong on 14-5-6.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifView.h"

@interface PetView : UIView

@property (nonatomic, strong) GifView   *gifView;
@property (nonatomic, strong) NSString  *gifPath;
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
@end
