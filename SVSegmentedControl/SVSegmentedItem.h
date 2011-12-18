//
//  SVSegmentedItem.h
//  SVSegmentedControl
//
//  Created by Yoichi Tagaya on 11/12/18.
//  Copyright (c) 2011 el eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVSegmentedItem : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *image;

- (id)initWithTitle:(NSString *)titleText;
- (id)initWithImage:(UIImage *)iconImage;
- (CGSize)sizeWithFont:(UIFont *)font;
- (void)drawAtPoint:(CGPoint)point withWidth:(CGFloat)width font:(UIFont *)font;

@end
