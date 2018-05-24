//
//  XAlignLabel.m
//  XJYChart
//
//  Created by 谢俊逸 on 24/5/2018.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

#import "XAlignLabel.h"


@implementation XAlignLabel

@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.verticalAlignment = XVerticalAlignmentMiddle;
  }
  return self;
}

- (void)setVerticalAlignment:(XVerticalAlignment)verticalAlignment {
  verticalAlignment_ = verticalAlignment;
  [self setNeedsLayout];
}


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
  CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
  switch (self.verticalAlignment) {
    case XVerticalAlignmentTop:
      textRect.origin.y = bounds.origin.y;
      break;
    case XVerticalAlignmentBottom:
      textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
      break;
    case XVerticalAlignmentMiddle:
      // Fall through.
    default:
      textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
  }
  return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
  CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
  [super drawTextInRect:actualRect];
}

@end
