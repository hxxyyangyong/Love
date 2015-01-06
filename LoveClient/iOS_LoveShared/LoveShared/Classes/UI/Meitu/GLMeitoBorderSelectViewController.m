//
//  GLMeitoBorderSelectViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-7-22.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLMeitoBorderSelectViewController.h"

@interface GLMeitoBorderSelectViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageCount;

@end

@implementation GLMeitoBorderSelectViewController

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
//    self.userVipLevel = D_Default_Userlevel;
    self.pageIndex = 1;
    self.pageCount = 9;
    _dataArray = [[NSMutableArray alloc] init];
    [_dataArray addObject:[NSDictionary dictionary]];
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_select_resource"]];
    _backgroundImageView = [[GLBlurBackgroundView alloc] initWithFrame:self.view.bounds];//_baseboardTableView.frame
    [_backgroundImageView setBackgroundImage:_blurImage gray:YES];
    [self.view addSubview:_backgroundImageView];
    [self initControlView];
    [self initResource];
    self.title = D_LocalizedCardString(@"card_meitu_board_list_title");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        if (IOS7) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
            if (IOS7) {
         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initWithData];
    
}



- (void)initResource
{
    _notNavView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                           44,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height- 44)];
    [self.view addSubview:_notNavView];
    
    _petTableView = [[UITableView alloc] initWithFrame:_notNavView.bounds];
    _petTableView.delegate = self;
    _petTableView.dataSource = self;
    [_petTableView setBackgroundColor:[UIColor clearColor]];
    _petTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_notNavView addSubview:_petTableView];
    
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
//    [self.petTableView addFooterWithTarget:self action:@selector(initWithData)];
}




- (void)initWithData
{
    
    NSString *dataJsonPATH = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"Board.geojson"];
    NSString *dataJsonStr = [NSString stringWithContentsOfFile:dataJsonPATH encoding:NSUTF8StringEncoding error:nil];
    NSArray *resultArray = [dataJsonStr  objectFromJSONString];
    [self.dataArray addObjectsFromArray:[GLEntity_Resource resourcelistWithResultArray:resultArray]];
    [self.petTableView reloadData];
    
//    if (_isNotablePullLoad == YES) {
//       [self.petTableView footerEndRefreshing];
//       [self.petTableView addInfoText:D_LocalizedCardString(@"Prompt_After_Null")];
//        return;
//    }
//    [[LoadingViewManager sharedInstance] showLoadingViewInView:_notNavView
//                                                      withText:@"正在加载"];
//    GLItem_GetResourcesByType *item = [[GLItem_GetResourcesByType alloc] init];
//    item.type = E_ResourceType_MeituPinjieBoardList;
//    item.currentPage = self.pageIndex;
//    item.showCount = self.pageCount;
//    [item setSuccessCallback:^(HttpBaseItem *item) {
//        [self.petTableView footerEndRefreshing];
//        [[LoadingViewManager sharedInstance] removeLoadingView:_notNavView];
//        NSString *resultString = item.resultStrWithResponseData;
//        
//        NSString *validateResult = [[TuoTuoHttpEngineCenter sharedLoginEngine] validateResultStepOne:resultString];
//        if (validateResult)
//        {
//            //[self cusAlertWithString:validateResult];
//        }
//        else
//        {
//            NSArray *tempArr = [resultString componentsSeparatedByString:RETURN_DATA_SPILT_STRING];
//            @try {
//                NSArray *resultArray = [[tempArr objectAtIndex:0] objectFromJSONString];
//                
////                if (resultArray.count >= self.pageCount) {
////                    _isNotablePullLoad = NO;
////                    _pageIndex++;
////                }else{
////                    NSLog(@"后面没有了！！");
////                    _isNotablePullLoad = YES;
////                }
//                if ([tempArr count] > 1) {
//                    NSInteger serverPageCount = [[tempArr objectAtIndex:1] integerValue];
//                    
//                    if (serverPageCount <= self.pageIndex) {
//                        _isNotablePullLoad = YES;
//                         [self.petTableView addInfoText:D_LocalizedCardString(@"Prompt_After_Null")];
//                        
//                    }else{
//                        _isNotablePullLoad = NO;
//                        _pageIndex++;
//                    }
//                }
//                
//                [self.dataArray addObjectsFromArray:[GLEntity_Resource resourcelistWithResultArray:resultArray]];
//                [self.petTableView reloadData];
//            }
//            @catch (NSException *exception) {
//                NSLog(@"__%@__exception__%@", [self class], exception.reason);
//            }
//            
//        }
//    } failureCallback:^(HttpBaseItem *item) {
//        [self.petTableView footerEndRefreshing];
//        [[LoadingViewManager sharedInstance] removeLoadingView:_notNavView];
//        [[LoadingViewManager sharedInstance] showHUDWithText:@"加载失败" inView:_notNavView duration:0.3];
//    }];
//    [[TuoTuoHttpEngineCenter sharedTuoTuoEngine] invokeItem:item];
//    
//    
}


- (void)initControlView
{
    _controlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+0)];
    _controlView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    _dissMissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_dissMissBtn addTarget:self action:@selector(dissMissBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dissMissBtn setImage:[ImageUtility imageWithStyleName:@"makekards_turnoff_icon"] forState:UIControlStateNormal];
    [_controlView addSubview:_dissMissBtn];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(44,
                                                          0,
                                                          _controlView.frame.size.width - 44 *2,
                                                          44)];
    [_titleLab setBackgroundColor:[UIColor clearColor]];
    [_titleLab setTextColor:[UIColor colorWithHexString:@"#454545"]];
   [_titleLab setFont:[UIFont systemFontOfSize:18.0f]];
    [_titleLab setTextAlignment:UITextAlignmentCenter];
    [_titleLab setText:D_LocalizedCardString(@"card_meitu_board_list_title")];
    [_controlView addSubview:_titleLab];
    [self.view addSubview:_controlView];
    
}

- (void)dissMissBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}




#pragma mark
#pragma mark TableView DataSource & Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _petTableView) {
        return [_dataArray count] % 3 == 0 ? [_dataArray count] / 3: [_dataArray count] / 3 +1;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _petTableView) {
        return 110;
    }
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _petTableView) {
        
        
        static NSString *cellIdentify = @"GLPetSelectTableViewCell";
        GLMeitoBorderSelectCell *cell  = (GLMeitoBorderSelectCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil) {
            cell = [[GLMeitoBorderSelectCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:cellIdentify];
        }
        
        if (indexPath.row*3+0 == 0) {
            
            [cell.petOne setNativeResourceImage:[UIImage imageNamed:@"noting_return_icon"]];
            
        }else{
            if(indexPath.row*3+0 < [_dataArray count]){
                cell.petOne.hidden = NO;
                [cell.petOne setResourceInfo:[_dataArray objectAtIndex:indexPath.row*3]
                                   userLevel:self.userVipLevel];
            }else{
                cell.petOne.hidden = YES;
            }
        }
        
        if(indexPath.row*3+1 < [_dataArray count]){
            cell.petTwo.hidden = NO;
            [cell.petTwo setResourceInfo:[_dataArray objectAtIndex:indexPath.row*3 + 1]
                               userLevel:self.userVipLevel];
        }else{
            cell.petTwo.hidden = YES;
        }
        
        if(indexPath.row*3+2 < [_dataArray count]){
            cell.petThree.hidden = NO;
            [cell.petThree setResourceInfo:[_dataArray objectAtIndex:indexPath.row*3 + 2]
                                 userLevel:self.userVipLevel];
        }else{
            cell.petThree.hidden = YES;
        }
        
        cell.delegateCell = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
}


#pragma mark
#pragma mark - 边框的view的delegate

- (void)didSelectBorderWith:(GLMeitoBorderSelectView *)sender
{
    if (sender.levelNum > self.userVipLevel) {
//        [GLCommonAlert showLevelNotEnoughWarningAlert];
    }else{
        if (sender.isEnable) {
            
            if (_delegateSelectPet &&
                [_delegateSelectPet respondsToSelector:@selector(didSelectedWithBorder:isEmpty:)])
            {
                [_delegateSelectPet didSelectedWithBorder:sender.borderDict isEmpty:sender.isEmpty];
            }
            [self dismissViewControllerAnimated:YES
                                     completion:^{
                                         
                                     }];
            
        }else{
//            [GLCommonAlert showNotDownloadWarningAlert];
        }
    }
    
}




- (void)downloadStartWith:(GLMeitoBorderSelectView *)sender
{
    [[LoadingViewManager sharedInstance] showLoadingViewInView:self.notNavView
                                                      withText:@"正在下载..."];
}

- (void)downloadEndWith:(GLMeitoBorderSelectView *)sender
{
    [[LoadingViewManager sharedInstance] removeLoadingView:self.notNavView];
}

- (void)downloadErrorWith:(GLMeitoBorderSelectView *)sender
{
    [[LoadingViewManager sharedInstance] removeLoadingView:self.notNavView];
    [[LoadingViewManager sharedInstance] showHUDWithText:@"下载失败" inView:self.notNavView duration:0.3];
}



- (void)dealloc
{
    
    [_dissMissBtn removeFromSuperview];
    [_titleLab removeFromSuperview];
    [_controlView removeFromSuperview];
    [_notNavView removeFromSuperview];
    [_backgroundImageView removeFromSuperview];
    [_petTableView removeFromSuperview];
    [_dataArray removeAllObjects];
    
    _dissMissBtn = nil;
    _titleLab = nil;
    _controlView = nil;
    _notNavView = nil;
    _backgroundImageView = nil;
    _petTableView = nil;
    _dataArray = nil;
    _blurImage = nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end