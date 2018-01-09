//
//  XStackAreaLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 11/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XStackAreaLineContainerView.h"
#import "XAuxiliaryCalculationHelper.h"
#import "XColor.h"
#import "XAnimationLabel.h"
#import "XAnimation.h"

#pragma mark - Macro

#define LineWidth 6.0
#define PointDiameter 5.0

@interface XStackAreaLineContainerView ()

@property(nonatomic, strong) CABasicAnimation* pathAnimation;
@property(nonatomic, strong) CAShapeLayer* coverLayer;

@property(nonatomic, strong) NSMutableArray<CAGradientLayer*>* shapeLayerArray;
@property(nonatomic, strong) NSMutableArray<XAnimationLabel*>* labelArray;
@property(nonatomic, strong)
    NSMutableArray<NSMutableArray<NSValue*>*>* stackAreaPointsArray;
@property(nonatomic, strong)
    NSMutableArray<NSMutableArray<NSNumber*>*>* stackValuesArray;

@end

@implementation XStackAreaLineContainerView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
                configuration:(XStackAreaLineChartConfiguration*)configuration {
  if (self = [super initWithFrame:frame]) {
    self.configuration = configuration;
    self.backgroundColor = self.configuration.chartBackgroundColor;

    self.coverLayer = [CAShapeLayer layer];
    self.shapeLayerArray = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    self.stackValuesArray = [NSMutableArray new];
    self.stackAreaPointsArray = [NSMutableArray new];

    self.dataItemArray = dataItemArray;
    self.top = topNumber;
    self.bottom = bottomNumber;
  }
  return self;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
  [self cleanPreDrawLayerAndData];
  [super drawRect:rect];
  CGContextRef context = UIGraphicsGetCurrentContext();
  [self strokeAuxiliaryLineInContext:context];
  [self strokeLine];
  [self strokePointInContext:context];
}

- (void)strokeLine {
  NSMutableArray* valuesArrays = [self getValuesArrays];

  self.stackValuesArray = [self valuesArraysTostackValuesArray:valuesArrays];
  self.stackAreaPointsArray = [NSMutableArray new];
  /**
  =>
  
  [1,1,1,1,1]
  [3,5,6,2,3]
  **/
   // 转换
  for (int i = 0; i < self.dataItemArray.count; i++) {
    NSMutableArray* values = [NSMutableArray new];
    for (int j = 0; j < self.stackValuesArray.count; j++) {
      [values addObject:self.stackValuesArray[j][i]];
    }
    NSMutableArray<NSValue*>* linePointArray =
    [self getDrawablePointsWithStackValues:values];
    [self.stackAreaPointsArray addObject:linePointArray];
  }

  NSMutableArray<UIColor*>* colors = [self getColors];

  for (NSInteger i = self.stackAreaPointsArray.count - 1; i >= 0; i--) {
    CGPoint leftConerPoint = CGPointMake(
        self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    CGPoint rightConerPoint =
        CGPointMake(self.frame.origin.x + self.frame.size.width,
                    self.frame.origin.y + self.frame.size.height);
    CAGradientLayer* gradientAreaLineLayer = [self getGradientLineShapeLayerWithPoints:self.stackAreaPointsArray[i] leftConerPoint:leftConerPoint rightConerPoint:rightConerPoint color:colors[i]];
    gradientAreaLineLayer.opacity = self.configuration.areaLineAlpha;
    
    [self.shapeLayerArray addObject:gradientAreaLineLayer];
    [self.layer addSublayer:gradientAreaLineLayer];
  }
}

- (void)strokeAuxiliaryLineInContext:(CGContextRef)context {
  if (self.configuration.isShowAuxiliaryDashLine) {
    CGContextSetStrokeColorWithColor(context, self.configuration.auxiliaryDashLineColor.CGColor);
    CGContextSaveGState(context);
    CGFloat lengths[2] = {5.0, 5.0};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextSetLineWidth(context, 0.2);
    for (int i = 0; i < 11; i++) {
      CGContextMoveToPoint(
                           context, 5, self.frame.size.height - (self.frame.size.height) / 11 * i);
      CGContextAddLineToPoint(
                              context, self.frame.size.width,
                              self.frame.size.height - ((self.frame.size.height) / 11) * i);
      CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, self.configuration.auxiliaryDashLineColor.CGColor);
  }
}

- (void)strokePointInContext:(CGContextRef)context {
  UIColor* pointColor = [UIColor whiteColor];
  UIColor* wireframeColor = [UIColor whiteColor];
  ;
  [self.stackAreaPointsArray enumerateObjectsUsingBlock:^(
                                 NSMutableArray<NSValue*>* _Nonnull points,
                                 NSUInteger idx, BOOL* _Nonnull stop) {

    [points enumerateObjectsUsingBlock:^(NSValue* _Nonnull pointValue,
                                         NSUInteger idx, BOOL* _Nonnull stop) {
      // 去除闭合曲线辅助点的影响
      if (idx > 0 && idx < points.count - 1) {
        //画点
        CGPoint point = pointValue.CGPointValue;
        CGContextSetFillColorWithColor(context, pointColor.CGColor);  //填充颜色
        CGContextSetStrokeColorWithColor(context,
                                         wireframeColor.CGColor);  //线框颜色
        CGContextFillEllipseInRect(
            context,
            CGRectMake(point.x - PointDiameter / 2, point.y - PointDiameter / 2,
                       PointDiameter, PointDiameter));
      }
    }];
  }];
}

- (void)cleanPreDrawLayerAndData {
  [self.shapeLayerArray
      enumerateObjectsUsingBlock:^(CAGradientLayer* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [obj removeFromSuperlayer];
      }];
  [self.labelArray
      enumerateObjectsUsingBlock:^(XAnimationLabel* _Nonnull obj,
                                   NSUInteger idx, BOOL* _Nonnull stop) {
        [obj removeFromSuperview];
      }];
  [self.shapeLayerArray removeAllObjects];
  [self.labelArray removeAllObjects];
}

#pragma mark - Calculate
- (NSMutableArray<NSValue*>*)getDrawablePointsWithStackValues:
    (NSMutableArray<NSNumber*>*)values {
  NSMutableArray<NSValue*>* linePointArray = [NSMutableArray new];
  // Get Points
  [values enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj, NSUInteger idx,
                                       BOOL* _Nonnull stop) {
    CGPoint point = [self calculateDrawablePointWithNumber:obj
                                                       idx:idx
                                               numberArray:values
                                                    bounds:self.bounds];
    //坐标系反转
    NSValue* pointValue = [NSValue valueWithCGPoint:point];
    [linePointArray addObject:pointValue];
  }];

  // close path
  CGPoint temfirstPoint = linePointArray[0].CGPointValue;
  CGPoint temlastPoint = linePointArray.lastObject.CGPointValue;
  CGPoint firstPoint = CGPointMake(0, temfirstPoint.y);
  CGPoint lastPoint = CGPointMake(self.frame.size.width, temlastPoint.y);

  [linePointArray insertObject:[NSValue valueWithCGPoint:firstPoint] atIndex:0];
  [linePointArray addObject:[NSValue valueWithCGPoint:lastPoint]];

  return linePointArray;
}

- (NSMutableArray<NSMutableArray<NSNumber*>*>*)valuesArraysTostackValuesArray:
    (NSMutableArray<NSMutableArray<NSNumber*>*>*)valuesArrays {
  NSMutableArray* conversionValuesArrays =
      [self getValueCalucuteArrays:valuesArrays];
  NSMutableArray* stackValuesArray = [NSMutableArray new];
  [conversionValuesArrays enumerateObjectsUsingBlock:^(
                              NSMutableArray<NSNumber*>* _Nonnull values,
                              NSUInteger idx, BOOL* _Nonnull stop) {
    __block int tem = 0;
    NSMutableArray* stackValues = [NSMutableArray new];
    [values enumerateObjectsUsingBlock:^(NSNumber* _Nonnull value,
                                         NSUInteger idx, BOOL* _Nonnull stop) {
      tem = tem + value.floatValue;
      [stackValues addObject:@(tem)];
    }];
    [stackValuesArray addObject:stackValues];
  }];
  return stackValuesArray;
}


/**
 eg:
 
 [1,1,1,1,1]
 [2,4,5,1,2]
 
 =>
 
 [1,3]
 [1,5]
 [1,6]
 [1,2]
 [1,3]
 
 */
- (NSMutableArray<NSMutableArray<NSNumber*>*>*)getValueCalucuteArrays:
    (NSMutableArray<NSMutableArray<NSNumber*>*>*)valuesArrays {
  NSMutableArray* conversionValuesArrays = [NSMutableArray new];
  for (int i = 0; i < valuesArrays[0].count; i++) {
    NSMutableArray* conversionValues = [NSMutableArray new];
    for (int j = 0; j < valuesArrays.count; j++) {
      [conversionValues addObject:valuesArrays[j][i]];
    }
    [conversionValuesArrays addObject:conversionValues];
  }
  return conversionValuesArrays;
}

- (NSMutableArray<NSMutableArray<NSNumber*>*>*)getValuesArrays {
  NSMutableArray* valuesArrays = [NSMutableArray new];
  // get data to Arrays
  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XLineChartItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [valuesArrays addObject:obj.numberArray];
      }];
  return valuesArrays;
}

- (NSMutableArray<UIColor*>*)getColors {
  NSMutableArray* colorArray = [NSMutableArray new];

  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XLineChartItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [colorArray addObject:obj.color];
      }];
  return colorArray;
}

#pragma mark - Layer

- (CAGradientLayer*)getGradientLineShapeLayerWithPoints:(NSArray<NSValue*>*)points
                              leftConerPoint:(CGPoint)leftConerPoint
                             rightConerPoint:(CGPoint)rightConerPoint
                                       color:(UIColor*)color {
  
  CAShapeLayer* shapeLayer = [self getLineShapeLayerWithPoints:points leftConerPoint:leftConerPoint rightConerPoint:rightConerPoint color:color];
  CAGradientLayer* gradientLayer = [CAGradientLayer layer];
  gradientLayer.colors = @[
                           (__bridge id)color.CGColor,
                           (__bridge id)[UIColor whiteColor].CGColor
                           ];
  gradientLayer.frame = self.frame;
  gradientLayer.mask = shapeLayer;
  return gradientLayer;
}


- (CAShapeLayer*)getLineShapeLayerWithPoints:(NSArray<NSValue*>*)points
                              leftConerPoint:(CGPoint)leftConerPoint
                             rightConerPoint:(CGPoint)rightConerPoint
                                       color:(UIColor*)color {
  CAShapeLayer* lineLayer = [CAShapeLayer layer];
  UIBezierPath* line = [[UIBezierPath alloc] init];

  // line
  for (int i = 0; i < points.count - 1; i++) {
    CGPoint point1 = points[i].CGPointValue;
    CGPoint point2 = points[i + 1].CGPointValue;
    if (i == 0) {
      [line moveToPoint:point1];
    }
    if (self.configuration.lineMode == CurveLine) {
      CGPoint midPoint = [[XAuxiliaryCalculationHelper shareCalculationHelper]
          midPointBetweenPoint1:point1
                      andPoint2:point2];
      [line addQuadCurveToPoint:midPoint
                   controlPoint:[[XAuxiliaryCalculationHelper
                                    shareCalculationHelper]
                                    controlPointBetweenPoint1:midPoint
                                                    andPoint2:point1]];
      [line addQuadCurveToPoint:point2
                   controlPoint:[[XAuxiliaryCalculationHelper
                                    shareCalculationHelper]
                                    controlPointBetweenPoint1:midPoint
                                                    andPoint2:point2]];
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
  lineLayer.fillColor = color.CGColor;
  lineLayer.opacity = 1.0;
  lineLayer.lineWidth = 4;
  lineLayer.lineCap = kCALineCapRound;
  lineLayer.lineJoin = kCALineJoinRound;
  return lineLayer;
}

#pragma mark - Help Methods
// Calculate -> Point
- (CGPoint)calculateDrawablePointWithNumber:(NSNumber*)number
                                        idx:(NSUInteger)idx
                                numberArray:(NSMutableArray*)numberArray
                                     bounds:(CGRect)bounds {
  CGFloat percentageH = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      calculateTheProportionOfHeightByTop:self.top.doubleValue
                                   bottom:self.bottom.doubleValue
                                   height:number.doubleValue];
  CGFloat percentageW = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      calculateTheProportionOfWidthByIdx:(idx)
                                   count:numberArray.count];
  CGFloat pointY = percentageH * bounds.size.height;
  CGFloat pointX = percentageW * bounds.size.width;
  CGPoint point = CGPointMake(pointX, pointY);
  CGPoint rightCoordinatePoint =
      [[XAuxiliaryCalculationHelper shareCalculationHelper]
          changeCoordinateSystem:point
                  withViewHeight:self.frame.size.height];
  return rightCoordinatePoint;
}
#pragma mark GET
- (XStackAreaLineChartConfiguration*)configuration {
  if (_configuration == nil) {
    _configuration = [[XStackAreaLineChartConfiguration alloc] init];
  }
  return _configuration;
}

@end
