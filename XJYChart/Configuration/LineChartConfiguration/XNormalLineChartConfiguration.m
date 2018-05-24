//
//  XNormalLineChartConfiguration.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XNormalLineChartConfiguration.h"

@implementation XNormalLineChartConfiguration

- (instancetype)init {
  if (self = [super init]) {
    self.isShowShadow = YES;
    self.isShowCoordinate = NO;
    self.isShowPoint = YES;
  }
  return self;
}

@end
