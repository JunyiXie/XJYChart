//
//  XAuxiliaryCalculationHelper.h
//  RecordLife
//
//  Created by 谢俊逸 on 18/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAuxiliaryCalculationHelper : NSObject

+ (instancetype)shareCalculationHelper;
/**
 计算正高度占比

 @param top topHeight
 @param bottom bottomHeight
 @param height Height
 @return 0.x
 */
- (CGFloat)calculateTheProportionOfHeightByTop:(CGFloat)top
                                        bottom:(CGFloat)bottom
                                        height:(CGFloat)height;

/// 计算 目前高度   /  （正高度／负高度）的比值 return 正值
- (CGFloat)calculateThePositiveNegativeProportionOfHeightByTop:(CGFloat)top
                                                        bottom:(CGFloat)bottom
                                                        height:(CGFloat)height;
/**
 计算宽度占比

 @param idx 0.1.2.3...
 @param count 总数
 @return 0.x
 */
- (CGFloat)calculateTheProportionOfWidthByIdx:(CGFloat)idx
                                        count:(NSUInteger)count;

/**
 compute Stroke Start Array With DataArray

 @param dataArray NSNumber*
 @return NSMutableArray
 */
- (NSMutableArray*)computeStrokeStartArrayWithDataArray:
    (NSMutableArray*)dataArray;

/**
 Compute Stroke End Array

 @param dataArray NSNumber*
 @return NSMutableArray
 */
- (NSMutableArray*)computeStrokeEndArrayWithDataArray:
    (NSMutableArray*)dataArray;

/**
 find Percentage Of Angle In Circle

 @param center Circle center
 @param reference From Point
 @return 0.xxx
 */
- (CGFloat)findPercentageOfAngleInCircle:(CGPoint)center
                               fromPoint:(CGPoint)reference;

/**
 changeCoordinateSystem to Drawable Point

 @param point point
 @param height view height
 @return drawable Point
 */
- (CGPoint)changeCoordinateSystem:(CGPoint)point withViewHeight:(CGFloat)height;

/**
 Compute control Point Between Point1 And Point2

 @param point1 point1
 @param point2 point2
 @return controlPoint
 */
- (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

/**
 Compute Mid Point Between Point1 And Point2

 @param point1 point1
 @param point2 point2
 @return midPoint
 */
- (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

/**
 Judge a Point Whether or not in a polygon

 @param pointValue pointValue
 @param pointsArray polygon points
 @return YES/NO
 */
- (BOOL)containPoint:(NSValue*)pointValue
              Points:(NSMutableArray<NSValue*>*)pointsArray;

/**
 pointy in view flip increment


 @param boudnsHeight boudnsHeight view.bounds.height
 @param targetY targetY targetY
 @param percentage percentage percentagep
 @param startRatio start ratio
 @return originY
 */
- (CGFloat)
getOriginYIncreaseInFilpCoordinateSystemWithBoundsH:(CGFloat)boudnsHeight
                                            targetY:(CGFloat)targetY
                                         percentage:(CGFloat)percentage
                                         startRatio:(CGFloat)startRatio;

/**
 根据原始的Y,Y在翻转坐标系中对应的值*比例,得到iOS原始坐标系中的Y值.originY --->
 filpY * ration ---> originY
 @param ratio ratio
 @param boundsH boundsH
 @param originY originY
 @return originY
 */
- (CGFloat)getOriginYInFilpCoordinateSystemWithRatio:(CGFloat)ratio
                                             boundsH:(CGFloat)boundsH
                                             originY:(CGFloat)originY;
@end
