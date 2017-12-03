//
//  XAreaLineChartConfiguration.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XAreaLineChartConfiguration.h"
#import "XColor.h"

@implementation XAreaLineChartConfiguration

/**
 @property(nonatomic, strong) NSArray *gradientColors;
 @property(nonatomic, strong) UIColor *pointColor;
 @property(nonatomic, assign) CGFloat lineAreaOpacity;
 **/

- (UIColor*)pointColor {
  if (_pointColor == nil) {
    _pointColor = [UIColor turquoiseColor];
  }
  return _pointColor;
}

- (NSArray*)gradientColors {
  if (_gradientColors == nil) {
    _gradientColors = @[
      (__bridge id)[UIColor redColor].CGColor,
      (__bridge id)[UIColor whiteColor].CGColor
    ];
  }
  return _gradientColors;
}

- (CGFloat)lineAreaOpacity {
  if (_lineAreaOpacity == 0) {
    _lineAreaOpacity = 0.5;
  }
  return _lineAreaOpacity;
}

@end
