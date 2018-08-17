//
//  XLineChartConfiguration.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XBaseChartConfiguration.h"
#import "XEnumHeader.h"

@interface XLineChartConfiguration : XBaseChartConfiguration

/**
 Line Mode
 - Straight
 - CurveLine

 Default is Straight

 */
@property(nonatomic, assign) XLineMode lineMode;

/// defalut is [UIColor black75PercentColor]
@property(nonatomic, strong) UIColor* auxiliaryDashLineColor;

/// defalut is YES
@property(nonatomic, assign) BOOL isShowAuxiliaryDashLine;

/// if enable number
/// ,touch height failure
@property(nonatomic, assign) BOOL isEnableNumberLabel;

@property(nonatomic, strong) UIColor *numberLabelColor;

@end
