//
//  GuiideAnimationView.m
//  LoveShared
//
//  Created by yang on 14-12-30.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import "GuiideAnimationView.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
@implementation GuiideAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initResource];
    }
    return self;
}



- (void)initResource
{
    CGFloat pading = (self.frame.size.width - 105)/2.0f;
    _buttonArray = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i<5; i++) {
        OBShapedButton *tempButton = [[OBShapedButton alloc] initWithFrame:CGRectMake((i/3?20:0)+pading+40*(i%3), self.frame.size.height - (60+(i/3?0:20)), 25, 40)];
        tempButton.tag = i;
        [tempButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu_%d",i+1]] forState:UIControlStateNormal];
        [self addSubview:tempButton];
        [_buttonArray addObject:tempButton];
    }
}


- (void)startAnimation
{
    for (int i = 0; i <[_buttonArray count]; i++) {
        UIView *view = [_buttonArray objectAtIndex:i];
        [self animationStartWithTarget:view];
    }

}


- (void)animationStartWithTarget:(UIView *)target
                      //endCGPoint:(CGPoint)endPoint
{
    CGFloat toHeight = (self.frame.size.height - 20.f)/4.f - 10;
    CGFloat toWidth = 175.f*toHeight/109.f;
    
    [UIView animateWithDuration:1
                          delay:0.5*(target.tag+1)
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         target.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(((target.tag%3)%2?1:-1)*90)), 5, 5);
                         target.frame = CGRectMake(target.tag%2?(self.frame.size.width - 10 - toWidth):10,(self.frame.size.height - (toHeight*5 - 4*40))/2.0f +(toHeight-40)*target.tag, toWidth, toHeight);
                     } completion:^(BOOL finished) {
                         if (target.tag == 4) {
                                [UIView animateWithDuration:0.5
                                                 animations:^{
                                                     self.alpha = 0;
                                                 } completion:^(BOOL finished) {
                                                     [self removeFromSuperview];
                                                 }];
                         }
                     }];
}





@end
