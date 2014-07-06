//
//  SVSegmentedItem.m
//  SVSegmentedControl
//
//  Created by Yoichi Tagaya on 11/12/18.
//  Copyright (c) 2011 el eleven. All rights reserved.
//

#import "SVSegmentedItem.h"

@implementation SVSegmentedItem

@synthesize title, image, highlightedImage;

- (id)initWithTitle:(NSString *)titleText {
    self = [super init];
    if (self) {
        self.title = titleText;
    }
    return self;
}

- (id)initWithImage:(UIImage *)iconImage highlightedImage:(UIImage *)highlightedIconImage {
    self = [super init];
    if (self) {
        self.image = iconImage;
        self.highlightedImage = highlightedIconImage;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    self.image = nil;
    [super dealloc];
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    NSAssert(nil == self.title || nil == self.image, @"Current version supports either only title or image.");

    if (nil != self.title) {
        return [self.title sizeWithAttributes:@{ NSFontAttributeName:font }];
    }
    else {
        return self.image.size;
    }
}

- (void)drawAtPoint:(CGPoint)point withWidth:(CGFloat)width font:(UIFont *)font {
    NSAssert(nil == self.title || nil == self.image, @"Current version supports either only title or image.");

    if (nil != self.title) {
        CGRect labelRect = CGRectMake(point.x, point.y, width, font.pointSize);
        NSMutableParagraphStyle *style = [[[NSMutableParagraphStyle alloc] init] autorelease];
        style.lineBreakMode = NSLineBreakByClipping;
        style.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:style };
        [self.title drawInRect:labelRect withAttributes:attributes];
    }
    else {
        CGPoint imageOrigin = CGPointMake(point.x + (width - self.image.size.width) / 2.0f, point.y);
        [self.image drawAtPoint:imageOrigin];
    }
}

@end
