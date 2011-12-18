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

- (id)initWithTitle:(NSString *)titleText;
- (CGSize)sizeWithFont:(UIFont *)font;
- (void)drawInRect:(CGRect)rect
          withFont:(UIFont *)font
     lineBreakMode:(UILineBreakMode)lineBreakMode
         alignment:(UITextAlignment)alignment;

@end
