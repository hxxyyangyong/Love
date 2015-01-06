//
//  MeituOnceImageViewController.m
//  TestAPP
//
//  Created by yangyong on 14-6-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "MeituOnceImageViewController.h"
#import "GLMeitoPosterSelectViewController.h"
#import "SharedImageViewController.h"
#import "AppDelegate.h"
@interface MeituOnceImageViewController ()

@end

@implementation MeituOnceImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    }
    [self initNavgationBar];
    [self initResource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SIDESLIDE_ONOFF object:@"off" userInfo:nil];
    [D_Main_Appdelegate hiddenPreView];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SIDESLIDE_ONOFF object:@"on" userInfo:nil];
    
}


- (void)initNavgationBar
{
    self.title = D_LocalizedCardString(@"card_select_image_pingtu");
    self.title = D_LocalizedCardString(@"card_select_image_pingtu");
    self.navigationItem.backBarButtonItem = nil;
    UIButton *backButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton setTitle:[NSString stringWithFormat:@" %@",D_LocalizedCardString(@"Button_Back")] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_ios7_back"] forState:UIControlStateNormal];
    
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backButton addTarget:self
                   action:@selector(backButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if(isIOS7){
        negativeSpacer.width = -8;
    }else{
        negativeSpacer.width = 0;
    }
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backButtonItem, nil];
    
    
    UIButton *preViewButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [preViewButton setTitle:D_LocalizedCardString(@"nav_title_preview") forState:UIControlStateNormal];
    [preViewButton addTarget:self
                      action:@selector(preViewBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preViewItem = [[UIBarButtonItem alloc] initWithCustomView:preViewButton];
    self.navigationItem.rightBarButtonItem = preViewItem;
}


- (void)initResource
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_meitu_home"]];
    _blurImageView = [[GLBlurBackgroundView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _blurImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_emptyview"]];
    [self.view addSubview:_blurImageView];
    
    _contentView =  [[UIScrollView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - [self calcContentSize].width)/2.0f, (self.view.frame.size.height - 2*44-iOS7AddStatusHeight - [self calcContentSize].height)/2.0f, [self calcContentSize].width, [self calcContentSize].height)];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_contentView];
    
    _onceImageView = [[MeituImageEditView alloc] initWithFrame:_contentView.bounds];
    
    
    
    UIImage *image = [UIImage imageWithCGImage:self.onceAsset.defaultRepresentation.fullScreenImage];
    ////fullScreenImage
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(_contentView.bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(_contentView.bounds.size.width, _contentView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, _contentView.bounds.size.height)];
    _onceImageView.realCellArea = path;
    [_onceImageView setImageViewData:image];
    [_blurImageView setBackgroundImage:image];
    

    [_onceImageView setClipsToBounds:YES];
    [_onceImageView setBackgroundColor:[UIColor grayColor]];
    [_contentView addSubview:_onceImageView];
    
    _bringPosterView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    [_bringPosterView setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:_bringPosterView];
    [self initBoardAndEditView];

}

- (CGSize)calcContentSize
{
    CGSize retSize = CGSizeZero;
    //CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight);
    CGFloat size_width = self.view.frame.size.width;
    CGFloat size_height = size_width * 4 /3.0f;
    if (size_height > (self.view.frame.size.height - 44 - 50-iOS7AddStatusHeight)) {
        size_height = self.view.frame.size.height - 44 - 50-iOS7AddStatusHeight;
        size_width = size_height * 3/4.0f;
    }
    retSize.width = size_width;
    retSize.height = size_height;
    return  retSize;
}





- (void)initBoardAndEditView
{
    self.boardAndEditView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44- iOS7AddStatusHeight - 27.5 - 15, self.view.frame.size.width, 30)];
    [self.boardAndEditView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.boardAndEditView];
    
    self.boardbutton = [[UIButton alloc] initWithFrame:CGRectMake(75, 0, 75, 30)];
    self.editbutton  = [[UIButton alloc] initWithFrame:CGRectMake(_boardAndEditView.frame.size.width-75-75, 0, 75, 30)];
//    
//    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_normal"] forState:UIControlStateNormal];
//    [self.boardbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_board_highlight"] forState:UIControlStateHighlighted];
//    
//    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_normal"] forState:UIControlStateNormal];
//    [self.editbutton setBackgroundImage:[UIImage imageNamed:@"btn_meitu_edit_highlight"] forState:UIControlStateHighlighted];
    [self.boardbutton setBackgroundColorNormal:[[UIColor colorWithHexString:@"#1fbba6"] colorWithAlphaComponent:0.9] highlightedColor:[[UIColor colorWithHexString:@"#03917e"] colorWithAlphaComponent:0.9]];
    
    [self.editbutton setBackgroundColorNormal:[[UIColor colorWithHexString:@"#f47a75"] colorWithAlphaComponent:0.9] highlightedColor:[[UIColor colorWithHexString:@"#ce5b56"] colorWithAlphaComponent:0.9]];
    
    
    
    [self.boardbutton setTitle:D_LocalizedCardString(@"card_meitu_board") forState:UIControlStateNormal];
    [self.editbutton setTitle:D_LocalizedCardString(@"card_meitu_edit") forState:UIControlStateNormal];
    
    [self.boardbutton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.editbutton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [_boardbutton.layer setCornerRadius:15.0f];
    [_editbutton.layer setCornerRadius:15.0f];
    
    [_boardbutton setClipsToBounds:YES];
    [_editbutton setClipsToBounds:YES];
    [self.boardAndEditView addSubview:_boardbutton];
    [self.boardAndEditView addSubview:_editbutton];
    
    [_boardbutton addTarget:self action:@selector(boardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_editbutton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)boardButtonAction:(id)sender
{
    
    GLMeitoPosterSelectViewController *posterVC = [[GLMeitoPosterSelectViewController alloc] init];
//    posterVC.delegateSelectPet = self;
    posterVC.blurImage = [ImageUtility cutImageWithView:self.contentView];
    [self.navigationController presentViewController:posterVC animated:YES completion:^{
        
    }];
}


- (void)editButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [D_Main_Appdelegate showPreView];
}

#pragma mark
#pragma mark --NavgationBar BackButton And PreviewAction

- (void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [D_Main_Appdelegate showPreView];
}


- (void)releseViewResource
{



}


- (void)preViewBtnAction:(id)sender
{
    SharedImageViewController *sharedVC = [[SharedImageViewController alloc] init];
//    sharedVC.type = E_ModuleType_Meitu;
    sharedVC.image = [ImageUtility cutImageWithView:self.contentView];
    [self.navigationController pushViewController:sharedVC animated:YES];
}

- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
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





#pragma mark
#pragma mark GLMeitoPosterSelectViewControllerDelegate

- (void)didSelectedWithPoster:(NSDictionary *)posterDict isEmpty:(BOOL)isEmpty
{
    if (isEmpty) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.bringPosterView.image = nil;
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
        if ([posterDict objectForKey:@"PosterImagePath"]) {
            self.bringPosterView.image = [UIImage imageWithContentsOfFile:[posterDict objectForKey:@"PosterImagePath"]];
        }
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
