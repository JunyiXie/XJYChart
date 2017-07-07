//
//  XXLineChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLineChartView.h"
#import "XEnumHeader.h"
#import "XLineChartItem.h"

@interface XLineChart : UIView


/**
 Random ：RandomColor
 Custom :  need to set (at XLineChartItem)
 
 Default is Random
 */
@property (nonatomic, assign) XXColorMode colorMode;


/**
 Line Mode
 - BrokeLine
 - CurveLine
 
 Default is BrokeLine

 */
@property (nonatomic, assign) XXLineMode lineMode;


/**
 Line Graph Mode
 - MutiLine
 - GraphLine
 
 Default is MutiLine
 */
@property (nonatomic, assign) XXLineGraphMode lineGraphMode;


/**
 XXLineChart初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber graphMode:(XXLineGraphMode)graphMode;

@end
