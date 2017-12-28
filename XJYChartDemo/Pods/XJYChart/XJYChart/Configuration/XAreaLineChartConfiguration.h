//
//  XAreaLineChartConfiguration.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XLineChartConfiguration.h"
@interface XAreaLineChartConfiguration : XLineChartConfiguration

///  CGColorRef Array
@property(nonatomic, strong) NSArray* gradientColors;
@property(nonatomic, assign) BOOL isShowPoint;

@end
