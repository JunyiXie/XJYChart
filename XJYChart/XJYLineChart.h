//
//  XJYLineChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJYAuxiliaryCalculationHelper.h"
#import "Masonry.h"
//颜色

#define UIColorFromRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
typedef enum DrawLineType{
    PointType = 0,
    BrokenType ,
    BezierType,
}DrowLineType;

typedef NS_ENUM(NSUInteger, XJYLineChartType) {
    //仅有线和横竖坐标
    XJYLineChartTypeSimple,
    //有表格 default
    XJYLineChartTypeNormal,
    //有数值
    XJYLineChartTypeDetail,
};

@interface XJYLineChart : UIView

@property (nonatomic, assign) XJYLineChartType XJYLineChartType;

@property (nonatomic, strong) NSMutableArray *levelDataArray;//横坐标数据

@property (nonatomic, strong) NSMutableArray *ordinateDateArray;//纵坐标数据

//点数据
@property (nonatomic, strong) NSMutableArray *verticalNumberDataArray;
//第二组点
@property (nonatomic, strong) NSMutableArray *verticalSecondNumberDataArray;
//第三组点
@property (nonatomic, strong) NSMutableArray *verticalThirdNumberDataArray;


/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;

//折线的颜色 default is black
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *secondLineColor;
@property (nonatomic, strong) UIColor *thirdLineColor;

//点的颜色 default is red
@property (nonatomic, strong) UIColor *pointColor;
@property (nonatomic, strong) UIColor *secondPointColor;
@property (nonatomic, strong) UIColor *thirdPointColor;

//图表的背景颜色 default is white
@property (nonatomic, strong) UIColor *chartBackgroundColor;




@end
