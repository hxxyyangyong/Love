//
//  GuideViewController.m
//  LoveShared
//
//  Created by yang on 14-12-28.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import "GuideViewController.h"
#import "HomeViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)initResource
{
    CGFloat pading = (self.view.frame.size.width - 70)/2.0f;
    
    _startAnimationBtn = [[OBShapedButton alloc] initWithFrame:CGRectMake(50+pading, self.view.frame.size.height - 70, 25, 40)];
    [_startAnimationBtn setImage:[UIImage imageNamed:@"menu_1"] forState:UIControlStateNormal];
    [self.view addSubview:_startAnimationBtn];
    
    _startAnimationBtn2 = [[OBShapedButton alloc] initWithFrame:CGRectMake(80+pading, self.view.frame.size.height - 70, 25, 40)];
    [_startAnimationBtn2 setImage:[UIImage imageNamed:@"menu_2"] forState:UIControlStateNormal];
    [self.view addSubview:_startAnimationBtn2];
    
    _startAnimationBtn3 = [[OBShapedButton alloc] initWithFrame:CGRectMake(110+pading, self.view.frame.size.height - 70, 25, 40)];
    [_startAnimationBtn3 setImage:[UIImage imageNamed:@"menu_3"] forState:UIControlStateNormal];
    [self.view addSubview:_startAnimationBtn3];
    
    _startAnimationBtn4 = [[OBShapedButton alloc] initWithFrame:CGRectMake(65+pading, self.view.frame.size.height - 50, 25, 40)];
    [_startAnimationBtn4 setImage:[UIImage imageNamed:@"menu_4"] forState:UIControlStateNormal];
    [self.view addSubview:_startAnimationBtn4];
    
    _startAnimationBtn5 = [[OBShapedButton alloc] initWithFrame:CGRectMake(95+pading, self.view.frame.size.height - 50, 25, 40)];
    [_startAnimationBtn5 setImage:[UIImage imageNamed:@"menu_5"] forState:UIControlStateNormal];
    [self.view addSubview:_startAnimationBtn5];
    [_startAnimationBtn addTarget:self action:@selector(pushNextVC) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)pushNextVC
{

    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeVC animated:YES];

}




- (void)animationStartWithTarget:(UIView *)target endCGPoint:(CGPoint)endPoint
{
    CGFloat pading = (self.view.frame.size.width - 280)/2.0;
    [UIView animateWithDuration:1 delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                             target.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90)), 5, 5);
                         target.frame = CGRectMake(pading, 77, 200, 125);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1 delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _startAnimationBtn2.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90)), 5, 5);
                         _startAnimationBtn2.frame = CGRectMake(pading+80, 164, 200, 125);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1 delay:1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _startAnimationBtn3.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90)), 5, 5);
                         _startAnimationBtn3.frame = CGRectMake(pading, 251, 200, 125);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1 delay:1.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _startAnimationBtn4.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90)), 5, 5);
                         _startAnimationBtn4.frame = CGRectMake(pading+80, 338, 200, 125);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:1 delay:2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _startAnimationBtn5.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90)), 5, 5);
                         _startAnimationBtn5.frame = CGRectMake(pading, 425, 200, 125);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (CABasicAnimation *)animationWithStart
{
    CABasicAnimation *retAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    retAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(90))];
    retAnimation.duration = 0.3;
    retAnimation.fillMode = kCAFillModeForwards;
    retAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
    retAnimation.removedOnCompletion = NO;
    retAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];    
    return retAnimation;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initResource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animationStartWithTarget:_startAnimationBtn endCGPoint:CGPointMake(10, 7)];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
