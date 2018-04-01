//
//  XLineChartConfiguration.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XLineChartConfiguration.h"
#import "XColor.h"

@implementation XLineChartConfiguration

- (instancetype)init {
  if (self = [super init]) {
    self.lineMode = Straight;
    self.isShowAuxiliaryDashLine = YES;
    self.auxiliaryDashLineColor = [UIColor black75PercentColor];
    self.numberLabelColor = [UIColor black75PercentColor];
    self.isEnableNumberLabel = NO;
  }
  return self;
}

@end
