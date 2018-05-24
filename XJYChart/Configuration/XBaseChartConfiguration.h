//
//  XBaseChartConfiguration.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/3.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBaseChartConfiguration : NSObject

/// defalut is white
@property(nonatomic, strong) UIColor* chartBackgroundColor;
@property(nonatomic, assign) NSUInteger ordinateDenominator;
@property(nonatomic, assign) BOOL isScrollable;
@end

