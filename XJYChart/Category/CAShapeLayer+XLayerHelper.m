//
//  CAShapeLayer+XJYLayerHelper.m
//  RecordLife
//
//  Created by 谢俊逸 on 31/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "CAShapeLayer+XLayerHelper.h"

@implementation CAShapeLayer (XJYLayerHelper)

+ (CAShapeLayer*)pointLayerWithDiameter:(CGFloat)diameter
                                  color:(UIColor*)color
                                 center:(CGPoint)center {
  CAShapeLayer* pointLayer = [CAShapeLayer layer];
  UIBezierPath* path = [UIBezierPath
      bezierPathWithRoundedRect:CGRectMake(center.x - diameter / 2,
                                           center.y - diameter / 2, diameter,
                                           diameter)
                   cornerRadius:diameter / 2];

  pointLayer.path = path.CGPath;
  pointLayer.fillColor = color.CGColor;
  return pointLayer;
}

+ (CAShapeLayer*)annularPointLayerWithDiameter:(CGFloat)diameter
                                         color:(UIColor*)color
                                        center:(CGPoint)center {
  CAShapeLayer* pointLayer = [CAShapeLayer layer];
  UIBezierPath* path = [UIBezierPath
      bezierPathWithRoundedRect:CGRectMake(center.x - diameter / 2,
                                           center.y - diameter / 2, diameter,
                                           diameter)
                   cornerRadius:diameter / 2];

  pointLayer.path = path.CGPath;
  pointLayer.fillColor = color.CGColor;
  pointLayer.strokeColor = [UIColor whiteColor].CGColor;
  pointLayer.lineWidth = 3;
  return pointLayer;
}

/// ShapeLayer With bounds
+ (CAShapeLayer*)rectShapeLayerWithBounds:(CGRect)rect
                                fillColor:(UIColor*)fillColor {
  UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
  CAShapeLayer* rectLayer = [CAShapeLayer layer];
  rectLayer.path = path.CGPath;
  rectLayer.fillColor = fillColor.CGColor;
  rectLayer.path = path.CGPath;
  return rectLayer;
}

+ (CAShapeLayer*)lineShapeLayerWithPoints:
                     (NSMutableArray<NSValue*>*)pointsValueArray
                                    color:(UIColor*)color
                                 lineMode:(XLineMode)lineMode
                                lineWidth:(CGFloat)lineWidth {
  UIBezierPath* line = [[UIBezierPath alloc] init];

  CAShapeLayer* chartLine = [CAShapeLayer layer];
  chartLine.lineCap = kCALineCapRound;
  chartLine.lineJoin = kCALineJoinRound;
  chartLine.lineWidth = lineWidth;

  CGFloat touchLineWidth = 40;
  for (int i = 0; i < pointsValueArray.count - 1; i++) {
    CGPoint point1 = pointsValueArray[i].CGPointValue;

    CGPoint point2 = pointsValueArray[i + 1].CGPointValue;
    [line moveToPoint:point1];

    if (lineMode == Straight) {
      [line addLineToPoint:point2];
    } else if (lineMode == CurveLine) {
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

    //当前线段的四个点
    CGPoint rectPoint1 = CGPointMake(point1.x - touchLineWidth / 2,
                                     point1.y - touchLineWidth / 2);
    NSValue* value1 = [NSValue valueWithCGPoint:rectPoint1];
    CGPoint rectPoint2 = CGPointMake(point1.x - touchLineWidth / 2,
                                     point1.y + touchLineWidth / 2);
    NSValue* value2 = [NSValue valueWithCGPoint:rectPoint2];
    CGPoint rectPoint3 = CGPointMake(point2.x + touchLineWidth / 2,
                                     point2.y - touchLineWidth / 2);
    NSValue* value3 = [NSValue valueWithCGPoint:rectPoint3];
    CGPoint rectPoint4 = CGPointMake(point2.x + touchLineWidth / 2,
                                     point2.y + touchLineWidth / 2);
    NSValue* value4 = [NSValue valueWithCGPoint:rectPoint4];

    //当前线段的矩形组成点
    NSMutableArray<NSValue*>* segementPointsArray = [NSMutableArray new];
    [segementPointsArray addObject:value1];
    [segementPointsArray addObject:value2];
    [segementPointsArray addObject:value3];
    [segementPointsArray addObject:value4];
  }

  chartLine.path = line.CGPath;
  chartLine.strokeStart = 0.0;
  chartLine.strokeEnd = 1.0;
  chartLine.strokeColor = color.CGColor;
  chartLine.fillColor = [UIColor clearColor].CGColor;

  return chartLine;
}


@end
