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
#import "CAShapeLayer+frameCategory.h"


#define LineWidth 6.0
#define PointDiameter 10.0

@interface XLineContainerView()
@property (nonatomic, strong) CABasicAnimation *pathAnimation;
//二维数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *pointsArrays;

@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *shapeLayerArray;

//点击高亮的layer
@property (nonatomic, strong) CAShapeLayer *coverLayer;
@end

@implementation XLineContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        self.coverLayer = [CAShapeLayer layer];
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
            CGContextFillEllipseInRect(ContextRef, CGRectMake(point.x - PointDiameter/2, self.bounds.size.height - point.y - PointDiameter/2, PointDiameter, PointDiameter));
        }];
    }];
    
    [self strokeLineChart];
    
}
- (void)strokeLineChart {
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (self.colorModel == Random) {
            [self.shapeLayerArray addObject:[self shapeLayerWithPoints:obj colors:[[XJYColor shareXJYColor] randomColorInColorArray]]];
        } else {
            [self.shapeLayerArray addObject:[self shapeLayerWithPoints:obj colors:self.dataItemArray[idx].color]];
        }
        
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
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = LineWidth;
    
    CGFloat touchLineWidth = 25;
    
    
    for (int i = 0; i < pointsValueArray.count - 1; i++) {
        CGPoint point1 = pointsValueArray[i].CGPointValue;
        CGPoint point2 = pointsValueArray[i + 1].CGPointValue;
        //坐标系反转
        CGPoint temPoint1 = CGPointMake(point1.x, self.frame.size.height - point1.y);
        CGPoint temPoint2 = CGPointMake(point2.x, self.frame.size.height - point2.y);
        [line moveToPoint:temPoint1];
        [line addLineToPoint:temPoint2];
        
        //当前线段的四个点
        CGPoint rectPoint1 = CGPointMake(temPoint1.x - touchLineWidth/2, temPoint1.y - touchLineWidth/2);
        NSValue *value1 = [NSValue valueWithCGPoint:rectPoint1];
        CGPoint rectPoint2 = CGPointMake(temPoint1.x - touchLineWidth/2, temPoint1.y + touchLineWidth/2);
        NSValue *value2 = [NSValue valueWithCGPoint:rectPoint2];
        CGPoint rectPoint3 = CGPointMake(temPoint2.x + touchLineWidth/2, temPoint2.y - touchLineWidth/2);
        NSValue *value3 = [NSValue valueWithCGPoint:rectPoint3];
        CGPoint rectPoint4 = CGPointMake(temPoint2.x + touchLineWidth/2, temPoint2.y + touchLineWidth/2);
        NSValue *value4 = [NSValue valueWithCGPoint:rectPoint4];
        
        //当前线段的矩形组成点
        NSMutableArray<NSValue *> *segementPointsArray = [NSMutableArray new];
        [segementPointsArray addObject:value1];
        [segementPointsArray addObject:value2];
        [segementPointsArray addObject:value3];
        [segementPointsArray addObject:value4];
        
        //把当前线段的矩形组成点数组添加到 数组中
        if (chartLine.segementPointsArrays == nil) {
            chartLine.segementPointsArrays = [[NSMutableArray alloc] init];
            [chartLine.segementPointsArrays addObject:segementPointsArray];
        } else {
            [chartLine.segementPointsArrays addObject:segementPointsArray];
        }
        
        
    }
    
    chartLine.path = line.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = color.CGColor;
    
    //selectedStatus
    chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
    
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    
    return chartLine;
}

- (CAShapeLayer *)shapeLayerWithPath:(CGPathRef)path color:(UIColor *)color {
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = LineWidth * 1.5;
    chartLine.path =path;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = color.CGColor;
    return chartLine;
}

- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = 3.0;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}



- (BOOL)containPoint:(NSValue *)pointValue Points:(NSMutableArray<NSValue *> *)pointsArray {
    float vertx[4] = {0,0,0,0};
    float verty[4] = {0,0,0,0};
    CGPoint targetPoint = pointValue.CGPointValue;
    unsigned i = 0;
    for (i = 0; i < pointsArray.count; i = i + 1) {
        CGPoint point1 = pointsArray[i].CGPointValue;
        vertx[i] = point1.x;
        verty[i] = point1.y;
    }
    return pnpoly(4, vertx, verty, targetPoint.x, targetPoint.y);
}
// 判断算法
int pnpoly(int nvert, float *vertx, float *verty, float testx, float testy)
{
    int i, j, c = 0;
    for (i = 0, j = nvert-1; i < nvert; j = i++)
    {
        if ( ((verty[i]>testy) != (verty[j]>testy)) &&
            (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
            c = !c;
    }
    return c;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //根据 点击的x坐标 只找在x 坐标区域内的 线段进行判断
    
    //坐标系转换
    CGPoint __block point = [[touches anyObject] locationInView:self];
    
    NSMutableArray<NSNumber *> *xArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.dataItemArray.count; i ++) {
        [xArray addObject:@(i * self.frame.size.width/self.dataItemArray.count)];
    }
    
    //找到小的区域
    int areaIdx = 0;
    
    for (int i = 0; i < self.dataItemArray.count - 1; i ++) {
        if (point.x > xArray[i].floatValue && point.x < xArray[i + 1].floatValue) {
            areaIdx = i;
        }
    }
    
    [self.shapeLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray<NSMutableArray<NSValue *> *> *segementPointsArrays = obj.segementPointsArrays;
        NSMutableArray<NSValue *> *points = segementPointsArrays[areaIdx];
        NSUInteger shapeLayerIndex = idx;
        
        if ([self containPoint:[NSValue valueWithCGPoint:point] Points:points]) {
            if (self.coverLayer.selectStatusNumber.boolValue == YES) {
                [self.coverLayer removeFromSuperlayer];
                self.coverLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
            } else {
                [self.coverLayer removeFromSuperlayer];
                self.coverLayer = [self shapeLayerWithPath:self.shapeLayerArray[shapeLayerIndex].path color:XJYLightBlue];
                self.coverLayer.selectStatusNumber = [NSNumber numberWithBool:YES];
                [self.layer addSublayer:self.coverLayer];
            }
        }

    }];
    
/*
    [self.shapeLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray<NSMutableArray<NSValue *> *> *segementPointsArrays = obj.segementPointsArrays;
        NSUInteger shapeLayerIndex = idx;
        [segementPointsArrays enumerateObjectsUsingBlock:^(NSMutableArray<NSValue *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([self containPoint:[NSValue valueWithCGPoint:point] Points:obj]) {
                if (self.coverLayer.selectStatusNumber.boolValue == YES) {
                    [self.coverLayer removeFromSuperlayer];
                    self.coverLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
                } else {
                    [self.coverLayer removeFromSuperlayer];
                    self.coverLayer = [self shapeLayerWithPath:self.shapeLayerArray[shapeLayerIndex].path color:XJYLightBlue];
                    self.coverLayer.selectStatusNumber = [NSNumber numberWithBool:YES];
                    [self.layer addSublayer:self.coverLayer];
                }
            }
            
        }];
    }];
    
 */
}

@end
