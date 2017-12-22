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

@end
