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
/// default is @[(__bridge id)[UIColor steelBlueColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
@property(nonatomic, strong) NSArray* gradientColors;

/// defalut is YES
@property(nonatomic, assign) BOOL isShowPoint;

/// defalut is 0.5
@property(nonatomic, assign) CGFloat areaLineAlpha;
@property(nonatomic, assign) BOOL isEnableNumberLabel;
@end
