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
+ (CAShapeLayer*)rectShapeLayerWithBounds:(CGRect)rect
                                fillColor:(UIColor*)fillColor;
+ (CAShapeLayer*)lineShapeLayerWithPoints:
                     (NSMutableArray<NSValue*>*)pointsValueArray
                                    color:(UIColor*)color
                                 lineMode:(XLineMode)lineMode
                                lineWidth:(CGFloat)lineWidth;
+ (CAShapeLayer*)pointLayerWithDiameter:(CGFloat)diameter
                                  color:(UIColor*)color
                                 center:(CGPoint)center;

+ (CAShapeLayer*)annularPointLayerWithDiameter:(CGFloat)diameter
                                         color:(UIColor*)color
                                        center:(CGPoint)center;
@end
