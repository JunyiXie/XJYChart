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
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XLineChartItem *> *)dataItemArray dataDescribeArray:(NSMutableArray<NSString *> *)dataDescribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber  graphMode:(XXLineGraphMode)graphMode;

/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray<XLineChartItem *> *dataItemArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
/**
 The vertical high
 */
@property (nonatomic, strong) NSNumber *top;

/**
 The vertical low
 */
@property (nonatomic, strong) NSNumber *bottom;

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


@end
