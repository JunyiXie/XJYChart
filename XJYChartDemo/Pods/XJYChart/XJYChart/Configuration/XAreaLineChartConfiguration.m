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

- (NSArray*)gradientColors {
  if (_gradientColors == nil) {
    _gradientColors = @[
      (__bridge id)[UIColor steelBlueColor].CGColor,
      (__bridge id)[UIColor whiteColor].CGColor
    ];
  }
  return _gradientColors;
}

@end
