//
//  KZColorWheelView.m
//
//  Created by Alex Restrepo on 5/11/11.
//  Copyright 2011 KZLabs http://kzlabs.me
//  All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KZColorPicker.h"
#import "KZColorPickerHSWheel.h"
#import "KZColorPickerBrightnessSlider.h"
#import "KZColorPickerAlphaSlider.h"
#import "HSV.h"
#import "UIColor-Expanded.h"
#import "KZColorPickerSwatchView.h"
#import "KZColorCompareView.h"
#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

@interface KZColorPicker()
@property (nonatomic, retain) KZColorPickerHSWheel *colorWheel;
@property (nonatomic, retain) KZColorPickerBrightnessSlider *brightnessSlider;
@property (nonatomic, retain) KZColorPickerAlphaSlider *alphaSlider;
@property (nonatomic, retain) KZColorCompareView *currentColorView;
@property (nonatomic, retain) NSMutableArray *swatches;
- (void) fixLocations;
@end


@implementation KZColorPicker
@synthesize colorWheel;
@synthesize brightnessSlider;
@synthesize selectedColor;
@synthesize alphaSlider;
@synthesize swatches;
@synthesize oldColor = _oldColor;
@synthesize currentColorView = _currentColorView;

- (void) setup
{
	// set the frame to a fixed 300 x 300
	//self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 300, 280);
	self.backgroundColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1];
    //= IS_IPAD ? [UIColor clearColor] : [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:1.000];
    
    
	// HS wheel
	KZColorPickerHSWheel *wheel = [[KZColorPickerHSWheel alloc] initAtOrigin:CGPointMake(10, 10)];
	[wheel addTarget:self action:@selector(colorWheelColorChanged:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:wheel];
	self.colorWheel = wheel;
	[wheel release];
	
	// brightness slider
	KZColorPickerBrightnessSlider *slider = [[KZColorPickerBrightnessSlider alloc] initWithFrame:CGRectMake(120,
																											146,
																											100,
																											30)];
	[slider addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:slider];
	self.brightnessSlider = slider;
	[slider release];
    
    // alpha slider
    KZColorPickerAlphaSlider *alpha = [[KZColorPickerAlphaSlider alloc] initWithFrame:CGRectMake(120,
                                                                                                 176,
                                                                                                 200,
                                                                                                 30)];
    [alpha addTarget:self action:@selector(alphaChanged:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:alpha];
    self.alphaSlider = alpha;
	[alpha release];
    
    // current color indicator hier.
    KZColorCompareView *colorView = [[KZColorCompareView alloc] initWithFrame:CGRectMake(10, 166, 25, 25)];
    [colorView addTarget:self action:@selector(oldColor:) forControlEvents:UIControlEventTouchUpInside];
    colorView.oldColor = self.oldColor;
    self.currentColorView = colorView;    
    [self addSubview:colorView];
    [colorView release];
    
	// swatches.	    
    NSMutableArray *colors = [NSMutableArray array];    
//    for(float angle = 0; angle < 360; angle += 60)
//    {
//        CGFloat h = 0;
//        h = (M_PI / 180.0 * angle) / (2 * M_PI);            
//        [colors addObject:[UIColor colorWithHue:h  saturation:1.0 brightness:1.0 alpha:1.0]];                        
//    }
//    
//    for (int i = 0; i < 6; i++)
//    {            
//        [colors addObject:[UIColor colorWithRed:i / 5.0 green:i / 5.0 blue:i / 5.0 alpha:1.0]];
//    }
    
    [colors addObject:[UIColor colorWithRed:0.15 green:0.74 blue:0.65 alpha:1]];
    [colors addObject:[UIColor colorWithRed:0.34 green:0.76 blue:0.46 alpha:1]];
    [colors addObject:[UIColor colorWithRed:0.95 green:0.47 blue:0.46 alpha:1]];
    [colors addObject:[UIColor colorWithRed:0.94 green:0.75 blue:0.37 alpha:1]];
    [colors addObject:[UIColor colorWithRed:0.05 green:0.57 blue:0.49 alpha:1]];
    [colors addObject:[UIColor colorWithRed:0.28 green:0.71 blue:0.73 alpha:1]];
    
    KZColorPickerSwatchView *swatch = nil;	
    self.swatches = [NSMutableArray array];
    for (UIColor *color in colors)
    {
        swatch = [[KZColorPickerSwatchView alloc] initWithFrame:CGRectZero];
        swatch.color = color;
        [swatch addTarget:self action:@selector(swatchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:swatch];
        [swatches addObject:swatch];
        [swatch release];
    }	
	
	self.selectedColor = [UIColor whiteColor];//[UIColor colorWithRed:0.349 green:0.613 blue:0.378 alpha:1.000];
    [self fixLocations];
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) 
	{
        // Initialization code
		[self setup];
    }
    return self;
}

- (void)dealloc 
{
	[selectedColor release];
	[colorWheel release];
	[brightnessSlider release];
    [alphaSlider release];
    [currentColorIndicator release];
    [swatches release];
    [_currentColorView release];
    [_oldColor release];
    [super dealloc];
}

- (void) awakeFromNib
{
	[self setup];
}

- (void) oldColor:(KZColorCompareView *)view
{
    [self setSelectedColor:view.oldColor animated:YES];
}

RGBType rgbWithUIColor(UIColor *color)
{
	const CGFloat *components = CGColorGetComponents(color.CGColor);
	
	CGFloat r,g,b;
	
	switch (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor))) 
	{
		case kCGColorSpaceModelMonochrome:
			r = g = b = components[0];
			break;
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			break;
		default:	// We don't know how to handle this model
			return RGBTypeMake(0, 0, 0);
	}
	
	return RGBTypeMake(r, g, b);
}

- (void) setSelectedColor:(UIColor *)color animated:(BOOL)animated
{
	if (animated) 
	{
		[UIView beginAnimations:nil context:nil];
		self.selectedColor = color;
		[UIView commitAnimations];
	}
	else 
	{
		self.selectedColor = color;
	}
}
- (void) setOldColor:(UIColor *)col
{
    [col retain];
    [_oldColor release];
    
    _oldColor = col;
    self.currentColorView.oldColor = _oldColor;
}

- (void) setSelectedColor:(UIColor *)c
{
	[c retain];
	[selectedColor release];
	selectedColor = c;
	
	RGBType rgb = rgbWithUIColor(c);
	HSVType hsv = RGB_to_HSV(rgb);
	
	self.colorWheel.currentHSV = hsv;
	self.brightnessSlider.value = hsv.v;
    self.alphaSlider.value = [c alpha];
	
    UIColor *keyColor = [UIColor colorWithHue:hsv.h 
                                   saturation:hsv.s
                                   brightness:1.0
                                        alpha:1.0];
	[self.brightnessSlider setKeyColor:keyColor];
    
    keyColor = [UIColor colorWithHue:hsv.h 
                          saturation:hsv.s
                          brightness:hsv.v
                               alpha:1.0];
    [self.alphaSlider setKeyColor:keyColor];
	
	self.currentColorView.currentColor = c;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) colorWheelColorChanged:(KZColorPickerHSWheel *)wheel
{
	HSVType hsv = wheel.currentHSV;
	self.selectedColor = [UIColor colorWithHue:hsv.h
									saturation:hsv.s
									brightness:self.brightnessSlider.value
										 alpha:self.alphaSlider.value];		
	
[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) brightnessChanged:(KZColorPickerBrightnessSlider *)slider
{
	HSVType hsv = self.colorWheel.currentHSV;
    NSLog(@"-----%f",self.brightnessSlider.value);
	if (self.brightnessSlider.value != 0) {
        self.selectedColor = [UIColor colorWithHue:hsv.h
                                        saturation:hsv.s
                                        brightness:self.brightnessSlider.value
                                             alpha:self.alphaSlider.value];
    }

	
	//[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) alphaChanged:(KZColorPickerAlphaSlider *)slider
{
	HSVType hsv = self.colorWheel.currentHSV;
	
	self.selectedColor = [UIColor colorWithHue:hsv.h
									saturation:hsv.s
									brightness:self.brightnessSlider.value
										 alpha:self.alphaSlider.value];
	
	//[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) swatchAction:(KZColorPickerSwatchView *)sender
{
	[self setSelectedColor:sender.color animated:YES];
	//[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) fixLocations
{
    //horizontal
//    if(self.bounds.size.width < self.bounds.size.height)
//    {
        CGFloat totalWidth = 150;
    //self.bounds.size.width - 40.0;
        CGFloat swatchCellWidth = totalWidth / 3.0;
        
        int sx = 168;
        int sy = 24;
        for (int i = 0; i < self.swatches.count; i++)
        {
            KZColorPickerSwatchView *swatch =  (KZColorPickerSwatchView *)[self.swatches objectAtIndex:i];
            swatch.frame = CGRectMake(sx+swatchCellWidth*(i%3),
                                      sy+41*(i/3), 31.0, 31.0);
//            sx += swatchCellWidth;
        }
        
        self.brightnessSlider.frame = CGRectMake(120,
                                                 146,
                                                 200,
                                                 30);
        
        self.alphaSlider.frame = CGRectMake(120,
                                            176,
                                            200,
                                            30);
//    }
//    else
//    {
//        CGFloat totalWidth = 160.0;
//        CGFloat swatchCellWidth = totalWidth / 3.0;
//        
//        int sx = 302;
//        int sy = 140;
//        int index = 0;
//        for (KZColorPickerSwatchView *swatch in self.swatches)
//        {
//            swatch.frame = CGRectMake(sx + swatchCellWidth * 0.5 - 18.0,
//                                      sy, 36.0, 36.0);
//            sx += swatchCellWidth;
//            if(++index % 3 == 0)
//            {
//                sx = 300;
//                sy += swatchCellWidth;
//            }
//        }
//        
//        self.brightnessSlider.frame = CGRectMake(300, 
//                                                 self.bounds.size.height * 0.5 - 38 - 50,
//                                                 165,
//                                                 38);
//        
//        self.alphaSlider.frame = CGRectMake(300, 
//                                            self.bounds.size.height * 0.5 + 5 - 50,
//                                            165,
//                                            38);
//    }
    /*
    CGFloat totalHeight = self.bounds.size.height - 10.0;
    int voffset = 0, hoffset = 0;
    
    if(self.bounds.size.width > self.bounds.size.height)
    {
        //self.picker.center = CGPointMake(picker.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        //totalWidth -= picker.bounds.size.width;
        //hoffset = picker.bounds.size.width;
    }
    else // vert
    {
        //self.picker.center = CGPointMake(self.bounds.size.width * 0.5, picker.bounds.size.height * 0.5);
        //totalHeight -= picker.bounds.size.height;
        //voffset = picker.bounds.size.height;
    }
    
    int columns = 6;    
    int rows = [self.swatches count] / columns;         
    
    CGFloat swatchWidth = totalWidth / (float)columns;
    CGFloat swatchHeight = totalHeight / (float)rows;
    
    int sx = 5 + hoffset;
    int sy = 5 + voffset;
    
    int index = 0;
    for (UIButton *swatch in self.swatches)
    {
        swatch.frame = CGRectMake(sx + 5.0, sy + 5.0, swatchWidth - 10.0, swatchHeight - 10.0);
        sx += swatchWidth;
        if(++index % columns == 0)
        {
            sx = 5 + hoffset;
            sy += swatchHeight;
        }
    }
     */
}

- (void) layoutSubviews
{
    [UIView beginAnimations:nil context:nil];
    
    [self fixLocations];
    
    [UIView commitAnimations];
}

@end
