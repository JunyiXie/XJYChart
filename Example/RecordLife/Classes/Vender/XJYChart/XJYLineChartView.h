//
//  XJYLineChartView.h
//  RecordLife
//
//  Created by 谢俊逸 on 18/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYChartView.h"
#import "XJYLineChart.h"
#import "Masonry/Masonry.h"

@interface XJYLineChartView : XJYChartView

@property (nonatomic, strong) NSMutableArray *levelDataArray;


/**
 二维数组 最多支持三组数据
 */
@property (nonatomic, strong) NSMutableArray *verticalNumberDataArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataNameArray;


/**
 top 要 在 verticalNumberDataArray 之前 set
 */
@property (nonatomic, strong) NSNumber *top;
/**
 bottom 要 在 verticalNumberDataArray 之前 set
 */
@property (nonatomic, strong) NSNumber *bottom;

//折线的颜色 default is black
@property (nonatomic, strong) NSMutableArray<UIColor *> *lineColorArray;
//点的颜色 default is red
@property (nonatomic, strong) NSMutableArray<UIColor *> *pointColorArray;
//图表的背景颜色 default is white
@property (nonatomic, strong) UIColor *chartBackgroundColor;


@end
