//
//  ZDStickerView.m
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "ZDStickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kSPUserResizableViewGlobalInset 10.0//5.0
#define kSPUserResizableViewDefaultMinWidth 80.0//48.0
#define kSPUserResizableViewDefaultMaxWidth 400//48.0
#define kSPUserResizableViewInteractiveBorderSize 0.0//10.0
#define kZDStickerViewControlSize 18.0//36.0
#define D_Lattice_Width     5.0
#define D_Lattice_Height     5.0


#define k_TextView_MinWidth  175
#define k_TextView_MinHeight 86

#define k_TextView_MaxWidth  1000
#define k_TextView_MaxHeight 1000


#define k_ContentView_MinWidth  60
#define k_ContentView_MinHeight 60

#define k_ContentView_MaxWidth  1000
#define k_ContentView_MaxHeight 1000



#define k_Boarder_Width     2
#define k_Boarder_Color     [UIColor colorWithHexString:@"#ffffff"]

#define k_ControlBtn_Size   25
#define k_Padding           k_ControlBtn_Size/2.0f



@interface ZDStickerView ()


@property (nonatomic) BOOL preventsLayoutWhileResizing;

@property (nonatomic) float deltaAngle;
@property (nonatomic) CGPoint prevPoint;
@property (nonatomic) CGAffineTransform startTransform;

@property (nonatomic) CGPoint touchStart;


@end

@implementation ZDStickerView
@synthesize contentView, touchStart;

@synthesize prevPoint;
@synthesize deltaAngle, startTransform; //rotation
@synthesize resizingControl, deleteControl, editControl,borderView;
@synthesize preventsPositionOutsideSuperview;
@synthesize preventsResizing;
@synthesize preventsDeleting;
@synthesize minWidth, minHeight;


/**
 *  删除的按钮的事件
 *
 *  @param recognizer 删除按钮的tap手势
 */
-(void)singleTap:(UIPanGestureRecognizer *)recognizer
{
    
    if (NO == self.preventsDeleting) {
        UIView * close = (UIView *)[recognizer view];
        [close.superview removeFromSuperview];
    }
    
    if([_delegate respondsToSelector:@selector(stickerViewDidClose:)]) {
        [_delegate stickerViewDidClose:self];
    }
    
}

/**
 *  自动对齐到网格
 *
 *  @param recognizer 手势
 */

- (void)alignmentControlTapAction:(UITapGestureRecognizer *)recognizer
{
//    UIView *superView = self.superview;
    int a = D_Lattice_Width;
    //(int)(superView.bounds.size.width / 50);
    int b = D_Lattice_Height;
    //(int)(superView.bounds.size.height / 50);
    if (self.angleValue == 0) {
        CGRect oldRect = self.frame;
        oldRect.origin.x = (((int)self.frame.origin.x) / a) * a;
        oldRect.origin.y = (((int)self.frame.origin.y) / b) * b;
        self.frame = oldRect;
        
    }
}


/**
 *  整个view的点击事件  以便选中和加边框
 *
 *  @param recognizer
 */
- (void)allSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self showEditingHandles];
    if (_delegate && [_delegate respondsToSelector:@selector(allSingleTap:)]) {
        [_delegate allSingleTap:self];
    }
}

- (void)setSelect
{
    [self showEditingHandles];
}
- (void)setNormal
{
    [self hideEditingHandles];

}




/**
 *  双击事件
 *
 *  @param recognizer
 */
- (void)doubleTap:(UITapGestureRecognizer *)recognizer
{
    if (_delegate && [_delegate respondsToSelector:@selector(doubleTaped:)]) {
        [_delegate doubleTaped:self];
    }
}


/**
 *  拖动view的事件
 *
 *  @param recognizer
 */
-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    
    if (self.contentType == E_ContentViewType_TextView) {
        if ([recognizer state]== UIGestureRecognizerStateBegan)
        {
            prevPoint = [recognizer locationInView:self];
            [self setNeedsDisplay];
        }
        else if ([recognizer state] == UIGestureRecognizerStateChanged)
        {
            if (self.bounds.size.width < minWidth || self.bounds.size.width < minHeight)
            {
                if (!self.isNotExpend) {
                    
                    float fPadding = 16.0; // 8.0px x 2
                    CGSize constraint = CGSizeMake(minWidth-25 - fPadding, MAXFLOAT);
                    CGSize size = [self.cardTextView.textView.text sizeWithFont:self.cardTextView.textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                        self.bounds = CGRectMake(self.bounds.origin.x,
                                                 self.bounds.origin.y,
                                                 minWidth,
                                                 size.height + fPadding + 25 + 10);
                }
                prevPoint = [recognizer locationInView:self];
                //[self.superview convertPoint:[recognizer locationInView:self.superview] fromView:self];
                
            } else {
                CGPoint point = [recognizer locationInView:self];
                float wChange = 0.0, hChange = 0.0;
                
                wChange = (point.x - prevPoint.x);
                hChange = (point.y - prevPoint.y);
                
                if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                    prevPoint = [recognizer locationInView:self];
                    return;
                }
                
                if (YES == self.preventsLayoutWhileResizing) {
                    if (wChange < 0.0f && hChange < 0.0f) {
                        float change = MIN(wChange, hChange);
                        wChange = change;
                        hChange = change;
                    }
                    if (wChange < 0.0f) {
                        hChange = wChange;
                    } else if (hChange < 0.0f) {
                        wChange = hChange;
                    } else {
                        float change = MAX(wChange, hChange);
                        wChange = change;
                        hChange = change;
                    }
                }
                
                
                //            if(self.tempView){
                float fPadding = 16.0; // 8.0px x 2
                CGSize constraint = CGSizeMake(self.bounds.size.width + (wChange)-25 - fPadding, MAXFLOAT);
                
                CGSize size = [self.cardTextView.textView.text sizeWithFont:self.cardTextView.textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                if (!self.isNotExpend) {
                        self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,
                                                 self.bounds.size.width + (wChange),
                                                 size.height+fPadding+25+10);
                    
                }
                prevPoint = [recognizer locationInView:self];
            }
            
            /* Rotation */
            float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                              [recognizer locationInView:self.superview].x - self.center.x);
            float angleDiff = deltaAngle - ang;
            self.angleValue = -angleDiff;
            if (((int)(self.angleValue*180*M_1_PI))%90 ==0) {
                self.angleValue = ((int)(self.angleValue*180*M_1_PI))*M_PI/180;
//                [self.borderView setHidden:NO];
            }else{
//                [self.borderView setHidden:YES];
            }
            if (NO == preventsResizing) {
                self.transform = CGAffineTransformMakeRotation(self.angleValue);
            }
            [self setNeedsDisplay];
        }
        else if ([recognizer state] == UIGestureRecognizerStateEnded)
        {
            prevPoint  = [recognizer locationInView:self];
            [self setNeedsDisplay];
        }
    }else{
        
        
        if ([recognizer state]== UIGestureRecognizerStateBegan)
        {
            prevPoint = [recognizer locationInView:self];
            [self setNeedsDisplay];
        }
        else if ([recognizer state] == UIGestureRecognizerStateChanged)
        {
            if (self.bounds.size.width < minWidth || self.bounds.size.width < minHeight)
            {
                prevPoint = [recognizer locationInView:self];
                
            } else {
                CGPoint point = [recognizer locationInView:self];
                float wChange = 0.0, hChange = 0.0;
                
                wChange = (point.x - prevPoint.x);
                hChange = (point.y - prevPoint.y);
                
                
                
                if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                    prevPoint = [recognizer locationInView:self];
                    return;
                }
                
                if (YES == self.preventsLayoutWhileResizing) {
                    if (wChange < 0.0f && hChange < 0.0f) {
                        float change = MIN(wChange, hChange);
                        wChange = change;
                        hChange = change;
                    }
                    if (wChange < 0.0f) {
                        hChange = wChange;
                    } else if (hChange < 0.0f) {
                        wChange = hChange;
                    } else {
                        float change = MAX(wChange, hChange);
                        wChange = change;
                        hChange = change;
                    }
                }
                prevPoint = [recognizer locationInView:self];
            }
            /* Rotation */
            float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                              [recognizer locationInView:self.superview].x - self.center.x);
            float angleDiff = deltaAngle - ang;
            self.angleValue = -angleDiff;
            if (((int)(self.angleValue*180*M_1_PI))%90 ==0) {
                self.angleValue = ((int)(self.angleValue*180*M_1_PI))*M_PI/180;
                [self.borderView setHidden:NO];
            }else{
                [self.borderView setHidden:YES];
            }
            if (NO == preventsResizing) {
                self.transform = CGAffineTransformMakeRotation(self.angleValue);
            }
            
            [self setNeedsDisplay];
        }
        else if ([recognizer state] == UIGestureRecognizerStateEnded)
        {
            prevPoint = [recognizer locationInView:self];
            [self setNeedsDisplay];
        }
    }
}


- (void)editAction:(UITapGestureRecognizer*)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(stickerViewDidEdit:)]) {
        [_delegate stickerViewDidEdit:self];
    }
}


- (void)longPressed:(UILongPressGestureRecognizer *)sender
{

    if (_delegate && [_delegate respondsToSelector:@selector(longPressed:)]) {
        [_delegate longPressed:self];
    }
    
}


- (void)setupDefaultAttributes {
//    borderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, k_Padding, k_Padding)];
//    [borderView setHidden:YES];
//    borderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (kSPUserResizableViewDefaultMinWidth > self.bounds.size.width*0.5) {
        self.minWidth = kSPUserResizableViewDefaultMinWidth;
        self.minHeight = self.bounds.size.height * (kSPUserResizableViewDefaultMinWidth/self.bounds.size.width);
    } else {
        self.minWidth = self.bounds.size.width*0.5;
        self.minHeight = self.bounds.size.height*0.5;
    }
    self.preventsPositionOutsideSuperview = YES;
    self.preventsLayoutWhileResizing = YES;
    self.preventsResizing = NO;
    self.preventsDeleting = NO;
    
    
    borderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 23/2, 23/2)];
    borderView.backgroundColor = [UIColor clearColor];//colorWithRed:0.25 green:0.75 blue:0.36 alpha:1];
    borderView.layer.borderWidth = 2.0f;
    borderView.layer.borderColor = [UIColor whiteColor].CGColor;
    borderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:borderView];
    
    
    
    deleteControl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                 k_ControlBtn_Size, k_ControlBtn_Size)];
    deleteControl.backgroundColor = [UIColor clearColor];
    deleteControl.image = [ImageUtility imageWithStyleName:@"makecards_trashcan_icon"];
    deleteControl.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(singleTap:)];
    [deleteControl addGestureRecognizer:singleTap];
    [self addSubview:deleteControl];
    
    
    
    
    //单击的 Recognizer
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(allSingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleRecognizer];

    //双击的 Recognizer
    UITapGestureRecognizer *doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    //关键语句，给self.view添加一个手势监测；
    [self addGestureRecognizer:doubleRecognizer];
    /**
     *  加上失败的冲突解决
     */
    [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];
    
    
    
    resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-k_ControlBtn_Size,
                                                                   self.frame.size.height-k_ControlBtn_Size,
                                                                   k_ControlBtn_Size, k_ControlBtn_Size)];
    resizingControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    resizingControl.backgroundColor = [UIColor clearColor];
    resizingControl.userInteractionEnabled = YES;
    resizingControl.image = [ImageUtility imageWithStyleName:@"makecards_spin_icon"];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(resizeTranslate:)];
    [resizingControl addGestureRecognizer:panResizeGesture];
    [self addSubview:resizingControl];
    
    
    editControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-k_ControlBtn_Size,
                                                                0,
                                                                k_ControlBtn_Size, k_ControlBtn_Size)];
    editControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    editControl.backgroundColor = [UIColor clearColor];
    editControl.userInteractionEnabled = YES;
    editControl.hidden = YES;
    editControl.image = [ImageUtility imageWithStyleName:@"makecards_edit_icon"];
    UITapGestureRecognizer* editResizeGesture = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(editAction:)];
    [editControl addGestureRecognizer:editResizeGesture];
    [self addSubview:editControl];
    
    
    
    
    
    UILongPressGestureRecognizer *longRress  = [[UILongPressGestureRecognizer alloc]
                                                                                               
                                                                                               initWithTarget:self action:@selector(longPressed:)];
    [self addGestureRecognizer:longRress];

    
    
    deltaAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y,
                       self.frame.origin.x+self.frame.size.width - self.center.x);
    
    
    
    UIRotationGestureRecognizer *rotationG = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationImage:)];
    rotationG.delegate = self;
    UIPinchGestureRecognizer *pinchGestureRecongnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage:)];
    
    
    [pinchGestureRecongnizer requireGestureRecognizerToFail:panResizeGesture];
    pinchGestureRecongnizer.delegate = self;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:pinchGestureRecongnizer];
    [self addGestureRecognizer:rotationG];
    
    [self.deleteControl setHidden:YES];
    [self.resizingControl setHidden:YES];
}

- (void)removeMoveCaontrol
{
    

}


- (void)rotationImage:(UIRotationGestureRecognizer*)gesture {
//    [self.view bringSubviewToFront:gesture.view];

//    CGPoint location = [gesture locationInView:self.superview];
//    gesture.view.center = CGPointMake(location.x, location.y);
    if (_isNotRotationExpend) {
        return;
    }
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.lastRotation = 0;
        return;
    }
    CGAffineTransform currentTransform = self.transform;
    CGFloat rotation = 0.0 - (self.lastRotation - gesture.rotation);
    self.angleValue = rotation;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    self.transform = newTransform;
    self.lastRotation = gesture.rotation;
    
}
#pragma mark 
#pragma mark changeIamge
- (void)changeImage:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
    if (_isNotPinchExpend ) {
        return;
    }
    
    NSLog(@"----%f",pinchGestureRecognizer.scale);
//    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    if (self.bounds.size.width * pinchGestureRecognizer.scale < self.minWidth) {
        return;
    }
    if (self.bounds.size.height *pinchGestureRecognizer.scale < self.minHeight) {
        return;
    }
    
    if (self.bounds.size.width *pinchGestureRecognizer.scale > self.maxWidth) {
        return;
    }
    
    if (self.bounds.size.height *pinchGestureRecognizer.scale > self.maxHeight) {
        return;
    }
    self.bounds = CGRectMake(0, 0,self.bounds.size.width * pinchGestureRecognizer.scale,self.bounds.size.height *pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    if (self.contentType == E_ContentViewType_TextView) {
//        self.contentView.frame = CGRectInset(self.bounds, 12.5, 12.5);
//        self.cardTextView.frame =  self.contentView.bounds;
//        if (self.cardTextView.frame.size.height > 88) {
////            self.textView.maxHeight = self.textView.frame.size.height;
//        }else{
////            self.textView.maxHeight = 88;
//        }
////        [self.textView refreshHeight];
    [self.cardTextView.textView resetFontAndSize];

    }


}



- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setupDefaultAttributes];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupDefaultAttributes];
    }
    return self;
}

#pragma mark 
#pragma mark setContentViewMethod
- (void)setContentView:(UIView *)newContentView {
    
    self.minWidth = k_ContentView_MinWidth;
    self.minHeight = k_ContentView_MinHeight;
    
    self.maxWidth = k_ContentView_MaxWidth;
    self.maxHeight = k_ContentView_MaxHeight;
    
    
    if ([newContentView isKindOfClass:[UIImageView class]]) {
        self.contentType = E_ContentViewType_ImageView;
        self.imageView = (UIImageView *)newContentView;
    }else if([newContentView isKindOfClass:[CardTextView class]]){
        self.contentType = E_ContentViewType_TextView;
        self.cardTextView = (CardTextView *)newContentView;
        self.minWidth = k_TextView_MinWidth;
        self.minHeight = k_TextView_MinHeight;
        self.maxWidth = k_TextView_MaxWidth;
        self.maxHeight = k_TextView_MaxHeight;
    }else if([newContentView isKindOfClass:[PetView class]]){
        self.contentType = E_ContentViewType_Pet;
    }
    [self showEditingHandles];
    [contentView removeFromSuperview];
    contentView = newContentView;
    contentView.frame = CGRectInset(self.bounds, k_Padding, k_Padding);
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
    [self bringSubviewToFront:resizingControl];
    [self bringSubviewToFront:deleteControl];
    [self bringSubviewToFront:editControl];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];
    contentView.frame = CGRectInset(self.bounds, k_Padding, k_Padding);
    borderView.frame = CGRectInset(self.bounds, k_Padding, k_Padding);
    resizingControl.frame =CGRectMake(self.bounds.size.width-k_ControlBtn_Size,
                                      self.bounds.size.height-k_ControlBtn_Size,
                                      k_ControlBtn_Size,
                                      k_ControlBtn_Size);
    deleteControl.frame = CGRectMake(0, 0,
                                     k_ControlBtn_Size, k_ControlBtn_Size);
    editControl.frame = CGRectMake(self.frame.size.width-k_ControlBtn_Size,
                                                                       0,
                                                                       k_ControlBtn_Size, k_ControlBtn_Size);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    touchStart = [touch locationInView:self.superview];
    if([_delegate respondsToSelector:@selector(stickerViewDidBeginEditing:)]) {
        [_delegate stickerViewDidBeginEditing:self];
    }
    [self showEditingHandles];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidEndEditing:)]) {
        [_delegate stickerViewDidEndEditing:self];
    }
    [self hideEditingHandles];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidCancelEditing:)]) {
        [_delegate stickerViewDidCancelEditing:self];
    }
}

- (void)translateUsingTouchLocation:(CGPoint)touchPoint {
    if (_isNotMoveEnable) {
        return;
    }
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                    self.center.y + touchPoint.y - touchStart.y);
    if (self.preventsPositionOutsideSuperview) {
        // Ensure the translation won't cause the view to move offscreen.
        CGFloat midPointX = CGRectGetMidX(self.bounds);
        if (newCenter.x> self.superview.bounds.size.width - midPointX+25/2.0) {
            newCenter.x = self.superview.bounds.size.width - midPointX+24/2.0;
        }
        if (newCenter.x < midPointX -25/2.0) {
            newCenter.x = midPointX-24/2.0;
        }
        CGFloat midPointY = CGRectGetMidY(self.bounds);
        if (newCenter.y > self.superview.bounds.size.height - midPointY+25/2.0) {
            newCenter.y = self.superview.bounds.size.height - midPointY+24/2.0;
        }
        if (newCenter.y < midPointY-25/2.0) {
            newCenter.y = midPointY-24/2.0;
        }
    }
    self.center = newCenter;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    [self translateUsingTouchLocation:touch];
    touchStart = touch;
}


- (void)hideEditingHandles
{

    resizingControl.hidden = YES;
    deleteControl.hidden = YES;
    editControl.hidden = YES;
    if (_isNotEditable) {
        return;
    }

}

- (void)showEditingHandles
{
    borderView.hidden = NO;
    if (self.isShowResizingControl) {
        resizingControl.hidden = NO;
    }
    if (self.isShowDeleteControl) {
        deleteControl.hidden = NO;
    }
    if (self.isShowEditControl) {
        editControl.hidden = NO;
    }
    
    if (_isNotEditable) {
        return;
    }
}


- (void)showBoarderView
{
    resizingControl.hidden = NO;
    deleteControl.hidden = NO;
    editControl.hidden = NO;
    borderView.hidden = NO;
    

}
- (void)hiddenBoarderView
{

    resizingControl.hidden = YES;
    deleteControl.hidden = YES;
    borderView.hidden = YES;
    editControl.hidden = YES;
}




@end
