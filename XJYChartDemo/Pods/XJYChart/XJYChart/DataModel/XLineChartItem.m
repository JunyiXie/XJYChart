//
//  XLineChartItem.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XLineChartItem.h"

@implementation XLineChartItem

/**
 @param numberArray data number in a line
 @param color the line color
 @return XLineChartItem instance
 */
- (instancetype)initWithDataNumberArray:(NSMutableArray*)numberArray
                                  color:(UIColor*)color {
  if (self = [super init]) {
    self.numberArray = numberArray;
    self.color = color;
  }
  return self;
}
@end
