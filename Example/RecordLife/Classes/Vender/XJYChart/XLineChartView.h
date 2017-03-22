//
//  XLineChartView.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXLineChartItem.h"
#import "XXEnumHeader.h"
@interface XLineChartView : UIScrollView
/**
 初始化方法
 
 @param frame frame
 @param dataItemArray items
 @param dataDescribeArray dataDescribeArray
 @param topNumbser top
 @param bottomNumber buttom
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDescribeArray:(NSMutableArray<NSString *> *)dataDescribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber ;

/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray<XXLineChartItem *> *dataItemArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;

@property (nonatomic, assign) XXColorModel colorModel;

@end
