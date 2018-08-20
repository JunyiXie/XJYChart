//
//  XAreaLineContainerView.h
//  RecordLife
//
//  Created by 谢俊逸 on 09/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLineChartItem.h"
#import "XEnumHeader.h"
#import "XAreaLineChartConfiguration.h"

@interface XAreaLineContainerView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
                configuration:(XAreaLineChartConfiguration*)configuration;
/**
 dataItemArray
 */
@property(nonatomic, strong) NSMutableArray<XLineChartItem*>* dataItemArray;
/**
 纵坐标最高点
 */
@property(nonatomic, strong) NSNumber* top;

/**
 纵坐标最低点
 */
@property(nonatomic, strong) NSNumber* bottom;

/**
 图表的其他配置
 */
@property(nonatomic, strong) XAreaLineChartConfiguration* configuration;

@end
