//
//  GLCardBaseViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-6-27.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLCardBaseViewController.h"
//#import "IQKeyBoardManager.h"
@interface GLCardBaseViewController ()

@end

@implementation GLCardBaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _buttonInfoArray = [NSArray array];
//        _buttonInfoArray = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.plist",[[NSBundle mainBundle] resourcePath],@"MoodButtonStyle"]];
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
    [self initResource];
    self.title = D_LocalizedCardString(@"card_title_mood");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SIDESLIDE_ONOFF object:@"off" userInfo:nil];
    NSLog(@"%f", [[[UIDevice currentDevice] systemVersion] floatValue]);
    if (!IOS7) {
        [(CRNavigationController *)self.navigationController setCanDragBack:NO];
    }
    [self.contentTextView setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SIDESLIDE_ONOFF object:@"on" userInfo:nil];
    if (!IOS7) {
        [(CRNavigationController *)self.navigationController setCanDragBack:YES];
    }
}


- (CGSize)calcContentSize
{
    CGSize retSize = CGSizeZero;
    //CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight);
    CGFloat size_width = self.view.frame.size.width;
    CGFloat size_height = size_width * 4 /3.0f;
    if (size_height > (self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight)) {
        size_height = self.view.frame.size.height - 2*D_ToolbarWidth-iOS7AddStatusHeight;
        size_width = size_height * 3/4.0f;
    }
    retSize.width = size_width;
    retSize.height = size_height;
    return  retSize;
}


- (void)initResource
{
    self.title = D_LocalizedCardString(@"card_title_mood");
    self.view.backgroundColor = [UIColor whiteColor];
    _blurImageView = [[GLBlurBackgroundView alloc] initWithFrame:CGRectMake(0,0,
                                                                            self.view.frame.size.width,
                                                                            self.view.frame.size.height-44-iOS7AddStatusHeight)];
    [_blurImageView setBackgroundImage:[ImageUtility imageWithStyleName:D_BlurImageName]];
    [self.view addSubview:_blurImageView];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ((self.view.frame.size.height-D_ToolbarWidth-44-iOS7AddStatusHeight)-self.view.frame.size.width)/2.0f, self.view.frame.size.width, self.view.frame.size.width)];
    _contentView.backgroundColor = [UIColor clearColor];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    [_backgroundView setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeRedraw];
    [_backgroundView setBackgroundColor:[UIColor clearColor]];
    [_backgroundView setImage:[ImageUtility imageWithStyleName:D_BlurImageName]];
    [_backgroundView setClipsToBounds:YES];
    
    [_contentView addSubview:_backgroundView];
    [self.view addSubview:_contentView];
    
    _decorationButton  = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.center.x - 30, self.contentView.frame.size.height, 75, 30)];
    _decorationButton.layer.cornerRadius  = 15.f;
//    _decorationButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    [_decorationButton setBackgroundColorNormal:[[UIColor colorWithHexString:@"#1fbba6"] colorWithAlphaComponent:0.9] highlightedColor:[[UIColor colorWithHexString:@"#03917e"] colorWithAlphaComponent:0.9]];
    [_decorationButton setClipsToBounds:YES];
    [_decorationButton  setTitle:D_LocalizedCardString(@"card_essay_decoration") forState:UIControlStateNormal];
    [self.view addSubview:_decorationButton];
    [_decorationButton setHidden:YES];
    
    
    
    _toolBarView = [[GLCardBaseVCBottomBar alloc] initWithFrame:CGRectMake(0,
                                                                           self.view.frame.size.height-44-iOS7AddStatusHeight - 44,
                                                                           self.view.frame.size.width,
                                                                           44)];
    _toolBarView.delegateAction = self;
    [self.view addSubview:_toolBarView];
    [self initTextView];
    [self initNavgationBar];
}


- (void)initTextView
{
    CardTextView *editView = [[CardTextView alloc] initWithFrame:CGRectMake(0, 0, D_CardTextView_DefaultWidth, D_CardTextView_DefaultHeight) textColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:20.0f]];
    ZDStickerView *zdView = [[ZDStickerView alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width - 170, 0, D_CardTextView_DefaultWidth, D_CardTextView_DefaultHeight)];
    zdView.contentView = editView;
    zdView.delegate = self;
    self.contentTextView = editView;
    [zdView setIsShowResizingControl:YES];
    [zdView setIsShowBoarderControl:YES];
    [zdView setIsShowEditControl:YES];
    [zdView showEditingHandles];
    [zdView setIsNotEditable:YES];
    self.editingTextView = zdView;
    self.contentTextView.textView.placeholder = @"点击编辑添加文字";
    [self.contentView addSubview:zdView];
    self.toolBarView.delegateAction = self;
    editView = nil;
    zdView = nil;
}



- (void)initNavgationBar
{
    UIButton *preViewButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [preViewButton setTitle:D_LocalizedCardString(@"nav_title_preview") forState:UIControlStateNormal];
    [preViewButton addTarget:self
                      action:@selector(preViewBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *preViewItem = [[UIBarButtonItem alloc] initWithCustomView:preViewButton];
    self.navigationItem.rightBarButtonItem = preViewItem;
    preViewButton = nil;
    preViewItem = nil;
}


#pragma mark
#pragma mark --PreviewAction
- (void)preViewBtnAction:(id)sender
{
    [self.editingTextView hiddenBoarderView];
    if (self.contentTextView.textView.text.length <= 0) {
        [self.contentTextView setHidden:YES];
    }
//    SharedImageViewController *sharedVC = [[SharedImageViewController alloc] init];
//    sharedVC.image = [ImageUtility captureScrollView:self.contentView];
//    [self.navigationController pushViewController:sharedVC animated:YES];
//    sharedVC = nil;
}



#pragma mark
#pragma mark
- (void)didSelectWithButtonTag:(NSInteger)tag info:(NSDictionary *)dict
{
        NSString *imageName = [NSString stringWithFormat:@"baseboard_%d.jpg",tag];
        [self.backgroundView setImage:[ImageUtility imageWithStyleName:imageName]];
        [self.blurImageView setBackgroundImage:[ImageUtility imageWithStyleName:imageName]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{

    [_contentView  removeFromSuperview];
    _contentView = nil;
    [_backgroundView  removeFromSuperview];
    _backgroundView = nil;
    [_contentTextView removeFromSuperview];
    _contentTextView = nil;
    [_toolBarView removeFromSuperview];
    _toolBarView = nil;
    [_blurImageView removeFromSuperview];
    _blurImageView = nil;
    [_editingTextView removeFromSuperview];
    _editingTextView = nil;
    [_decorationButton removeFromSuperview];
    _decorationButton  = nil;
    _buttonInfoArray = nil;
        NSLog(@"%@::::::::deallloc",[self class]);
    
}


@end
