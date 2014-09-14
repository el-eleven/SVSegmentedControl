//
// SVSegmentedThumb.m
// SVSegmentedControl
//
// Created by Sam Vermette on 25.05.11.
// Copyright 2011 Sam Vermette. All rights reserved.
//
// https://github.com/samvermette/SVSegmentedControl
//

#import "SVSegmentedThumb.h"
#import <QuartzCore/QuartzCore.h>
#import "SVSegmentedControl.h"
#import "SVSegmentedItem.h"

@interface SVSegmentedThumb ()

@property (nonatomic, readwrite) BOOL selected;
@property (nonatomic, assign) SVSegmentedControl *segmentedControl;
@property (nonatomic, assign) UIFont *font;

@property (nonatomic, assign) SVSegmentedItem *controlItem;
@property (nonatomic, readwrite) CGFloat controlAlpha;
@property (nonatomic, assign) SVSegmentedItem *secondControlItem;
@property (nonatomic, readwrite) CGFloat secondControlAlpha;

@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, readonly) UILabel *secondLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIImageView *secondImageView;

- (void)activate;
- (void)deactivate;

@end


@implementation SVSegmentedThumb

@synthesize segmentedControl, backgroundImage, highlightedBackgroundImage, castsShadow, font, tintColor, textColor, shadowColor, shadowOffset, selected;
@synthesize controlItem, controlAlpha, secondControlItem, secondControlAlpha;
@synthesize label, secondLabel, imageView, secondImageView;

- (void)dealloc {
    
    self.backgroundImage = nil;
    self.highlightedBackgroundImage = nil;
    
    [label release];
    [secondLabel release];
    [imageView release];
    [secondImageView release];
	
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
	
    if (self) {
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		self.layer.shadowOffset = CGSizeMake(0, 0);
		self.layer.shadowRadius = 1;
		self.layer.shadowColor = [UIColor blackColor].CGColor;
		self.layer.shadowOpacity = 1;
		self.layer.shouldRasterize = YES;

		self.textColor = [UIColor whiteColor];
		self.shadowColor = [UIColor blackColor];
		self.shadowOffset = CGSizeMake(0, -1);
		self.tintColor = [UIColor grayColor];
    }
	
    return self;
}

- (SVSegmentedItem *)controlItem
{
    SVSegmentedItem *item = nil;
    if (nil != label.text) {
        item = [[[SVSegmentedItem alloc] initWithTitle:label.text] autorelease];
    }
    else if (nil != imageView.image) {
        item = [[[SVSegmentedItem alloc] initWithImage:imageView.image highlightedImage:imageView.highlightedImage] autorelease];
    }
    return item;
}

- (void)setControlItem:(SVSegmentedItem *)item
{
    NSAssert(nil == item.title || nil == item.image, @"Current version supports either only title or image.");
    label.text = item.title;
    imageView.image = item.image;
    imageView.highlightedImage = item.highlightedImage;
}

- (CGFloat)controlAlpha {
    return label.alpha;
}

- (void)setControlAlpha:(CGFloat)alpha {
    label.alpha = alpha;
    imageView.alpha = alpha;
}

- (SVSegmentedItem *)secondControlItem
{
    SVSegmentedItem *item = nil; 
    if (nil != secondLabel.text) {
        item = [[[SVSegmentedItem alloc] initWithTitle:secondLabel.text] autorelease];
    }
    else if (nil != secondImageView.image) {
        item = [[[SVSegmentedItem alloc] initWithImage:secondImageView.image highlightedImage:secondImageView.highlightedImage] autorelease];
    }
    return item;
}

- (void)setSecondControlItem:(SVSegmentedItem *)item
{
    NSAssert(nil == item.title || nil == item.image, @"Current version supports either only title or image.");
    secondLabel.text = item.title;
    secondImageView.image = item.image;
    secondImageView.highlightedImage = item.highlightedImage;
}

- (CGFloat)secondControlAlpha {
    return secondLabel.alpha;
}

- (void)setSecondControlAlpha:(CGFloat)alpha {
    secondLabel.alpha = alpha;
    secondImageView.alpha = alpha;
}

- (UILabel*)label {
    
    if(label == nil) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
		label.textAlignment = NSTextAlignmentCenter;
		label.font = self.font;
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
    }
    
    return label;
}

- (UILabel*)secondLabel {
    
    if(secondLabel == nil) {
		secondLabel = [[UILabel alloc] initWithFrame:self.bounds];
		secondLabel.textAlignment = NSTextAlignmentCenter;
		secondLabel.font = self.font;
		secondLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:secondLabel];
    }
    
    return secondLabel;
}

- (UIFont *)font {
    return self.label.font;
}

- (UIImageView *)imageView
{
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.opaque = NO;
        imageView.highlighted = YES;
        [self addSubview:imageView];
    }
    
    return imageView;
}

- (UIImageView *)secondImageView
{
    if (secondImageView == nil) {
        secondImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        secondImageView.contentMode = UIViewContentModeCenter;
        secondImageView.backgroundColor = [UIColor clearColor];
        secondImageView.opaque = NO;
        secondImageView.highlighted = YES;
        [self addSubview:secondImageView];
    }
    
    return secondImageView;
}

- (void)drawRect:(CGRect)rect {
        
    if(self.backgroundImage && !self.selected)
        [self.backgroundImage drawInRect:rect];
    
    else if(self.highlightedBackgroundImage && self.selected)
        [self.highlightedBackgroundImage drawInRect:rect];
    
    else {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        // STROKE GRADIENT
        
        CGPathRef strokeRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2].CGPath;
        CGContextAddPath(context, strokeRect);
        CGContextClip(context);
        
        CGContextSaveGState(context);
        
        CGFloat strokeComponents[4] = {    
            0.55, 1,
            0.40, 1
        };
        
        if(self.selected) {
            strokeComponents[0]-=0.1;
            strokeComponents[2]-=0.1;
        }
        
        CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);	
        CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0,0), CGPointMake(0,CGRectGetHeight(rect)), 0);
        CGGradientRelease(strokeGradient);
        
        
        // FILL GRADIENT
        
        CGPathRef fillRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:1].CGPath;
        CGContextAddPath(context, fillRect);
        CGContextClip(context);
        
        CGFloat fillComponents[4] = {    
            0.5, 1,
            0.35, 1
        };
        
        if(self.selected) {
            fillComponents[0]-=0.1;
            fillComponents[2]-=0.1;
        }
        
        CGGradientRef fillGradient = CGGradientCreateWithColorComponents(colorSpace, fillComponents, NULL, 2);	
        CGContextDrawLinearGradient(context, fillGradient, CGPointMake(0,0), CGPointMake(0,CGRectGetHeight(rect)), 0);
        CGGradientRelease(fillGradient);
        
        CGColorSpaceRelease(colorSpace);
        
        CGContextRestoreGState(context);
        [self.tintColor set];
        UIRectFillUsingBlendMode(rect, kCGBlendModeOverlay);
    }
}


#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)newImage {
    
    if(backgroundImage)
        [backgroundImage release], backgroundImage = nil;
    
    if(newImage) {
        backgroundImage = [newImage retain];
        self.castsShadow = NO;
    } else {
        self.castsShadow = YES;
    }
}

- (void)setTintColor:(UIColor *)newColor {
    
    if(tintColor)
        [tintColor release], tintColor = nil;
	
	if(newColor)
		tintColor = [newColor retain];

	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)newFont {
    self.label.font = self.secondLabel.font = newFont;
}

- (void)setTextColor:(UIColor *)newColor {
	self.label.textColor = self.secondLabel.textColor = newColor;
}

- (void)setShadowColor:(UIColor *)newColor {
	self.label.shadowColor = self.secondLabel.shadowColor = newColor;
}

- (void)setShadowOffset:(CGSize)newOffset {
	self.label.shadowOffset = self.secondLabel.shadowOffset = newOffset;
}


#pragma mark -

- (void)setFrame:(CGRect)newFrame {
	[super setFrame:newFrame];
        
    CGFloat posY = ceil((self.segmentedControl.height-self.font.pointSize+self.font.descender)/2)+self.segmentedControl.titleEdgeInsets.top-self.segmentedControl.titleEdgeInsets.bottom-self.segmentedControl.thumbEdgeInset.top+2;
	int pointSize = self.font.pointSize;
	
	if(pointSize%2 != 0)
		posY--;
    
	self.label.frame = self.secondLabel.frame = CGRectMake(0, posY, newFrame.size.width, self.font.pointSize);
    self.imageView.frame = self.bounds;
}


- (void)setCastsShadow:(BOOL)b {
    self.layer.shadowOpacity = b ? 1 : 0;
}


- (void)setSelected:(BOOL)s {
	
	selected = s;
	
	if(selected && !self.segmentedControl.crossFadeLabelsOnDrag && !self.highlightedBackgroundImage)
		self.alpha = 0.8;
	else
		self.alpha = 1;
	
	[self setNeedsDisplay];
}

- (void)activate {
	[self setSelected:NO];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag) {
        self.controlAlpha = 1;
    }
}

- (void)deactivate {
	[self setSelected:YES];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag) {
        self.controlAlpha = 0;
    }
}


@end
