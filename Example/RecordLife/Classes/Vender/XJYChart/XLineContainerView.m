//
//  XLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//
//MAC OS  和 iOS 的坐标系问题

#import "XLineContainerView.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XJYColor.h"
@interface XLineContainerView()
@property (nonatomic, strong) CABasicAnimation *pathAnimation;
//二维数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *pointsArrays;

@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *shapeLayerArray;
@end

@implementation XLineContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.shapeLayerArray = [NSMutableArray new];
        self.dataItemArray = dataItemArray;
        self.top  = topNumber;
        self.bottom = bottomNumber;
        self.pointsArrays = [NSMutableArray new];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //绘制表格的辅助线
    CGContextRef ContextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ContextRef, [UIColor lightGrayColor].CGColor);
    
    //水平辅助线
    for (int i =0 ; i<11; i++) {
        if (i!=0||i!=11) {
            //            CGContextSetLineWidth(ContextRef, 1);
        }
        //线的宽度
        //        CGContextSetLineWidth(ContextRef, 1);
        
        CGContextMoveToPoint(ContextRef, 5,self.frame.size.height - (self.frame.size.height)/11 * i);
        CGContextAddLineToPoint(ContextRef,self.frame.size.width,self.frame.size.height - ((self.frame.size.height)/11) * i);
        CGContextStrokePath(ContextRef);
    }
    //纵坐标
    CGContextMoveToPoint(ContextRef, 5, 0);
    CGContextAddLineToPoint(ContextRef, 5, self.frame.size.height);
    CGContextStrokePath(ContextRef);
    
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    //设置线宽
    arrow.lineWidth = 1;
    [arrow moveToPoint:CGPointMake(0, 8)];
    [arrow addLineToPoint:CGPointMake(5, 0)];
    [arrow moveToPoint:CGPointMake(5, 0)];
    [arrow addLineToPoint:CGPointMake(10, 8)];
    //设置绘制线条颜色，这个地方需要注意！UIBezierPath本身类中不包含设置颜色的属性，它是通过UIColor来直接设置。
    [[UIColor grayColor] setStroke];
    /*
     *线条形状
     *kCGLineCapButt,   //不带端点
     *kCGLineCapRound,  //端点带圆角
     *kCGLineCapSquare  //端点是正方形
     */
    arrow.lineCapStyle = kCGLineCapRound;
    [arrow stroke];
    
    
    [self.dataItemArray enumerateObjectsUsingBlock:^(XXLineChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *numberArray = obj.numberArray;
        NSMutableArray *linePointArray = [NSMutableArray new];
        [obj.numberArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [self calculatePointWithNumber:obj idx:idx numberArray:numberArray bounds:self.bounds];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [linePointArray addObject:pointValue];
        }];
        [self.pointsArrays addObject:linePointArray];
    }];
    
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIColor *pointColor = [[XJYColor shareXJYColor] randomColorInColorArray];
        UIColor *wireframeColor = [[XJYColor shareXJYColor] randomColorInColorArray];
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //画点
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;
            CGContextSetFillColorWithColor(ContextRef, pointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, wireframeColor.CGColor);//线框颜色
            CGContextFillEllipseInRect(ContextRef, CGRectMake(point.x - 3, self.bounds.size.height - point.y - 3, 6.0, 6.0));
        }];
    }];
    
    [self strokeLineChart];
    
}
- (void)strokeLineChart {
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.shapeLayerArray addObject:[self shapeLayerWithPoints:obj colors:[[XJYColor shareXJYColor] randomColorInColorArray]]];
    }];
    
    [self.shapeLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.layer addSublayer:obj];
    }];
}

#pragma mark Get

#pragma mark Helper

/**
 计算点通过 数值 和 idx
 
 @param number number
 @param idx like 0.1.2.3...
 @return CGPoint
 */
- (CGPoint)calculatePointWithNumber:(NSNumber *)number idx:(NSUInteger)idx numberArray:(NSMutableArray *)numberArray bounds:(CGRect)bounds {
    CGFloat percentageH =[[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:number.doubleValue];
    CGFloat percentageW = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:(idx) count:numberArray.count];
    CGFloat pointY = percentageH * bounds.size.height;
    CGFloat pointX = percentageW * bounds.size.width;
    
    CGPoint point = CGPointMake(pointX, pointY);
    return point;
}

// Point 的 y 与 坐标系不同
- (CAShapeLayer *)shapeLayerWithPoints:(NSMutableArray<NSValue *> *)pointsValueArray colors:(UIColor *)color {
    UIBezierPath *line = [[UIBezierPath alloc] init];
    for (int i = 0; i < pointsValueArray.count - 1; i++) {
        CGPoint point1 = pointsValueArray[i].CGPointValue;
        CGPoint point2 = pointsValueArray[i + 1].CGPointValue;
        CGPoint temPoint1 = CGPointMake(point1.x, self.frame.size.height - point1.y);
        CGPoint temPoint2 = CGPointMake(point2.x, self.frame.size.height - point2.y);
        [line moveToPoint:temPoint1];
        [line addLineToPoint:temPoint2];
    }
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = 3;
    chartLine.path = line.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = color.CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    return chartLine;
}

- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = 10.0;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}


@end
