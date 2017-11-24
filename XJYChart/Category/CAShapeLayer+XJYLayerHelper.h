//
//  CAShapeLayer+XJYLayerHelper.h
//  RecordLife
//
//  Created by 谢俊逸 on 31/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "XEnumHeader.h"
#import "XAuxiliaryCalculationHelper.h"


@interface CAShapeLayer (XJYLayerHelper)
+ (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)lineShapeLayerWithPoints:(NSMutableArray<NSValue *> *)pointsValueArray colors:(UIColor *)color lineMode:(XXLineMode)lineMode lineWidth:(CGFloat)lineWidth;
@end
