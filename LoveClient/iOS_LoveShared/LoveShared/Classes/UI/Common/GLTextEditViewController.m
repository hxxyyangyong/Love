//
//  GLTextEditViewController.m
//  Tuotuo
//
//  Created by yangyong on 14-8-7.
//  Copyright (c) 2014年 Gaialine. All rights reserved.
//

#import "GLTextEditViewController.h"
#define D_ToolbarWidth      44
@interface GLTextEditViewController ()

@end

@implementation GLTextEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fontSize = 20.0f;
        self.fontName = @"Helvetica";
        self.selectFont = [UIFont fontWithName:@"Helvetica" size:20.f];
        self.selectColor =  [UIColor whiteColor];
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.bgStyleIndex = 100;
        self.maxTextNum = 140;
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
    _backgroundView = [[GLBlurBackgroundView alloc] initWithFrame:self.view.bounds];
    [_backgroundView setBackgroundImage:_blurImage gray:YES];
    [self.view addSubview:_backgroundView];    
    
    [self initControlView];
    [self initResource];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registNotification];
    //[IQKeyBoardManager disableKeyboardManager];
    if (IOS7) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeNotification];
        //[IQKeyBoardManager enableKeyboardManger];
    if (IOS7) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }

}

- (void)setBlurImage:(UIImage *)blurImage
{
    _blurImage = blurImage;
    if (_backgroundView) {
        [_backgroundView setBackgroundImage:_blurImage gray:YES];
    }
    
}

- (void)initResource
{
    self.view.backgroundColor  = [UIColor clearColor];
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                      44,
                                                                      self.view.frame.size.width,
                                                                      self.view.frame.size.height- 44)];

    _boardView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width -20, self.view.frame.size.height-iOS7AddStatusHeight -44-44 - 216+2)];
    _boardView.layer.borderWidth = 1.0f;
    _boardView.layer.borderColor = [UIColor whiteColor].CGColor;
    _boardView.layer.cornerRadius = 4.0f;
    [self.contentView addSubview:_boardView];
    _editingTextField = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(11, 11, self.view.frame.size.width -22, self.view.frame.size.height-iOS7AddStatusHeight -44-44 - 216)];
    _editingTextField.delegate = self;
    _editingTextField.textColor = _selectColor== nil?[UIColor whiteColor]:_selectColor;
    [_editingTextField setBackgroundColor:[UIColor clearColor]];
    [_editingTextField setFont:[UIFont fontWithName:self.fontName size:20]];
    _editingTextField.placeholder = @"点击输入文字";
    [self.contentView addSubview:_editingTextField];
    [self.view addSubview:_contentView];
    [self initTextToolBarAndView];
    
    if (self.isEdit) {
        self.editingTextField.text = _oldText;
    }

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
    [_titleLab setFont:[UIFont systemFontOfSize:18.0]];
    [_titleLab setTextAlignment:UITextAlignmentCenter];
    [_titleLab setText:@"编辑文字"];
    [_controlView addSubview:_titleLab];
    [self.view addSubview:_controlView];
    
    
    _confirmBtn  = [[UIButton alloc] initWithFrame:CGRectMake(_controlView.frame.size.width - 54, 0,44, 44)];
    [_confirmBtn setTitle:D_LocalizedCardString(@"card_music_select_complete") forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitleColor:[UIColor colorWithRed:0.5 green:0.51 blue:0.52 alpha:1] forState:UIControlStateDisabled];
    [_confirmBtn setTitleColor:[UIColor colorWithRed:0.5 green:0.51 blue:0.52 alpha:1] forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#454545"] forState:UIControlStateHighlighted];
    [_controlView addSubview:_confirmBtn];

    
}

- (void)dissMissBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}



#pragma mark
#pragma mark --PreviewAction
- (void)confirmBtnAction:(id)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(didCreateTextView:)]) {
            [_delegate didCreateTextView:self];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)initTextToolBarAndView
{
    _textToolView = [[CardTextToolView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height+D_ToolbarWidth, self.view.frame.size.width, 216)];
    _textToolView.delegateValueChange = self;
    _textToolView.fontSize = 20.0f;
    self.fontSize = 20.0f;
    [self.view addSubview:_textToolView];
    
    _textToolBar = [[CreateCardTextToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, D_ToolbarWidth)];
    _textToolBar.delegateAction = self;
    [_textToolBar.bubbleButton setHidden:YES];
    [self.view addSubview:_textToolBar];
    
}


#pragma mark
#pragma mark ---CardTextToolBarDelegate Action

- (void)showTextToolBar
{
    if (self.textToolBar.frame.origin.y >= self.view.frame.size.height) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.textToolBar.frame = CGRectMake(0, self.view.frame.size.height - D_ToolbarWidth, self.view.frame.size.width, D_ToolbarWidth);
                             self.textToolView.frame = CGRectMake(0, _textToolBar.frame.origin.y + D_ToolbarWidth, _textToolView.frame.size.width, _textToolView.frame.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}


- (void)responseToTextColorAction:(CreateCardTextToolBar *)sender
{
    [self showTextView];
    [_textToolView showViewWithType:E_TextTool_Type_Picker];
}

- (void)responseToTextFontAction:(CreateCardTextToolBar *)sender
{
    [self showTextView];
    [_textToolView showViewWithType:E_TextTool_Type_Font];
}

- (void)responseToTextMagicAction:(CreateCardTextToolBar *)sender
{
    [self showTextView];
    [_textToolView showViewWithType:E_TextTool_Type_Magic];
}

- (void)responseToTextSizeAction:(CreateCardTextToolBar *)sender
{
    [self showTextView];
    [_textToolView showViewWithType:E_TextTool_Type_Size];
}



- (void)responseToTextBubbleAction:(CreateCardTextToolBar *)sender
{
    [self showTextView];
    [_textToolView showViewWithType:E_TextTool_Type_Bubble];
}


- (void)responseToHiddenAction:(CreateCardTextToolBar *)sender
{
//    [self.editingView hideEditingHandles];
    [self hiddenTextToolBarView];
}




- (void)showTextView
{
    [self.editingTextField resignFirstResponder];
    if (_textToolView.frame.origin.y >= self.view.frame.size.height) {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect rect = _textToolBar.frame;
            rect.origin.y = self.view.frame.size.height - D_ToolbarWidth - _textToolView.frame.size.height;
            _textToolBar.frame = rect;
            _textToolView.frame = CGRectMake(0, _textToolBar.frame.origin.y + D_ToolbarWidth, _textToolView.frame.size.width, _textToolView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)hiddenTextToolBarView
{
    
    [self.editingTextField resignFirstResponder];
//    [self.editingView hideEditingHandles];
//    self.contentView.contentSize = self.contentView.frame.size;
//    self.contentView.contentOffset = CGPointMake(0, 0);
    if (_textToolView.frame.origin.y < self.view.frame.size.height) {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect rect = _textToolBar.frame;
            rect.origin.y = self.view.frame.size.height;
            _textToolBar.frame = rect;
            _textToolView.frame = CGRectMake(0, _textToolBar.frame.origin.y + D_ToolbarWidth, _textToolView.frame.size.width, _textToolView.frame.size.height);
            //            [self.contentView setContentSize:self.contentView.frame.size];
        } completion:^(BOOL finished) {
            
        }];
    }
    
}



#pragma mark
#pragma mark CardTextToolViewDelegate

/**
 *  颜色的改变
 *  颜色和特效只能选其一
 *  @param color
 */
- (void)textColorWithChanged:(UIColor *)color
{
    self.selectColor = color;
    self.editingTextField.textColor = self.selectColor;
    //将当前的特效设为空 并将阴影去掉
    self.speInfo = nil;
    [self.editingTextField clearSpecialEfficacy];
}

- (void)textFontNameWithChanged:(NSString *)fontName
{
    self.fontName = fontName;
    self.selectFont = [UIFont fontWithName:fontName size:self.fontSize];
    self.editingTextField.font = self.selectFont;
}

- (void)textFontSizeWithChanged:(CGFloat)fontSize
{
    self.fontSize = fontSize;
    self.selectFont = [UIFont fontWithName:(self.fontName == nil?@"Helvetica":self.fontName) size:fontSize];
    self.editingTextField.font = self.selectFont;
}

- (void)textFrameInfoWithChanged:(NSDictionary *)dict andTag:(NSInteger)tag
{
    self.frameDictInfo = dict;
    self.bgStyleIndex = tag;
    if (tag == 0) {
        self.selectFont = [UIFont fontWithName:self.fontName size:20.0f];
    }
}

- (void)textEffectWithChanged:(GLSpecialEfficacyInfo *)speinfo
{
    self.speInfo = speinfo;
    if (speinfo) {
        self.selectColor = nil;
        [self.editingTextField clearSpecialEfficacy];
        [GLSpecialEfficacyInfo setGLSpecialEfficacyInfo:self.speInfo label:self.editingTextField];
    }
}


- (void)valueChangedWithView:(CardTextToolView *)toolView
{
    
    self.selectColor = toolView.selectColor;
    self.selectFont = toolView.selectFont;
    self.fontSize = toolView.fontSize;
    self.fontName = toolView.fontName;
    self.speInfo = toolView.speInfo;
    self.frameDictInfo = toolView.styleInfo;
    [GLSpecialEfficacyInfo setGLSpecialEfficacyInfo:self.speInfo label:self.editingTextField];

}


#pragma mark
#pragma mark - Notification Center 键盘的移动

- (void)registNotification
{
    //增加多键盘事件的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // 键盘高度变化通知，ios5.0新增的
    if (_TASK_IOS_VERSION >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView transitionWithView:self.view
                      duration:animationDuration
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        
                        
                        _textToolView.frame = CGRectMake(0,self.view.frame.size.height - _textToolView.frame.size.height,_textToolView.frame.size.width, _textToolView.frame.size.height);
                        
                        CGRect rectAddLogViewFrame = _textToolBar.frame;
                        rectAddLogViewFrame.origin.y = self.view.frame.size.height - _textToolBar.frame.size.height - keyboardRect.size.height;
                        _textToolBar.frame = rectAddLogViewFrame;
//                        [self.editingView showEditingHandles];
//                        [self movetextField:keyboardRect.size.height];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    if ([self isShowTextToolView]) {//当前是显示的话 不做操作
        CGRect rectAddLogView = _textToolBar.frame;
        rectAddLogView.origin.y = _textToolView.frame.origin.y - _textToolBar.frame.size.height;
        _textToolBar.frame = rectAddLogView;
        
        return;
    }else {
        [UIView transitionWithView:self.view
                          duration:animationDuration
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            CGRect rectAddLogView = _textToolBar.frame;
                            rectAddLogView.origin.y = self.view.frame.size.height - keyboardRect.size.height - rectAddLogView.size.height;
                            _textToolBar.frame = rectAddLogView;
                            _textToolView.frame = CGRectMake(0,self.view.frame.size.height,_textToolView.frame.size.width, _textToolView.frame.size.height);
                            //_textToolBar.frame.origin.y+D_ToolbarWidth, _textToolView.frame.size.width, _textToolView.frame.size.height);
//                            [self.editingView hideEditingHandles];
                        }
                        completion:^(BOOL finished) {
                            
                        }];
    }
    
}


- (BOOL)isShowTextToolView
{
    if (self.textToolBar.frame.origin.y+self.textToolBar.frame.size.height >= self.view.frame.size.height ) {
        return NO;
    }else{
        return YES;
    }
}

- (void)movetextField:(CGFloat)height
{
        _keyboardHeight = height;
        CGFloat a = self.editingTextField.frame.origin.y + self.editingTextField.frame.size.height + self.contentView.frame.origin.y;
        CGFloat b = self.view.frame.size.height - height - D_ToolbarWidth;
        if (a > b) {
            [self.contentView setContentSize:CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height + (a-b))];//+ height + D_ToolbarWidth
            [self.contentView setContentOffset:CGPointMake(0, a - b) animated:YES];
        }
}



- (void)resetEditViewFrame
{

    
}

- (void)setOldText:(NSString *)oldText
             color:(UIColor *)color
              font:(UIFont *)font
           speInfo:(GLSpecialEfficacyInfo *)speInfo
         thisBgtag:(NSInteger)tag
{
    
    _selectColor = color;
    _selectFont = font;
    _speInfo = speInfo;
    _bgStyleIndex = tag;
    
    _editingTextField.text= oldText;
    _editingTextField.textColor = (_selectColor == nil) ? [UIColor whiteColor]:_selectColor;
    _textToolView.colorPicker.selectedColor = (_selectColor == nil) ? [UIColor whiteColor]:_selectColor;
    _editingTextField.font = font;
    [_textToolView setFontName:self.selectFont.fontName];
    [_textToolView setFontSize:self.selectFont.pointSize];
    
    if (speInfo) {
        _speInfo = speInfo;
        [_editingTextField setSpeInfo:speInfo];
        _selectColor = speInfo.normalColor;
    }
    _textToolView.thisbuttonTag = _bgStyleIndex;

}

- (void)setOldText:(NSString *)oldText
             color:(UIColor *)color
              font:(UIFont *)font
           speInfo:(GLSpecialEfficacyInfo *)speInfo
         styleInfo:(NSDictionary *)dict
         thisBgtag:(NSInteger)tag
{
    
    _selectColor = color;
    _selectFont = font;
    _speInfo = speInfo;
    _bgStyleIndex = tag;
    _frameDictInfo = dict;
    
    _editingTextField.text= oldText;
    _editingTextField.textColor = (_selectColor == nil) ? [UIColor whiteColor]:_selectColor;
    _textToolView.colorPicker.selectedColor = (_selectColor == nil) ? [UIColor whiteColor]:_selectColor;
    _editingTextField.font = font;
    [_textToolView setFontName:self.selectFont.fontName];
    [_textToolView setFontSize:self.selectFont.pointSize];
    
    if (speInfo) {
        _speInfo = speInfo;
        [_editingTextField setSpeInfo:speInfo];
        _selectColor = speInfo.normalColor;
    }
    _textToolView.thisbuttonTag = _bgStyleIndex;
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([string length] > _maxTextNum)
    {
        
        string = [string substringToIndex:_maxTextNum];
        textView.text = string;
        return NO;
    }
    return  YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    
    
    [_controlView removeFromSuperview];
    _controlView = nil;
    
    [_dissMissBtn removeFromSuperview];
    _dissMissBtn = nil;
    
    [_titleLab removeFromSuperview];
    _titleLab = nil;
    
    [_confirmBtn removeFromSuperview];
    _confirmBtn = nil;
    
    [_contentView removeFromSuperview];
    _contentView = nil;
    
    [_boardView removeFromSuperview];
    _boardView = nil;
    
    [_editingTextField removeFromSuperview];
    _editingTextField = nil;
    
    [_textToolBar removeFromSuperview];
    _textToolBar = nil;
    
    [_textToolView removeFromSuperview];
    _textToolView = nil;
    
    [_dissMissBtn removeFromSuperview];
    _dissMissBtn = nil;
    
    _oldText = nil;
    _selectFont = nil;
    _selectColor = nil;
    _fontName= nil;
    _frameDictInfo = nil;
    _speInfo = nil;
    
    [_backgroundView removeFromSuperview];
    _backgroundView  = nil;
    _blurImage = nil;
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
