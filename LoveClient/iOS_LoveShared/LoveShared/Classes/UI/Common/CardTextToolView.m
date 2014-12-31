//
//  CardTextToolView.m
//  Tuotuo
//
//  Created by yangyong on 14-5-4.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "CardTextToolView.h"
//#import "CardCreateSmallCardViewController.h"
@implementation CardTextToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initResource];
    }
    return self;
}

- (void)showViewWithType:(E_TextTool_Type)type
{
    switch (type) {
        case E_TextTool_Type_Picker:
            [self.contentView setContentOffset:CGPointMake(0, 0)];
            break;
        case E_TextTool_Type_Font:
            [self.contentView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            break;
        case E_TextTool_Type_Magic:
            [self.contentView setContentOffset:CGPointMake(self.frame.size.width*2, 0)];
            break;
        case E_TextTool_Type_Size:
            [self.contentView setContentOffset:CGPointMake(self.frame.size.width*3, 0)];
            break;
        case E_TextTool_Type_Bubble:
            [self.contentView setContentOffset:CGPointMake(self.frame.size.width*4, 0)];
            break;

        default:
            break;
    }
}



- (void)initResource
{
    _thisbuttonTag = 100;
    self.fontSize = 20.0f;
    self.fontName = @"Helvetica";
    self.selectColor = [UIColor blackColor];
    self.selectFont = [UIFont fontWithName:self.fontName
                                      size:self.fontSize];
    
    self.bgDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"fontbg_style.plist"]];
    self.contentView = [[UIScrollView alloc] initWithFrame:self.bounds];

    [self addSubview:_contentView];
    [self initColorPicker];
    [self initFontView];
    [self initMagicView];
    [self initSizeView];
    [self initBubbleView];

}


- (void)initColorPicker
{
    _colorPicker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
    _colorPicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	_colorPicker.selectedColor = [UIColor whiteColor];
    _colorPicker.oldColor = [UIColor whiteColor];
	[_colorPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_colorPicker];
}


- (void)initFontView
{
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"Thonburi-Bold",
                              @"MarkerFelt-Wide",
                              @"BradleyHandITCTT-Bold",
                              @"HYg3gj",
                              @"SavoyeLetPlain",
                              @"STHeitiSC-Light",
                              @"PartyLetPlain",
                              @"Zapfino", nil];
    _fontNameArray = array1;
    _fontTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, 216)];
    _fontTableView.delegate = self;
    _fontTableView.dataSource = self;
    _fontTableView.separatorColor = [[UIColor colorWithHexString:@"#888888"] colorWithAlphaComponent:0.6];
    [_fontTableView setBackgroundColor:[UIColor colorWithHexString:@"#454545"]];
    [self.contentView addSubview:_fontTableView];
}


- (void)initMagicView
{
    _magicView = [[ UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    [_magicView setBackgroundColor:[UIColor colorWithHexString:@"#454545"]];
    
    UIScrollView   *fxLabView = [[UIScrollView alloc] initWithFrame:_magicView.bounds];
    fxLabView.pagingEnabled = NO;
    fxLabView.backgroundColor =  [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
    CGFloat height = fxLabView.bounds.size.height / 4;
    NSInteger   clumNum = 5;
    
    if (_spArray == nil) {
        _spArray = [NSMutableArray array];
    }
    
    for (int i = 0; i < clumNum; i ++) {
        
        CustomChangeTextSizeView *lab = [[CustomChangeTextSizeView alloc] initWithFrame:CGRectMake(10, i*(height-10)+6, fxLabView.bounds.size.width-20, height - 10)];
        GLSpecialEfficacyInfo *info = [[GLSpecialEfficacyInfo alloc] init];
        lab.isNotVerCenter = NO;
        lab.isNotPlaceHolder = YES;
        lab.isNotChangeSize = YES;
        [lab setEditable:NO];
//        [lab setSelectable:NO];
        [lab setScrollEnabled:NO];
        NSString *num = @"";

        
      
        lab.font = [UIFont systemFontOfSize:14];
        [lab setTag:i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLab:)];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab addGestureRecognizer:tap];
        tap = nil;
        
        switch (i) {
            case 0:
            {
                //demonstrate shadow
                num= @"one";
                info.innerShadowOffset = CGSizeMake(0.0f, 1.0f);
                info.innerShadowColor = [UIColor blackColor];
                info.innerShadowOpacity = 1.0f;
                info.innerShadowRadius = 1.0f;
                info.normalColor = [UIColor whiteColor];
            }
                break;
            case 1:
            {
                //demonstrate gradient fill
                num= @"two";
                info.gradientStartColor = [UIColor colorWithRed:0.88 green:0.25 blue:0.55 alpha:1];
                info.gradientEndColor = [UIColor colorWithRed:0.21 green:0 blue:0.11 alpha:1];
                info.normalColor = IOS7?nil:[UIColor whiteColor];
            }
                break;
            case 2:
            {
                num= @"three";
                info.gradientStartPoint = CGPointMake(0.0f, 0.0f);
                info.gradientEndPoint = CGPointMake(1.0f, 0.0f);
                info.gadientColors = [NSArray arrayWithObjects:
                                      [UIColor redColor],
                                      [UIColor yellowColor],
                                      [UIColor greenColor],
                                      [UIColor cyanColor],
                                      [UIColor blueColor],
                                      [UIColor purpleColor],
                                      [UIColor redColor],
                                      nil];
                info.innerShadowOffset = CGSizeMake(0.0f, -1.0f);
                info.innerShadowColor =  [UIColor whiteColor];
                info.innerShadowOpacity = 5.0f;
                info.innerShadowRadius = 5.0f;
                info.normalColor = IOS7?nil:[UIColor whiteColor];
            }
                break;
            case 3:
            {
                num= @"four";
                //demonstrate multi-part gradient
                info.innerShadowOffset = CGSizeMake(0.0f, -1.0f);
                info.innerShadowColor =  [UIColor blackColor];
                info.innerShadowOpacity = 1.0f;
                info.innerShadowRadius = 1.0f;
                info.normalColor = [UIColor whiteColor];
                
            }
                break;
            case 4:
            {
                num= @"five";
                info.gradientStartColor = [UIColor colorWithRed:0.19 green:0.09 blue:0 alpha:1];
                info.gradientEndColor = [UIColor colorWithRed:1 green:0.77 blue:0.48 alpha:1];
                info.innerShadowOffset = CGSizeMake(0.0f, -1.0f);
                info.innerShadowColor =  [UIColor blackColor];
                info.innerShadowOpacity = 1.0f;
                info.innerShadowRadius = 0.0f;
                info.normalColor = IOS7?nil:[UIColor whiteColor];
            }
                break;
                
            default:
                break;
        }
        
        lab.text = [NSString stringWithFormat:@"Tuo tuo font style %@",num];
        [GLSpecialEfficacyInfo setGLSpecialEfficacyInfo:info label:lab];
        [_spArray addObject:info];
        info = nil;
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, (i+1)*(height-10), fxLabView.frame.size.width - 15, 0.5)];
        [lineLab setBackgroundColor:[[UIColor colorWithHexString:@"#888888"] colorWithAlphaComponent:0.6]];
         //[UIColor colorWithHexString:@"#454545"]];
        [fxLabView addSubview:lineLab];
        [fxLabView addSubview:lab];
        lineLab = nil;
        lab = nil;
    }
    [fxLabView setContentSize:CGSizeMake(fxLabView.frame.size.width, (height-10) *clumNum)];
    [_magicView addSubview:fxLabView];
    fxLabView = nil;
    [self.contentView addSubview:_magicView];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.slider.value = (fontSize -10)/10.0f;
}


- (void)setThisbuttonTag:(NSInteger)thisbuttonTag
{
    _thisbuttonTag = thisbuttonTag;
    if (thisbuttonTag == 0) {
        self.styleInfo = nil;
    }else{
        self.styleInfo = [self.bgDict objectForKey:[NSString stringWithFormat:@"%d",_thisbuttonTag-100]];
    }
    UIButton *selectButton =  (UIButton *)[_magicContentView  viewWithTag:thisbuttonTag];
    [selectButton setSelected:YES];
    _tempbutton = selectButton;
    if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textFrameInfoWithChanged:andTag:)]) {
        [_delegateValueChange textFrameInfoWithChanged:self.styleInfo andTag:thisbuttonTag];
    }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
        [_delegateValueChange valueChangedWithView:self];
    }
    
    
}

- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
//    _colorPicker.selectedColor = _selectColor;
}

- (void)setFontName:(NSString *)fontName
{
    _fontName = fontName;
    NSInteger fontIndex = [self.fontNameArray indexOfObject:_fontName];
    if (fontIndex >=0  && fontIndex < [self.fontNameArray count]) {
        [self.fontTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:fontIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}



- (void)initSizeView
{
    _sizeView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*3, 0, self.frame.size.width, self.frame.size.height)];
    [_sizeView setBackgroundColor:[UIColor colorWithHexString:@"#454545"]];
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 20, 300, 20)];
    [self.slider addTarget:self action:@selector(blurChanged:) forControlEvents:UIControlEventValueChanged];
    [_sizeView addSubview:self.slider];

    _leftALab = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 100, 40)];
    _rightALab = [[UILabel alloc] initWithFrame:CGRectMake(_sizeView.frame.size.width - 110, 40, 100, 40)];
    [_leftALab setBackgroundColor:[UIColor clearColor]];
    [_rightALab setBackgroundColor:[UIColor clearColor]];
    [_leftALab setText:@"10(Aa)"];
    [_leftALab setTextColor:[UIColor colorWithHexString:@"#c9c9c9"]];
    [_rightALab setTextColor:[UIColor colorWithHexString:@"#c9c9c9"]];
    [_rightALab setTextAlignment:UITextAlignmentRight];
    [_rightALab setText:@"20(Aa)"];
    [_leftALab setFont:[UIFont systemFontOfSize:10.0f]];
    [_rightALab setFont:[UIFont systemFontOfSize:25.0f]];
    [_sizeView addSubview:_leftALab];
    [_sizeView addSubview:_rightALab];
    [self.contentView addSubview:_sizeView];

}


- (void)initBubbleView
{
    _bubbleView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*4, 0, self.frame.size.width, self.frame.size.height)];
    [_bubbleView setBackgroundColor:[UIColor colorWithHexString:@"#454545"]];
    [self.contentView addSubview:_bubbleView];
    [self createmagicContentView];
}




//选择了特效
- (void)tapLab:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag < [_spArray count]) {
        GLSpecialEfficacyInfo *info = (GLSpecialEfficacyInfo *)[_spArray objectAtIndex:tag];
        if (info) {
            _speInfo = info;
            if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textEffectWithChanged:)]){
                [_delegateValueChange textEffectWithChanged:info];
            }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
                [_delegateValueChange valueChangedWithView:self];
            }
        }
    }

}




//字体大小的改变
- (void)blurChanged:(KZUnitSlider *)sender
{
    self.fontSize = 10 + sender.value* 10;
    self.selectFont = [UIFont fontWithName:self.selectFont.fontName size:self.fontSize];
    if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textFontSizeWithChanged:)]) {
        [_delegateValueChange textFontSizeWithChanged:self.fontSize];
    }else if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(fontWithChanged:)]) {
        [_delegateValueChange fontWithChanged:self.selectFont];
    }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
        [_delegateValueChange valueChangedWithView:self];
    }
}






- (void)createmagicContentView
{
    
    UIScrollView *magicContentView = [[UIScrollView alloc] initWithFrame:_bubbleView.bounds];
    magicContentView.pagingEnabled = YES;
    magicContentView.backgroundColor =  [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
    CGFloat width = magicContentView.bounds.size.width / 5;
    CGFloat height = magicContentView.bounds.size.height / 3;
    CGFloat pading = 0.0f;//10.0f;
    int     pageNum = 15;
    int     buttonSum = 15;
    for (int i = 0; i < buttonSum; i++) {
        CGRect rect = CGRectZero;
        int num = i % pageNum;
        rect.origin.x = i/pageNum * _bubbleView.frame.size.width + pading + (num%5)*width;
        rect.origin.y = (num/5)*(height+pading);
        rect.size = CGSizeMake(width, height);
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"makecards_fontbag%d",i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"makecards_fontbg_select"] forState:UIControlStateSelected];
        [button setTag:i+100];
        [button addTarget:self action:@selector(backGroundSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [magicContentView addSubview:button];
        button = nil;
        
        
    }
    [magicContentView setContentSize:CGSizeMake((buttonSum % pageNum == 0 ?buttonSum/pageNum:(buttonSum/pageNum+1))*magicContentView.frame.size.width, magicContentView.frame.size.height)];
    self.magicContentView = magicContentView;
    magicContentView = nil;
    [_bubbleView addSubview:_magicContentView];
}

/**
 *  背景的变化
 *
 *  @param sender
 */
- (void)backGroundSelectAction:(id)sender
{
    if (_tempbutton) {
        [_tempbutton setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        self.selectFont = [UIFont fontWithName:self.fontName size:20.0f];
    }
    if (_thisbuttonTag != button.tag) {
        NSDictionary *styleInfo = [self.bgDict objectForKey:[NSString stringWithFormat:@"%d",button.tag-100]];
        self.styleInfo = styleInfo;
        if (button.tag == 0) {
            self.styleInfo = nil;
        }
        _thisbuttonTag = button.tag;
        if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textFrameInfoWithChanged:andTag:)]) {
            [_delegateValueChange textFrameInfoWithChanged:self.styleInfo andTag:button.tag];
        }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
            [_delegateValueChange valueChangedWithView:self];
        }
    }
    _tempbutton  = button;
    _thisbuttonTag = button.tag;
    [_tempbutton setSelected:YES];
    
}





#pragma mark
#pragma mark FontTableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //字体家族总数
    
    //return [[UIFont familyNames] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //字体家族包括的字体库总数
//    return [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:section] ] count];
    return [_fontNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        UIView *selectView = [[UIView alloc] initWithFrame:cell.bounds];
        selectView.backgroundColor = [[UIColor colorWithHexString:@"#888888"] colorWithAlphaComponent:0.6];
        cell.selectedBackgroundView = selectView;
        selectView = nil;
        cell.selectedTextColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    }
    // Configure the cell.
    cell.textLabel.textColor = self.selectColor;
    //indexPath.row %2 ? [UIColor orangeColor] : [UIColor magentaColor];
    //字体家族名称
//    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    //字体家族中的字体库名称
    NSString *fontName  = [_fontNameArray objectAtIndex:indexPath.row];
    if ([self.text length]> 0 && [self.text stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0) {
        cell.textLabel.text = self.text;
    }else{
        cell.textLabel.text  = [NSString stringWithFormat:@"%@-Abc123!-汉字", fontName ];
    }
    cell.textLabel.font = [UIFont fontWithName:fontName size:14.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1];
    return cell;
    
}

#pragma mark -ColorChange Action

//字体颜色的改变
- (void) pickerChanged:(KZColorPicker *)cp
{
    self.selectColor = cp.selectedColor;
    self.speInfo = nil;
    if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textColorWithChanged:)]) {
        [_delegateValueChange textColorWithChanged:self.selectColor];
    }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
        [_delegateValueChange valueChangedWithView:self];
    }
}




#pragma mark -Font Change Action
//fontName 字体样式的变化
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontName  = [_fontNameArray objectAtIndex:indexPath.row];
    self.fontName = fontName;
    NSLog(@"----%@",self.fontName);
    self.selectFont = [UIFont fontWithName:self.fontName size:self.fontSize];
    if (_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(textFontNameWithChanged:)]) {
        [_delegateValueChange textFontNameWithChanged:self.fontName];
    }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(fontWithChanged:)]){
        [_delegateValueChange fontWithChanged:self.selectFont];
    }else if(_delegateValueChange && [_delegateValueChange respondsToSelector:@selector(valueChangedWithView:)]){
        [_delegateValueChange valueChangedWithView:self];
    }
}




- (void)dealloc
{
    [_contentView removeFromSuperview];
    [_fontTableView removeFromSuperview];
    [_colorPicker removeFromSuperview];
    [_bubbleView removeFromSuperview];
    [_magicContentView removeFromSuperview];
    [_magicView removeFromSuperview];
    [_fontNameArray removeAllObjects];
    [_sizeView removeFromSuperview];
    [_slider removeFromSuperview];
    [_leftALab removeFromSuperview];
    [_rightALab removeFromSuperview];
    [_tempbutton removeFromSuperview];
    [_spArray removeAllObjects];
    
    
    _contentView= nil;
    _fontTableView = nil;
    _colorPicker = nil;
    _bubbleView = nil;
    _magicContentView = nil;
    _magicView  = nil;
    _selectColor  = nil;
    _selectFont  = nil;
    _fontName  = nil;
    _styleInfo  = nil;
    _speInfo  = nil;
    _fontNameArray  = nil;
    _text  = nil;
    _sizeView  = nil;
    _slider  = nil;
    _leftALab  = nil;
    _rightALab  = nil;
    _tempbutton  = nil;
    _bgDict  = nil;
    _spArray  = nil;
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

