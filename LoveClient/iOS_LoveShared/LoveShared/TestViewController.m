//
//  TestViewController.m
//  LoveShared
//
//  Created by Yong on 14/12/30.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic,strong)UIView  *firstView;
@property (nonatomic,strong)UIView  *secondView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initResource
{
    _firstView = [[UIView alloc] init];
    _secondView = [[UIView alloc] init];
    [self.view addSubview:_firstView];
    [self.view addSubview:_secondView];
    
//    NSLayoutConstraint *vCont =[NSLayoutConstraint constraintWithItem:_firstView
//                                                            attribute:NSLayoutAttributema
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:self.view
//                                                            attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]
//    
//    
//    [_firstView addConstraint:];


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
