//
//  SVSegmentedItem.m
//  SVSegmentedControl
//
//  Created by Yoichi Tagaya on 11/12/18.
//  Copyright (c) 2011 el eleven. All rights reserved.
//

#import "SVSegmentedItem.h"

@implementation SVSegmentedItem

@synthesize title;

- (id)initWithTitle:(NSString *)titleText {
    self = [super init];
    if (self) {
        self.title = titleText;
    }
    return self;
}

- (void)dealloc {
    self.title = nil;
    [super dealloc];
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self.title sizeWithFont:font];
}

- (void)drawInRect:(CGRect)rect
          withFont:(UIFont *)font
     lineBreakMode:(UILineBreakMode)lineBreakMode
         alignment:(UITextAlignment)alignment {
    [self.title drawInRect:rect withFont:font lineBreakMode:lineBreakMode alignment:alignment];
}

@end
