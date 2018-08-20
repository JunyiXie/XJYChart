//
//  XLineChartView.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLineChartItem.h"
#import "XEnumHeader.h"
#import "XNormalLineChartConfiguration.h"
@interface XLineChartView : UIScrollView
/**
 初始化方法

 @param frame frame
 @param dataItemArray items
 @param dataDescribeArray dataDescribeArray
 @param topNumbser top
 @param bottomNumber buttom
 @param configuration LineChartConfiguration
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDescribeArray:(NSMutableArray<NSString*>*)dataDescribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XLineGraphMode)graphMode
                configuration:(XLineChartConfiguration*)configuration;

/**
 dataItemArray
 */
@property(nonatomic, strong) NSMutableArray<XLineChartItem*>* dataItemArray;

@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;
/**
 The vertical high
 */
@property(nonatomic, strong) NSNumber* top;

/**
 The vertical low
 */
@property(nonatomic, strong) NSNumber* bottom;


@property(nonatomic, strong) XLineChartConfiguration* configuration;

/**
 Line Graph Mode
 - MutiLine
 - GraphLine

 Default is MutiLine
 */
@property(nonatomic, assign) XLineGraphMode lineGraphMode;
@property(nonatomic, strong) UIColor* chartBackgroundColor;

@end
