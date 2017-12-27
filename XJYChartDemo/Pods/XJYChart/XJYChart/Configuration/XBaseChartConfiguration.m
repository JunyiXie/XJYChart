//
//  XBaseChartConfiguration.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XBaseChartConfiguration.h"
#import "XColor.h"

@implementation XBaseChartConfiguration

- (UIColor*)chartBackgroundColor {
  if (_chartBackgroundColor == nil) {
    _chartBackgroundColor = XJYWhite;
  }
  return _chartBackgroundColor;
}

@end
