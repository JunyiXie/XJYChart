//
//  XAreaLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 09/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAreaLineContainerView.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XJYColor.h"
#import "CAShapeLayer+frameCategory.h"
#import "XXAnimationLabel.h"
#import "XJYAnimation.h"

#pragma mark - Macro

#define LineWidth 6.0
#define PointDiameter 13.0

@interface XAreaLineContainerView ()

@property (nonatomic, strong) CABasicAnimation *pathAnimation;



@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *shapeLayerArray;
@property (nonatomic, strong) CAShapeLayer *coverLayer;
@property (nonatomic, strong) NSMutableArray<XXAnimationLabel *> *labelArray;
/**
 All lines points
 */
@property (nonatomic, strong) NSMutableArray<NSValue *> *points;

@end


@implementation XAreaLineContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.coverLayer = [CAShapeLayer layer];
        self.shapeLayerArray = [NSMutableArray new];
        self.points = [NSMutableArray new];
        self.labelArray = [NSMutableArray new];
        
        self.dataItemArray = dataItemArray;
        self.top  = topNumber;
        self.bottom = bottomNumber;
        self.lineMode = BrokenLine;
        self.colorMode = Random;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.points = [self getPoints];
    
    CGPoint leftConerPoint = CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    CGPoint rightConerPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
    
    CAShapeLayer *lineLayer = [self getLineShapeLayerWithPoints:self.points leftConerPoint:leftConerPoint rightConerPoint:rightConerPoint];
    [self.layer addSublayer:lineLayer];
}

- (NSMutableArray<NSValue *> *)getPoints {

    NSMutableArray *linePointArray = [NSMutableArray new];
    XXLineChartItem *item = self.dataItemArray[0];
    
    // Get Points
    NSMutableArray *numberArray = item.numberArray;
    [item.numberArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = [self calculatePointWithNumber:obj idx:idx numberArray:numberArray bounds:self.bounds];
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        [linePointArray addObject:pointValue];
    }];
    
    return linePointArray;
    
}

- (CAShapeLayer *)getLineShapeLayerWithPoints:(NSArray<NSValue *> *)points leftConerPoint:(CGPoint)leftConerPoint rightConerPoint:(CGPoint)rightConerPoint {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *line = [[UIBezierPath alloc] init];
    
    // curve
    for(int i = 0; i < points.count - 1; i++) {
        CGPoint point1 = points[i].CGPointValue;
        CGPoint point2 = points[i + 1].CGPointValue;
        if (i == 0) {
            [line moveToPoint:point1];
        }
        
        if (self.lineMode == CurveLine) {
            CGPoint midPoint = [XAreaLineContainerView midPointBetweenPoint1:point1 andPoint2:point2];
            [line addQuadCurveToPoint:midPoint controlPoint:[XAreaLineContainerView controlPointBetweenPoint1:point1 andPoint2:midPoint]];
            [line addQuadCurveToPoint:point2 controlPoint:[XAreaLineContainerView controlPointBetweenPoint1:midPoint andPoint2:point2]];
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
    lineLayer.fillColor = XJYGreen.CGColor;
    lineLayer.lineWidth = 3;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    
    return lineLayer;
}


+ (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    CGPoint controlPoint = [self midPointBetweenPoint1:point1 andPoint2:point2];
    CGFloat diffY = abs((int) (point2.y - controlPoint.y));
    if (point1.y < point2.y)
        controlPoint.y += diffY;
    else if (point1.y > point2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}

#pragma mark 抽取数据提取

#pragma mark HelpMethods
// Calculate -> Point
- (CGPoint)calculatePointWithNumber:(NSNumber *)number idx:(NSUInteger)idx numberArray:(NSMutableArray *)numberArray bounds:(CGRect)bounds {
    CGFloat percentageH =[[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:number.doubleValue];
    CGFloat percentageW = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:(idx) count:numberArray.count];
    CGFloat pointY = percentageH * bounds.size.height;
    CGFloat pointX = percentageW * bounds.size.width;
    
    CGPoint point = CGPointMake(pointX, pointY);
    return point;
}

@end
