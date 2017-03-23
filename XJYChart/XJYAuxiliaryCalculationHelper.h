//
//  XJYAuxiliaryCalculationHelper.h
//  RecordLife
//
//  Created by 谢俊逸 on 18/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJYAuxiliaryCalculationHelper : NSObject



+ (instancetype)shareCalculationHelper;



/**
 计算高度占比

 @param top topHeight
 @param bottom bottomHeight
 @param height Height
 @return 0.x
 */
- (CGFloat)calculateTheProportionOfHeightByTop:(CGFloat)top bottom:(CGFloat)bottom height:(CGFloat)height;

/**
 计算宽度占比

 @param idx 0.1.2.3...
 @param count 总数
 @return 0.x
 */
- (CGFloat)calculateTheProportionOfWidthByIdx:(CGFloat)idx count:(NSUInteger)count;



/**
 compute Stroke Start Array With DataArray

 @param dataArray NSNumber*
 @return NSMutableArray
 */
- (NSMutableArray *)computeStrokeStartArrayWithDataArray:(NSMutableArray *)dataArray;



/**
 Compute Stroke End Array

 @param dataArray NSNumber*
 @return NSMutableArray
 */
- (NSMutableArray *)computeStrokeEndArrayWithDataArray:(NSMutableArray *)dataArray;



/**
 find Percentage Of Angle In Circle

 @param center Circle center
 @param reference From Point
 @return 0.xxx
 */
- (CGFloat) findPercentageOfAngleInCircle:(CGPoint)center fromPoint:(CGPoint)reference;
@end
