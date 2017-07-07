//
//  XAreaLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 09/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAreaLineContainerView.h"
#import "XAuxiliaryCalculationHelper.h"
#import "XColor.h"
#import "CAShapeLayer+frameCategory.h"
#import "XAnimationLabel.h"
#import "XAnimation.h"
#import "XAnimator.h"
#pragma mark - Macro

#define LineWidth 6.0
#define PointDiameter 11.0

#define mark - XGraphAnimationNode
@interface XGraphAnimationNode : NSObject

@property (nonatomic, assign) CGPoint graphAnimationEndPoint;
@property (nonatomic, assign) CGPoint graphAnimationStartPoint;
@property (nonatomic, assign) CGPoint graphAnimationCurrentPoint;
- (instancetype)initWithAnimationEndPoint:(CGPoint)endPoint;
- (CGFloat)getAnimationNodeX;
- (CGFloat)getAnimationNodeEndY;
- (CGFloat)getAnimationNodeCurrentY;
@end

@implementation XGraphAnimationNode

- (instancetype)initWithAnimationEndPoint:(CGPoint)endPoint
{
    if (self = [super init]) {
        self.graphAnimationEndPoint = endPoint;
        self.graphAnimationCurrentPoint = endPoint;
    }
    return self;
}

- (CGFloat)getAnimationNodeX
{
    return self.graphAnimationEndPoint.x;
}

- (CGFloat)getAnimationNodeEndY
{
    return self.graphAnimationEndPoint.y;
}

- (CGFloat)getAnimationNodeCurrentY
{
    return self.graphAnimationCurrentPoint.y;
}

@end

@interface XAreaAnimationManager : NSObject

@property (nonatomic, strong)
    NSMutableArray<XGraphAnimationNode*>* areaAnimationNodes;
@property (nonatomic, strong)
    NSMutableArray<XGraphAnimationNode*>* animationNodes;

@end

@implementation XAreaAnimationManager
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
- (NSMutableArray<XGraphAnimationNode*>*)animationNodes
{
    NSMutableArray* nodes = [self.areaAnimationNodes mutableCopy];
    [nodes removeObjectAtIndex:0];
    [nodes removeLastObject];
    return nodes;
}

@end

@interface XAreaLineContainerView ()

@property (nonatomic, strong) CABasicAnimation* pathAnimation;
@property (nonatomic, strong) CAShapeLayer* coverLayer;
@property (nonatomic, strong) UIColor* areaColor;

/**
 All lines points
 */
@property (nonatomic, strong) NSMutableArray<NSValue*>* drawablePoints;
@property (nonatomic, strong) NSMutableArray<XAnimationLabel*>* labelArray;
@property (nonatomic, strong)
    NSMutableArray<XGraphAnimationNode*>* areaAnimationNodes;

@property (nonatomic, strong) XAreaAnimationManager* areaAnimationManager;
@end

@implementation XAreaLineContainerView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XJYBlue;
        self.coverLayer = [CAShapeLayer layer];
        self.drawablePoints = [NSMutableArray new];
        self.labelArray = [NSMutableArray new];
        self.areaAnimationNodes = [NSMutableArray new];

        self.dataItemArray = dataItemArray;
        self.top = topNumber;
        self.bottom = bottomNumber;
        self.lineMode = BrokenLine;
        self.colorMode = Random;

        // 数据处理，集中管理
        self.areaAnimationManager = [self makeAreaAnimationManager];
    }
    return self;
}

/// 数据 ---> AreaManager
- (XAreaAnimationManager*)makeAreaAnimationManager
{
    self.drawablePoints = [self getDrawablePoints];
    self.areaAnimationNodes = [self getAreaDrawableAnimationNodes];
    XAreaAnimationManager* manager = [[XAreaAnimationManager alloc] init];
    manager.areaAnimationNodes = [self.areaAnimationNodes mutableCopy];
    return manager;
}

- (void)drawRect:(CGRect)rect
{
    [self cleanPreDrawLayerAndData];
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self strokeAuxiliaryLineInContext:context];
    [self strokePointInContext:context];
    [self strokeLine];
}
// Start Animation
- (void)startAnimation
{
    XAnimator* animator = [[XAnimator alloc] init];
    [animator AnimatorDuration:0.85
                animationBlock:^(CGFloat percentage) {
                    [self.areaAnimationManager.areaAnimationNodes
                        enumerateObjectsUsingBlock:^(
                            XGraphAnimationNode* _Nonnull node, NSUInteger idx,
                            BOOL* _Nonnull stop) {
                            node.graphAnimationCurrentPoint = CGPointMake(node.getAnimationNodeX,
                                [[XAuxiliaryCalculationHelper shareCalculationHelper] getYIncreaseInFilpCoordinateSystemWithBoundsH:self.bounds.size.height
                                                                                                          targetY: node.getAnimationNodeEndY
                                                                                                          percentage:percentage]);
                        }];
                    [self setNeedsDisplay];
                }];
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    [self startAnimation];
}

/// Stroke Auxiliary
- (void)strokeAuxiliaryLineInContext:(CGContextRef)context
{
    CGContextSetStrokeColorWithColor(
        context, [UIColor colorWithWhite:1 alpha:0.5].CGColor);
    CGFloat lengths[2] = { 5, 5 };
    CGContextSetLineDash(context, 0, lengths, 2);

    NSInteger count = self.areaAnimationManager.animationNodes.count;
    for (int i = 0; i < count; i++) {
        CGContextMoveToPoint(
            context,
            [self.areaAnimationManager.animationNodes[i] getAnimationNodeX], 0);
        CGContextAddLineToPoint(
            context,
            [self.areaAnimationManager.animationNodes[i] getAnimationNodeX],
            self.frame.size.height);
        CGContextStrokePath(context);

        CGContextMoveToPoint(
            context,
            [self.areaAnimationManager.animationNodes[i] getAnimationNodeX], 0);
        CGContextAddLineToPoint(
            context,
            [self.areaAnimationManager.animationNodes[i] getAnimationNodeX],
            self.frame.size.height);
        CGContextStrokePath(context);
    }
}

- (void)strokePointInContext:(CGContextRef)context
{
    UIColor* pointColor = [UIColor whiteColor];
    UIColor* wireframeColor = [UIColor whiteColor];
    ;

    [self.areaAnimationManager.animationNodes
        enumerateObjectsUsingBlock:^(XGraphAnimationNode* _Nonnull node,
            NSUInteger idx, BOOL* _Nonnull stop) {
            CGPoint point = node.graphAnimationCurrentPoint;
            CGContextSetFillColorWithColor(context, pointColor.CGColor); //填充颜色
            CGContextSetStrokeColorWithColor(context,
                wireframeColor.CGColor); //线框颜色
            CGContextFillEllipseInRect(context,
                CGRectMake(point.x - PointDiameter / 2,
                    point.y - PointDiameter / 2,
                    PointDiameter, PointDiameter));
        }];
}

- (void)cleanPreDrawLayerAndData
{
    [self.layer.sublayers
        enumerateObjectsUsingBlock:^(CALayer* _Nonnull sublayer, NSUInteger idx,
            BOOL* _Nonnull stop) {
            [sublayer removeFromSuperlayer];
        }];
    [self.labelArray
        enumerateObjectsUsingBlock:^(XAnimationLabel* _Nonnull obj,
            NSUInteger idx, BOOL* _Nonnull stop) {
            [obj removeFromSuperview];
        }];

    [self.labelArray removeAllObjects];
    [self.drawablePoints removeAllObjects];
    [self.areaAnimationNodes removeAllObjects];
}

- (void)strokeLine
{
    // 获取currentPoint 去绘制
    NSMutableArray* currentPointArray = [NSMutableArray new];
    [self.areaAnimationManager.areaAnimationNodes
        enumerateObjectsUsingBlock:^(XGraphAnimationNode* _Nonnull obj,
            NSUInteger idx, BOOL* _Nonnull stop) {
            [currentPointArray
                addObject:[NSValue
                              valueWithCGPoint:obj.graphAnimationCurrentPoint]];
        }];
    CGPoint leftConerPoint = CGPointMake(
        self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
    CGPoint rightConerPoint = CGPointMake(self.frame.origin.x + self.frame.size.width,
        self.frame.origin.y + self.frame.size.height);
    CAShapeLayer* lineLayer = [self getLineShapeLayerWithPoints:currentPointArray
                                                 leftConerPoint:leftConerPoint
                                                rightConerPoint:rightConerPoint];
    [self.layer addSublayer:lineLayer];
}

#pragma mark data Handling
- (NSMutableArray<XGraphAnimationNode*>*)getAreaDrawableAnimationNodes
{
    self.drawablePoints = [self getDrawablePoints];

    // Make Close Points
    CGPoint temfirstPoint = self.drawablePoints[0].CGPointValue;
    CGPoint temlastPoint = self.drawablePoints.lastObject.CGPointValue;
    CGPoint firstPoint = CGPointMake(0, temfirstPoint.y);
    CGPoint lastPoint = CGPointMake(self.frame.size.width, temlastPoint.y);

    // AreaDrawablePoints
    self.areaAnimationNodes = [NSMutableArray new];
    [self.drawablePoints
        enumerateObjectsUsingBlock:^(NSValue* _Nonnull pointValue, NSUInteger idx,
            BOOL* _Nonnull stop) {
            [self.areaAnimationNodes
                addObject:[[XGraphAnimationNode alloc]
                              initWithAnimationEndPoint:pointValue.CGPointValue]];
        }];
    [self.areaAnimationNodes
        insertObject:[[XGraphAnimationNode alloc]
                         initWithAnimationEndPoint:firstPoint]
             atIndex:0];
    [self.areaAnimationNodes addObject:[[XGraphAnimationNode alloc]
                                           initWithAnimationEndPoint:lastPoint]];

    return self.areaAnimationNodes;
}

- (NSMutableArray<NSValue*>*)getDrawablePoints
{
    NSMutableArray* linePointArray = [NSMutableArray new];
    XLineChartItem* item = self.dataItemArray[0];

    // Get Points
    NSMutableArray* numberArray = item.numberArray;
    [item.numberArray
        enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj, NSUInteger idx,
            BOOL* _Nonnull stop) {
            CGPoint point = [self calculateDrawablePointWithNumber:obj
                                                               idx:idx
                                                       numberArray:numberArray
                                                            bounds:self.bounds];
            //坐标系反转
            NSValue* pointValue = [NSValue valueWithCGPoint:point];
            [linePointArray addObject:pointValue];
        }];
    return linePointArray;
}

- (UIColor*)getFillColor
{
    if (self.colorMode == Custom) {
        self.areaColor = self.dataItemArray[0].color;
    } else {
        self.areaColor = XJYWhite;
    }
    return self.areaColor;
}

#pragma mark ShapeLayerDrawer

- (CAShapeLayer*)getLineShapeLayerWithPoints:(NSArray<NSValue*>*)points
                              leftConerPoint:(CGPoint)leftConerPoint
                             rightConerPoint:(CGPoint)rightConerPoint
{
    CAShapeLayer* lineLayer = [CAShapeLayer layer];
    UIBezierPath* line = [[UIBezierPath alloc] init];

    // line
    for (int i = 0; i < points.count - 1; i++) {
        CGPoint point1 = points[i].CGPointValue;
        CGPoint point2 = points[i + 1].CGPointValue;
        if (i == 0) {
            [line moveToPoint:point1];
        }
        if (self.lineMode == CurveLine) {
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
    }
    // closePoint
    [line addLineToPoint:rightConerPoint];
    [line addLineToPoint:leftConerPoint];
    [line addLineToPoint:points[0].CGPointValue];
    lineLayer.path = line.CGPath;
    lineLayer.strokeColor = [UIColor clearColor].CGColor;
    lineLayer.fillColor = [self getFillColor].CGColor;
    lineLayer.opacity = 0.3;
    lineLayer.lineWidth = 4;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    return lineLayer;
}

#pragma mark - Control Point Compute

#pragma mark - Help Methods
// Calculate -> Point
- (CGPoint)calculateDrawablePointWithNumber:(NSNumber*)number
                                        idx:(NSUInteger)idx
                                numberArray:(NSMutableArray*)numberArray
                                     bounds:(CGRect)bounds
{
    CGFloat percentageH = [[XAuxiliaryCalculationHelper shareCalculationHelper]
        calculateTheProportionOfHeightByTop:self.top.doubleValue
                                     bottom:self.bottom.doubleValue
                                     height:number.doubleValue];
    CGFloat percentageW = [[XAuxiliaryCalculationHelper shareCalculationHelper]
        calculateTheProportionOfWidthByIdx:(idx)
                                     count:numberArray.count];
    CGFloat pointY = percentageH * bounds.size.height;
    CGFloat pointX = percentageW * bounds.size.width;
    CGPoint point = CGPointMake(pointX, pointY);
    CGPoint rightCoordinatePoint =
        [[XAuxiliaryCalculationHelper shareCalculationHelper]
            changeCoordinateSystem:point
                    withViewHeight:self.frame.size.height];
    return rightCoordinatePoint;
}

@end
