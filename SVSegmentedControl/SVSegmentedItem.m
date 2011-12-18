//
//  SVSegmentedItem.m
//  SVSegmentedControl
//
//  Created by Yoichi Tagaya on 11/12/18.
//  Copyright (c) 2011 el eleven. All rights reserved.
//

#import "SVSegmentedItem.h"

@implementation SVSegmentedItem

@synthesize title, image;

- (id)initWithTitle:(NSString *)titleText {
    self = [super init];
    if (self) {
        self.title = titleText;
    }
    return self;
}

- (id)initWithImage:(UIImage *)iconImage {
    self = [super init];
    if (self) {
        self.image = iconImage;
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
        return [self.title sizeWithFont:font];
    }
    else {
        return self.image.size;
    }
}

- (void)drawAtPoint:(CGPoint)point withWidth:(CGFloat)width font:(UIFont *)font {
    NSAssert(nil == self.title || nil == self.image, @"Current version supports either only title or image.");

    if (nil != self.title) {
        CGRect labelRect = CGRectMake(point.x, point.y, width, font.pointSize);
        [self.title drawInRect:labelRect withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    }
    else {
        CGPoint imageOrigin = CGPointMake(point.x + (width - self.image.size.width) / 2.0f, point.y);
        [self.image drawAtPoint:imageOrigin];
    }
}

@end
