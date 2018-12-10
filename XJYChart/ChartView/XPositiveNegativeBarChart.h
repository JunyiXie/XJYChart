//
//  XXPositiveNegativeBarChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBarItem.h"
#import "XJYChartDelegate.h"

@class XBarChartConfiguration;
@interface XPositiveNegativeBarChart : UIView
/**
 初始化方法

 @param frame frame
 @param dataItemArray items
 @param topNumbser top
 @param bottomNumber buttom
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XBarItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
           chartConfiguration:(XBarChartConfiguration*)configuration;
;
@property(nonatomic, strong) id<XJYChartDelegate> barChartDelegate;

/**
 dataItemArray
 */
@property(nonatomic, strong) NSMutableArray<XBarItem*>* dataItemArray;

/**
 纵坐标最高点
 */
@property(nonatomic, strong) NSNumber* top;

/**
 纵坐标最低点
 */
@property(nonatomic, strong) NSNumber* bottom;
@end
