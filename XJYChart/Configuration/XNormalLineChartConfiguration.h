//
//  XNormalLineChartConfiguration.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XLineChartConfiguration.h"

@interface XNormalLineChartConfiguration : XLineChartConfiguration

@property(nonatomic, assign) BOOL isShowCoordinate;
/// if isShowShadow == YES
/// Disable line path animation
@property(nonatomic, assign) BOOL isShowShadow;
@end
