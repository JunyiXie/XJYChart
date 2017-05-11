//
//  XAreaLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 09/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAreaLineContainerView.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XJYColor.h"
#import "CAShapeLayer+frameCategory.h"
#import "XXAnimationLabel.h"
#import "XJYAnimation.h"

#pragma mark - Macro

#define LineWidth 6.0
#define PointDiameter 11.0

@interface XAreaLineContainerView ()

@property (nonatomic, strong) CABasicAnimation *pathAnimation;



@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *shapeLayerArray;
@property (nonatomic, strong) CAShapeLayer *coverLayer;
@property (nonatomic, strong) NSMutableArray<XXAnimationLabel *> *labelArray;
/**
 All lines points
 */
@property (nonatomic, strong) NSMutableArray<NSValue *> *points;


@property (nonatomic, strong) NSMutableArray<NSValue *> *areaPoints;

@property (nonatomic, strong) UIColor *areaColor;

@end


@implementation XAreaLineContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = XJYBlue;
        
        self.coverLayer = [CAShapeLayer layer];
        self.shapeLayerArray = [NSMutableArray new];
        self.points = [NSMutableArray new];
        self.labelArray = [NSMutableArray new];
        self.areaPoints = [NSMutableArray new];
        
        self.dataItemArray = dataItemArray;
        self.top  = topNumber;
        self.bottom = bottomNumber;
        self.lineMode = BrokenLine;
        self.colorMode = Random;
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    
    [self cleanPreDrawLayerAndData];
    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self strokeAuxiliaryLineInContext:context];
    [self strokePointInContext:context];
    [self strokeLine];
    

}

/// Stroke Auxiliary
- (void)strokeAuxiliaryLineInContext:(CGContextRef)context {
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1 alpha:0.5].CGColor);
    CGFloat lengths[2] = { 5, 5 };
    CGContextSetLineDash(context, 0, lengths, 2);
    self.points = [self getDrawablePoints];
    NSInteger count = self.dataItemArray[0].numberArray.count;
    for (int i =0 ; i < count; i++) {
        CGContextMoveToPoint(context, self.points[i].CGPointValue.x,0);
        CGContextAddLineToPoint(context,self.points[i].CGPointValue.x,self.frame.size.height);
        CGContextStrokePath(context);
    }

}


- (void)strokePointInContext:(CGContextRef)context {
    
    self.points = [self getDrawablePoints];
    UIColor *pointColor = [UIColor whiteColor];
    UIColor *wireframeColor = [UIColor whiteColor];;
    [self.points enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //画点
        NSValue *pointValue = obj;
        CGPoint point = pointValue.CGPointValue;
        CGContextSetFillColorWithColor(context, pointColor.CGColor);//填充颜色
        CGContextSetStrokeColorWithColor(context, wireframeColor.CGColor);//线框颜色
        CGContextFillEllipseInRect(context, CGRectMake(point.x - PointDiameter/2, point.y - PointDiameter/2, PointDiameter, PointDiameter));
    }];
}


- (void)cleanPreDrawLayerAndData {
    
    [self.shapeLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [self.labelArray enumerateObjectsUsingBlock:^(XXAnimationLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.shapeLayerArray removeAllObjects];
    [self.labelArray removeAllObjects];
    [self.points removeAllObjects];
    [self.areaPoints removeAllObjects];
    
}


- (void)strokeLine {
    self.areaPoints = [self getAreaDrawablePoints];
    
    CGPoint leftConerPoint = CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    CGPoint rightConerPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
    
    CAShapeLayer *lineLayer = [self getLineShapeLayerWithPoints:self.areaPoints leftConerPoint:leftConerPoint rightConerPoint:rightConerPoint];
    [self.layer addSublayer:lineLayer];
}


- (NSMutableArray<NSValue *> *)getAreaDrawablePoints {
    if (self.areaPoints.count > 0) {
        return self.areaPoints;
    } else {
        self.points = [self getDrawablePoints];
        self.areaPoints = [self.points mutableCopy];
        CGPoint temfirstPoint = self.points[0].CGPointValue;
        CGPoint temlastPoint = self.points.lastObject.CGPointValue;
        CGPoint firstPoint = CGPointMake(0, temfirstPoint.y);
        CGPoint lastPoint = CGPointMake(self.frame.size.width, temlastPoint.y);
        
        [self.areaPoints insertObject:[NSValue valueWithCGPoint:firstPoint] atIndex:0];
        [self.areaPoints addObject:[NSValue valueWithCGPoint:lastPoint]];
        
        return self.areaPoints;
    }
    
}

- (NSMutableArray<NSValue *> *)getDrawablePoints {

    if (self.points.count > 0) {
        return self.points;
    } else {
        NSMutableArray *linePointArray = [NSMutableArray new];
        XXLineChartItem *item = self.dataItemArray[0];
        
        // Get Points
        NSMutableArray *numberArray = item.numberArray;
        [item.numberArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [self calculateDrawablePointWithNumber:obj idx:idx numberArray:numberArray bounds:self.bounds];
            //坐标系反转
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [linePointArray addObject:pointValue];
        }];
        return linePointArray;
    }
}


- (CAShapeLayer *)getLineShapeLayerWithPoints:(NSArray<NSValue *> *)points leftConerPoint:(CGPoint)leftConerPoint rightConerPoint:(CGPoint)rightConerPoint {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *line = [[UIBezierPath alloc] init];
    
    // line
    for(int i = 0; i < points.count - 1; i++) {
        CGPoint point1 = points[i].CGPointValue;
        CGPoint point2 = points[i + 1].CGPointValue;
        if (i == 0) {
            [line moveToPoint:point1];
        }
        if (self.lineMode == CurveLine) {
            CGPoint midPoint = [XAreaLineContainerView midPointBetweenPoint1:point1 andPoint2:point2];
            [line addQuadCurveToPoint:midPoint
                         controlPoint:[XAreaLineContainerView controlPointBetweenPoint1:midPoint andPoint2:point1]];
            [line addQuadCurveToPoint:point2
                         controlPoint:[XAreaLineContainerView controlPointBetweenPoint1:midPoint andPoint2:point2]];
        } else {
            [line addLineToPoint:point2];
        }
    }
    // closePoint
    [line addLineToPoint:rightConerPoint];
    [line addLineToPoint:leftConerPoint];
    [line addLineToPoint:points[0].CGPointValue];
    lineLayer.path = line.CGPath;
    lineLayer.strokeColor = [UIColor clearColor].CGColor;
    lineLayer.fillColor = [self getFillColor].CGColor;
    lineLayer.opacity = 0.3;
    lineLayer.lineWidth = 4;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    return lineLayer;
}

- (UIColor *)getFillColor {
    if (self.colorMode == Custom) {
        self.areaColor = self.dataItemArray[0].color;
    } else {
        self.areaColor = XJYWhite;
    }
    return self.areaColor;
}


#pragma mark - Control Point Compute
+ (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    CGPoint controlPoint = [self midPointBetweenPoint1:point1 andPoint2:point2];
    CGFloat diffY = abs((int) (point2.y - controlPoint.y));
    if (point1.y < point2.y)
        controlPoint.y += diffY;
    else if (point1.y > point2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}


#pragma mark - Help Methods
// Calculate -> Point
- (CGPoint)calculateDrawablePointWithNumber:(NSNumber *)number idx:(NSUInteger)idx numberArray:(NSMutableArray *)numberArray bounds:(CGRect)bounds {
    CGFloat percentageH =[[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:number.doubleValue];
    CGFloat percentageW = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:(idx) count:numberArray.count];
    CGFloat pointY = percentageH * bounds.size.height;
    CGFloat pointX = percentageW * bounds.size.width;
    CGPoint point = CGPointMake(pointX, pointY);
    CGPoint rightCoordinatePoint = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] changeCoordinateSystem:point withViewHeight:self.frame.size.height];
    return rightCoordinatePoint;
}




@end
