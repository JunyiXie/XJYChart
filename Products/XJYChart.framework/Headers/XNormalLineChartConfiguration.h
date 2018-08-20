//
//  XNormalLineChartConfiguration.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XLineChartConfiguration.h"

@interface XNormalLineChartConfiguration : XLineChartConfiguration

/// defalut is NO
@property(nonatomic, assign) BOOL isShowCoordinate;

/// if isShowShadow == YES
///  line path animation will Disable
@property(nonatomic, assign) BOOL isShowShadow;

@property(nonatomic, assign) BOOL isShowPoint;
@end
