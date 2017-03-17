//
//  XLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XLineContainerView.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XJYColor.h"
@interface XLineContainerView()

//二维数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *pointsArrays;


@end

@implementation XLineContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataItemArray = dataItemArray;
        self.top  = topNumber;
        self.bottom = bottomNumber;
        self.pointsArrays = [NSMutableArray new];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //绘制表格的辅助线
    CGContextRef ContextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ContextRef, [UIColor lightGrayColor].CGColor);
    
    //水平辅助线
    for (int i =0 ; i<12; i++) {
        if (i!=0||i!=11) {
            //            CGContextSetLineWidth(ContextRef, 1);
        }
        //线的宽度
        //        CGContextSetLineWidth(ContextRef, 1);
        
        CGContextMoveToPoint(ContextRef, 0,(self.frame.size.height)/11 * i);
        CGContextAddLineToPoint(ContextRef,self.frame.size.width,((self.frame.size.height)/11) * i);
        CGContextStrokePath(ContextRef);
    }
    
    
    [self.dataItemArray enumerateObjectsUsingBlock:^(XXLineChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *numberArray = obj.numberArray;
        NSMutableArray *linePointArray = [NSMutableArray new];
        [obj.numberArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [self calculatePointWithNumber:obj idx:idx numberArray:numberArray bounds:self.bounds];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [linePointArray addObject:pointValue];
        }];
        [self.pointsArrays addObject:linePointArray];
    }];
    
    
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *linePointArray = obj;
        //线的颜色
        UIColor *lineColor = [[XJYColor shareXJYColor] randomColorInColorArray];

        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;
            NSValue *priorPointValue = [[NSValue alloc] init];
            if (idx == 0) {
                //这地方的处理 识情况而定
                priorPointValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
            } else {
                priorPointValue = linePointArray[idx - 1];
                
                CGPoint priorPoint = priorPointValue.CGPointValue;
                CGContextSetStrokeColorWithColor(ContextRef, lineColor.CGColor);
                CGContextSetLineWidth(ContextRef, 1.6f);
                CGContextSetLineDash(ContextRef, 0, 0, 0);
                CGContextMoveToPoint(ContextRef, priorPoint.x,self.bounds.size.height -  priorPoint.y);
                CGContextAddLineToPoint(ContextRef, point.x,self.bounds.size.height -  point.y);
                CGContextStrokePath(ContextRef);
            }
        }];
    }];
    
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIColor *pointColor = [[XJYColor shareXJYColor] randomColorInColorArray];
        UIColor *wireframeColor = [[XJYColor shareXJYColor] randomColorInColorArray];
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //画点
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;
            
            CGContextSetFillColorWithColor(ContextRef, pointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, wireframeColor.CGColor);//线框颜色
            CGContextFillEllipseInRect(ContextRef, CGRectMake(point.x - 1.5, self.bounds.size.height - point.y - 1.5, 3.0, 3.0));
        }];
    }];
    
}


#pragma mark Get

#pragma mark Helper

/**
 计算点通过 数值 和 idx
 
 @param number number
 @param idx like 0.1.2.3...
 @return CGPoint
 */
- (CGPoint)calculatePointWithNumber:(NSNumber *)number idx:(NSUInteger)idx numberArray:(NSMutableArray *)numberArray bounds:(CGRect)bounds {
    CGFloat percentageH =[[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:number.doubleValue];
    CGFloat percentageW = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:(idx) count:numberArray.count];
    CGFloat pointY = percentageH * bounds.size.height;
    CGFloat pointX = percentageW * bounds.size.width;
    
    CGPoint point = CGPointMake(pointX, pointY);
    return point;
}

@end
