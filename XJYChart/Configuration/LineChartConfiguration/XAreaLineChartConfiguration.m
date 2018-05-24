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

- (instancetype)init {
  if (self = [super init]) {
    self.isShowPoint = YES;
    self.areaLineAlpha = 0.5;
    self.lineMode = CurveLine;
    self.gradientColors = @[
                            (__bridge id)[UIColor steelBlueColor].CGColor,
                            (__bridge id)[UIColor whiteColor].CGColor
                            ];
    self.auxiliaryDashLineColor = [UIColor black50PercentColor];
    self.isEnableNumberLabel = NO;
  }
  return self;
}

@end
