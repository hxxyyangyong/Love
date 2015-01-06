//
//  CardCreateMoodViewController.m
//  TestAPP
//
//  Created by yangyong on 14-5-23.
//  Copyright (c) 2014年 gainline. All rights reserved.
//

#import "CardCreateMoodViewController.h"
#import "SharedImageViewController.h"
//#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define D_MoodBackGroundImage_Height     225
//#import "GLBaseSelectBackgroundViewController.h"
//@interface CardCreateMoodViewController ()<UITextViewDelegate,GLBaseSelectBackgroundViewControllerDelegate>
@interface CardCreateMoodViewController ()<UITextViewDelegate>

@end

@implementation CardCreateMoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.buttonInfoArray = [NSArray array];
        self.buttonInfoArray = [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.plist",[[NSBundle mainBundle] resourcePath],@"MoodButtonStyle"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.contentTextView setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



- (void)initResource
{
    [super initResource];
    self.title = D_LocalizedCardString(@"card_title_mood");
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    
    
    self.contentView.frame = CGRectMake(0, ((self.view.frame.size.height-D_ToolbarWidth-44-iOS7AddStatusHeight)-D_MoodBackGroundImage_Height)/2.0f, self.view.frame.size.width, D_MoodBackGroundImage_Height);

    
    NSString *text = @"";
    CGSize size = [text sizeWithFont:self.contentTextView.textView.font constrainedToSize:CGSizeMake(D_CardTextView_DefaultWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height <= D_CardTextView_DefaultHeight) {
        size.width = D_CardTextView_DefaultWidth - 25;
        size.height = D_CardTextView_DefaultHeight -25;
    }
    
    self.editingTextView.frame = CGRectMake(self.view.frame.size.width - 20 - D_CardTextView_DefaultWidth, 20, size.width + 25, size.height +16 + 25);
    self.editingTextView.maxWidth = self.contentView.frame.size.width;
    self.editingTextView.maxHeight = self.contentView.frame.size.height;
    self.editingTextView.minWidth = D_CardTextView_DefaultWidth;
    self.editingTextView.minHeight = D_CardTextView_DefaultHeight;
    self.editingTextView.isShowEditControl = YES;
    self.editingTextView.isNotPinchExpend = YES;
    
    self.backgroundView.frame = self.contentView.bounds;
    self.toolBarView.moudleType = E_ModuleType_Mood;
    [self.toolBarView setButtonInfoArray:self.buttonInfoArray];
//    self.contentTextView.textView.text = text;
//    self.contentTextView.backgroundColor = [UIColor clearColor];
    

}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches
              withEvent:event];
    [self.editingTextView hideEditingHandles];
}


- (void)allSingleTap:(ZDStickerView *)sticker
{
    self.editingTextView = sticker;
//    [self.contentTextView becomeFirstResponder];
}

- (void)stickerViewDidEdit:(ZDStickerView *)sticker
{
    self.editingTextView = sticker;
    self.contentTextView = sticker.cardTextView;
    self.editingTextView.transform = CGAffineTransformMakeRotation(0);
    if (_textVC == nil) {
         _textVC = [[GLTextEditViewController alloc] init];
         _textVC.isEdit = YES;
        _textVC.delegate = self;
    }
    [_textVC setOldText:self.contentTextView.textView.text
                 color:self.contentTextView.selectedColor
                  font:self.contentTextView.selectedFont
               speInfo:self.contentTextView.speInfo
             thisBgtag:self.contentTextView.bgStyleIndex];
    _textVC.blurImage = [ImageUtility cutImageWithView:self.view];
    [self presentViewController:_textVC animated:YES completion:^{
        
    }];
}


- (void)didCreateTextView:(GLTextEditViewController *)sender
{
    if (sender.isEdit) {
        
        CGRect rect = self.editingTextView.frame;
        self.contentTextView.textView.text= sender.editingTextField.text;
        CGSize size = [sender.editingTextField.text sizeWithFont:sender.selectFont
                                               constrainedToSize:CGSizeMake(D_CardTextView_DefaultWidth - 16, MAXFLOAT)
                                                   lineBreakMode:NSLineBreakByWordWrapping];
        if(size.height> self.contentView.frame.size.height - 25 - 16){
            size.height = self.contentView.frame.size.height - 25 - 16;
        }
        if(size.height < 24 || size.width < 70){
            size.height = 24;
            size.width = D_CardTextView_DefaultWidth;
        }
        self.contentTextView.bounds = CGRectMake(0, 0, size.width, size.height +16);
        [self.contentTextView setText:sender.editingTextField.text
                                 color:sender.selectColor
                                  font:sender.selectFont
                               speInfo:sender.speInfo
                             styleInfo:sender.frameDictInfo
                          bgStyleIndex:sender.bgStyleIndex];
        rect.size = CGSizeMake(size.width, size.height +16+ 25);
        self.editingTextView.frame = rect;
    }
    
    
    //设置背景
    if (sender.frameDictInfo) {
        //如果选择了边框
        CGRect rect = self.editingTextView.frame;
        if ([[sender.frameDictInfo objectForKey:@"ImageName"] length]>0)
        {
            //当有背景的时候
            self.contentTextView.bounds = CGRectMake(0, 0, 150, 150);
            rect.size = CGSizeMake(175, 175);
            self.editingTextView.frame = rect;
            self.editingTextView.isNotExpend = YES;
            self.editingTextView.isNotPinchExpend  = NO;
            //设置cardtextview 中的 textview的位置和大小
            [self.contentTextView resetFrameWithInfo:sender.frameDictInfo bgStyleIndex:sender.bgStyleIndex];
            //相继之后进行字体的自适应
            [self.contentTextView.textView resetFontAndSize];
        }
    }else{
        //如果是nil 则没有选择边框
        self.editingTextView.isNotExpend = NO;
        self.editingTextView.isNotPinchExpend  = YES;
        CGRect rect = self.editingTextView.frame;
        CGSize size = [self.contentTextView.textView.text sizeWithFont:sender.selectFont constrainedToSize:CGSizeMake(D_CardTextView_DefaultWidth - 16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.height > self.contentView.frame.size.height - 16 - 25) {
            size.height = self.contentView.frame.size.height - 16 - 25;
        }
        
        if(size.height < 24 || size.width < 70){
            size.height = 24;
            size.width = D_CardTextView_DefaultWidth;
        }
        
        self.contentTextView.bounds = CGRectMake(0, 0, size.width, size.height +16);
        rect.size = CGSizeMake(size.width, size.height +16+ 25);
        self.editingTextView.frame = rect;
        [self.contentTextView resetFrameWithInfo:sender.frameDictInfo bgStyleIndex:sender.bgStyleIndex];
        [self.contentTextView.textView resetFontAndSize];
    }

    if (self.editingTextView.frame.size.height == self.contentView.frame.size.height) {
        [self.contentTextView resetFontAndSize];
    }
    if (self.contentTextView.textView.text.length ==0) {
        [self.contentTextView.textView setFont:[UIFont fontWithName:sender.fontName size:20]];
    }
    
    self.editingTextView.transform = CGAffineTransformMakeRotation(self.editingTextView.angleValue);
    

}


#pragma mark
#pragma mark --PreviewAction
- (void)preViewBtnAction:(id)sender
{
    [self.editingTextView hiddenBoarderView];
    if (self.contentTextView.textView.text.length <= 0) {
        [self.contentTextView setHidden:YES];
    }
    [self.contentView setContentOffset:CGPointMake(0, 0)];
    SharedImageViewController *sharedVC = [[SharedImageViewController alloc] init];
    sharedVC.image = [ImageUtility cutImageWithView:self.contentView];
    [self.navigationController pushViewController:sharedVC animated:YES];
}




#pragma mark
#pragma mark
- (void)didSelectWithButtonTag:(NSInteger)tag info:(NSDictionary *)dict
{
    if (tag != [self.buttonInfoArray count] -1) {
        NSString *imageName = [NSString stringWithFormat:@"mood_style_img_%ld.jpg",tag];
        [self.backgroundView setImage:[ImageUtility imageWithStyleName:imageName]];
        [self.blurImageView setBackgroundImage:[ImageUtility imageWithStyleName:imageName]];
    }else{
//        GLBaseSelectBackgroundViewController *gcVC = [[GLBaseSelectBackgroundViewController alloc] init];
//        gcVC.resourceType = E_ResourceType_Mood;
//        gcVC.delegateSelectPet = self;
//        gcVC.blurImage = [ImageUtility cutImageWithView:self.contentView];
//        [self.navigationController presentViewController:gcVC animated:YES completion:^{
//            
//        }];
    }
}
//#pragma mark 
//#pragma mark GLBaseSelectBackgroundViewControllerDelegate
//- (void)didSelectedWithPet:(NSDictionary *)petDict resourceInfo:(GLEntity_Resource *)resourceInfo
//{
//    
//    if (petDict) {
//        if ([petDict objectForKey:@"BackImageFilePath"]) {
//            [self.backgroundView setImage:[UIImage imageWithContentsOfFile:[petDict objectForKey:@"BackImageFilePath"]]];
//            [self.blurImageView setBackgroundImage:[UIImage imageWithContentsOfFile:[petDict objectForKey:@"BackImageFilePath"]]];
//        }
//    }
//}


- (void)dealloc
{
    _textVC = nil;
    NSLog(@"%@::::::::deallloc",[self class]);
}

@end
