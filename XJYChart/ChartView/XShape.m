//
//  XShape.m
//  RecordLife
//
//  Created by 谢俊逸 on 03/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XShape.h"
#import "XAuxiliaryCalculationHelper.h"
@implementation XShape
+ (CAShapeLayer *)getLineShapeLayerWithPoints:(NSArray<NSValue *> *)points leftConerPoint:(CGPoint)leftConerPoint rightConerPoint:(CGPoint)rightConerPoint {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *line = [[UIBezierPath alloc] init];
    
    // line
    for(int i = 0; i < points.count - 1; i++) {
        CGPoint point1 = points[i].CGPointValue;
        CGPoint point2 = points[i + 1].CGPointValue;
        if (i == 0) {
            [line moveToPoint:point1];
        }

        [line addLineToPoint:point2];
    }
    // closePoint
    [line addLineToPoint:rightConerPoint];
    [line addLineToPoint:leftConerPoint];
    [line addLineToPoint:points[0].CGPointValue];
    lineLayer.path = line.CGPath;
    lineLayer.strokeColor = [UIColor clearColor].CGColor;
    lineLayer.fillColor = [UIColor redColor].CGColor;
    lineLayer.opacity = 0.3;
    lineLayer.lineWidth = 4;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    return lineLayer;
}
+ (CAShapeLayer *)cycleShapeLayerWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle bounds:(CGRect)bounds {
    CAShapeLayer *cycleLayer = [CAShapeLayer layer];
    // draw cycle
    cycleLayer = [CAShapeLayer layer];
    cycleLayer.frame = bounds;
    cycleLayer.fillColor = [[UIColor clearColor] CGColor];
    // The color used to stroke the shape’s path. Animatable.
    cycleLayer.strokeColor = [[UIColor redColor] CGColor];
    cycleLayer.opacity = 1;
    cycleLayer.lineCap = kCALineCapRound;
    cycleLayer.lineWidth = 10;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    cycleLayer.path =[path CGPath];
    return cycleLayer;
}


+ (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.path = path.CGPath;
    rectLayer.fillColor   = fillColor.CGColor;
    rectLayer.path        = path.CGPath;
    return rectLayer;
}


@end
