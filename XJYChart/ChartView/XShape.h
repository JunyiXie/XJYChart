//
//  XShape.h
//  RecordLife
//
//  Created by 谢俊逸 on 03/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface XShape : CAShapeLayer
+ (CAShapeLayer *)getLineShapeLayerWithPoints:(NSArray<NSValue *> *)points leftConerPoint:(CGPoint)leftConerPoint rightConerPoint:(CGPoint)rightConerPoint;
+ (CAShapeLayer *)cycleShapeLayerWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle bounds:(CGRect)bounds;
+ (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor;
@end
