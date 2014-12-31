//
//  GuiideAnimationView.h
//  LoveShared
//
//  Created by yang on 14-12-30.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuiideAnimationView : UIView

//@property (nonatomic, strong) OBShapedButton *startAnimationBtn;
//@property (nonatomic, strong) OBShapedButton *startAnimationBtn2;
//@property (nonatomic, strong) OBShapedButton *startAnimationBtn3;
//@property (nonatomic, strong) OBShapedButton *startAnimationBtn4;
//@property (nonatomic, strong) OBShapedButton *startAnimationBtn5;

@property (nonatomic, strong) NSMutableArray       *buttonArray;

- (void)startAnimation;

@end
