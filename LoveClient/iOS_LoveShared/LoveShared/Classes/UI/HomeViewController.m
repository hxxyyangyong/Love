//
//  HomeViewController.m
//  LoveShared
//
//  Created by Yong on 14/12/26.
//  Copyright (c) 2014年 loveui. All rights reserved.
//

#define D_First_Flag @"D_First_Flag"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "CardCreateMoodViewController.h"
#import "MeituEditStyleViewController.h"
#import "MeituOnceImageViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)



@interface HomeViewController ()
- (IBAction)controlBtn:(id)sender;
@property (nonatomic, assign) BOOL      tempFlag;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_tempFlag) {
        _contentButtonView.alpha = 1.0f;
    }else{
        _contentButtonView.alpha = 0.0f;
    }
    [self performSelector:@selector(startViewAnimation) withObject:nil afterDelay:_tempFlag?0:3.5];
    if (!_tempFlag) {
        _tempFlag = YES;
        [_guideView startAnimation];
    }
}

- (void)startViewAnimation
{
    if (_contentButtonView.alpha == 0) {
            [UIView animateWithDuration:0.5
                                  delay:0 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 _contentButtonView.alpha = 1.0f;
                             } completion:^(BOOL finished) {
                                 
                             }];
    }

    for (int i = 1; i <= 5; i++) {
        UIView *btn = nil;
        switch (i) {
            case E_ModuleType_Mood:
                btn = _moodView;
                break;
            case E_ModuleType_Eassy:
                btn = _essayView;
                break;
            case E_ModuleType_Meitu:
                btn = _meituView;
                break;
            case E_ModuleType_Diary:
                btn = _diaryView;
                break;
            case E_ModuleType_SmallCard:
                btn = _smallView;
                break;
            default:
                break;
        }
        [self performSelector:@selector(aniMationStartByView:) withObject:btn afterDelay:0];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeAllAnimation];
     [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爱分享";
    [self initResource];
}

- (void)initResource
{
    if (_guideView == nil) {
        _guideView = [[GuiideAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_guideView];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}


- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}


-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

- (void)aniMationStartByView:(UIView *)sender
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(5*(sender.tag%2?1:-1)))];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(-5*(sender.tag%2?1:-1)))];
    rotationAnimation.duration = 1;
    rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.repeatCount = HUGE_VALF;
    [self setAnchorPoint:CGPointMake(sender.tag%2?1:0, 0.5) forView:sender];
    [sender.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

- (void)removeAllAnimation
{
    [_moodView.layer removeAllAnimations];
    [_essayView.layer removeAllAnimations];
    [_meituView.layer removeAllAnimations];
    [_diaryView.layer removeAllAnimations];
    [_smallView.layer removeAllAnimations];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 
#pragma mark  Button的事件
- (IBAction)controlBtn:(id)sender {
    UIButton *target = (UIButton *)sender;
    NSInteger buttonTag = target.tag;
    UIViewController *pushVC = nil;
    switch (buttonTag) {
        case E_ModuleType_Mood:
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#58c071"];
            pushVC = [[CardCreateMoodViewController alloc] init];
            break;
        case E_ModuleType_Eassy:
                        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#64b7fb"];
            break;
        case E_ModuleType_Meitu:
            [self startPicker];
                       // self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#f1c057"];
            break;
        case E_ModuleType_Diary:
                        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#f47a75"];
            break;
        case E_ModuleType_SmallCard:
                        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#45b4ba"];
            break;
        default:
            break;
    }
    if (buttonTag != E_ModuleType_Meitu) {
        if (pushVC == nil) {
            pushVC = [[DiaryViewController alloc] init];
        }
        [self.navigationController pushViewController:pushVC animated:YES];
        
    }
}


- (void)startPicker
{
    if (_picker == nil) {
        _picker = [[ZYQAssetPickerController alloc] init];
        _picker.maximumNumberOfSelection = 5;
        _picker.assetsFilter = [ALAssetsFilter allPhotos];
        _picker.showEmptyGroups=NO;
        _picker.delegate = self;
    }
    _picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    if (IOS7) {
        _picker.navigationBar.barTintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }else{
        _picker.navigationBar.tintColor = [UIColor colorWithHexString:@"#1fbba6"];
    }
    [D_Main_Appdelegate showPreView];
    _picker.vc =self;
    [self presentViewController:_picker animated:YES completion:NULL];
    [D_Main_Appdelegate preview].delegateSelectImage = self;
    [[D_Main_Appdelegate preview] reMoveAllResource];
    
    
}



#pragma mark
#pragma mark ImageAddPreViewDelegate
- (void)startPintuAction:(ImageAddPreView *)sender
{
    if ([sender.imageassets count] >= 2) {
        MeituEditStyleViewController *meituEditVC = [[MeituEditStyleViewController alloc] init];
        meituEditVC.assets = sender.imageassets;
        [_picker pushViewController:meituEditVC animated:YES];
        meituEditVC = nil;
        
    }else if([sender.imageassets count] == 1){
        MeituOnceImageViewController *meituOnceVC = [[MeituOnceImageViewController alloc] init];
        meituOnceVC.onceAsset = [sender.imageassets objectAtIndex:0];
        [_picker pushViewController:meituOnceVC animated:YES];
        meituOnceVC = nil;
    }else{
        UIAlertView *imageCountWarningalert = [[UIAlertView alloc] initWithTitle:nil
                                                                         message:D_LocalizedCardString(@"card_meitu_max_image_count_less_than_two")
                                                                        delegate:self
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:D_LocalizedCardString(@"card_meitu_max_image_promptDetermine"), nil];
        [imageCountWarningalert show];
        imageCountWarningalert = nil;
        
        
    }
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
