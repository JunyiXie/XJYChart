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
#import "XLineChartConfiguration.h"

@interface XLineChart : UIView

@property(nonatomic, strong) UIColor* chartBackgroundColor;

/// tap and pin gesture
@property(nonatomic, assign) BOOL isAllowGesture;

@property(nonatomic, strong) XLineChartConfiguration* configuration;

/**
 Line Mode
 - BrokeLine
 - CurveLine

 Default is BrokeLine

 */
@property(nonatomic, assign) XXLineMode lineMode;

/**
 Line Graph Mode
 - MutiLine
 - GraphLine

 Default is MutiLine
 */
@property(nonatomic, assign) XXLineGraphMode lineGraphMode;

/**
 XXLineChart初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDiscribeArray:(NSMutableArray<NSString*>*)dataDiscribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XXLineGraphMode)graphMode;
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDiscribeArray:(NSMutableArray<NSString*>*)dataDiscribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XXLineGraphMode)graphMode
           chartConfiguration:(XLineChartConfiguration*)configuration;
@end
