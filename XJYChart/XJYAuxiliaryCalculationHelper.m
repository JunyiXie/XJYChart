//
//  XJYAuxiliaryCalculationHelper.m
//  RecordLife
//
//  Created by 谢俊逸 on 18/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYAuxiliaryCalculationHelper.h"

@implementation XJYAuxiliaryCalculationHelper


+ (instancetype)shareCalculationHelper {
    static XJYAuxiliaryCalculationHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[XJYAuxiliaryCalculationHelper alloc] init];
    });
    return helper;
}

- (CGFloat)calculateTheProportionOfHeightByTop:(CGFloat)top bottom:(CGFloat)bottom height:(CGFloat)height {
    NSCAssert((top >= height) && (height >= bottom), @"The data must meet the following conditions “bottom < height < top “");
    return fabs((height - bottom)/(top - bottom));
}

- (CGFloat)calculateTheProportionOfWidthByIdx:(CGFloat)idx count:(NSUInteger)count {
    NSCAssert((idx >= 0) && (idx < count),@"idx > 0 && idx < count");
    return (idx*2+1)/(count*2);
}

//Compute Stroke Start Array
- (NSMutableArray *)computeStrokeStartArrayWithDataArray:(NSMutableArray *)dataArray {
    NSMutableArray *startArray = [[NSMutableArray alloc] init];
    
    //计算总count
    __block CGFloat count = 0;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        count = count + number.doubleValue;
    }];
    //计算start比例
    __block CGFloat priorCount = 0;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        NSNumber *start = @(priorCount/count);
        priorCount = priorCount + number.doubleValue;
        //添加到数组中
        [startArray addObject:start];
    }];
    return startArray;
}

//Compute Stroke End Array
- (NSMutableArray *)computeStrokeEndArrayWithDataArray:(NSMutableArray *)dataArray {
    NSMutableArray *endArray = [[NSMutableArray alloc] init];
    
    //计算总count
    __block CGFloat count = 0;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        count = count + number.doubleValue;
    }];
    //计算end比例
    __block CGFloat nowCount = 0;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        nowCount = nowCount + number.doubleValue;
        NSNumber *start = @(nowCount/count);
        //添加到数组中
        [endArray addObject:start];
    }];
    return endArray;
}


//find Percentage Of Angle In Circle
- (CGFloat) findPercentageOfAngleInCircle:(CGPoint)center fromPoint:(CGPoint)reference{
    //Find angle of line Passing In Reference And Center
    CGFloat angleOfLine = atanf((reference.y - center.y) / (reference.x - center.x));
    CGFloat percentage = (angleOfLine + M_PI/2)/(2 * M_PI);
    return (reference.x - center.x) > 0 ? percentage : percentage + .5;
}


@end
