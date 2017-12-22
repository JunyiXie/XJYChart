//
//  XPositiveNegativeBarContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/04/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XPositiveNegativeBarContainerView.h"
#import "XBarContainerView.h"
#import "XAuxiliaryCalculationHelper.h"
#import "XAbscissaView.h"
#import "XColor.h"
#import "XAnimationLabel.h"
#import "XAnimation.h"
#import "XNotificationBridge.h"
#import "CALayer+XLayerSelectHelper.h"

#define GradientFillColor1          \
  [UIColor colorWithRed:117 / 255.0 \
                  green:184 / 255.0 \
                   blue:245 / 255.0 \
                  alpha:1]          \
      .CGColor
#define GradientFillColor2                                                     \
  [UIColor colorWithRed:24 / 255.0 green:141 / 255.0 blue:240 / 255.0 alpha:1] \
      .CGColor
#define BarBackgroundFillColor \
  [UIColor colorWithRed:232 / 255.0 green:232 / 255.0 blue:232 / 255.0 alpha:1]

#define animationDuration 3

typedef enum : NSUInteger {
  Positive,
  Negative,
} Valuence;

@interface XPositiveNegativeBarContainerView ()

@property(nonatomic, strong) CABasicAnimation* pathAnimation;
@property(nonatomic, strong) CALayer* coverLayer;
@property(nonatomic, strong) NSMutableArray<UIColor*>* colorArray;
@property(nonatomic, strong) NSMutableArray<NSString*>* dataDescribeArray;
@property(nonatomic, strong) NSMutableArray<NSNumber*>* dataNumberArray;
//值填充
@property(nonatomic, strong) NSMutableArray<CALayer*>* layerArray;
//背景填充
@property(nonatomic, strong) NSMutableArray<CALayer*>* fillLayerArray;

@end

@implementation XPositiveNegativeBarContainerView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XBarItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
    self.coverLayer = [CALayer layer];

    self.layerArray = [[NSMutableArray alloc] init];
    self.fillLayerArray = [[NSMutableArray alloc] init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.dataNumberArray = [[NSMutableArray alloc] init];
    self.dataDescribeArray = [[NSMutableArray alloc] init];

    self.dataItemArray = dataItemArray;
    self.top = topNumbser;
    self.bottom = bottomNumber;
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  [self cleanPreDrawAndData];
  [self strokeChart];
}

- (void)cleanPreDrawAndData {
  // remove layer
  [self.coverLayer removeFromSuperlayer];
  [self.layerArray
      enumerateObjectsUsingBlock:^(CALayer* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [obj removeFromSuperlayer];
      }];
  [self.fillLayerArray
      enumerateObjectsUsingBlock:^(CALayer* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [obj removeFromSuperlayer];
      }];

  // clean array
  [self.layerArray removeAllObjects];
  [self.fillLayerArray removeAllObjects];
  [self.colorArray removeAllObjects];
  [self.dataNumberArray removeAllObjects];
  [self.dataDescribeArray removeAllObjects];
}

- (void)strokeChart {
  //从BarItem 中提取各类数据
  //防止多次调用 必须清理数据
  [self.colorArray removeAllObjects];
  [self.dataNumberArray removeAllObjects];
  [self.dataDescribeArray removeAllObjects];

  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XBarItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [self.colorArray addObject:obj.color];
        [self.dataNumberArray addObject:obj.dataNumber];
        [self.dataDescribeArray addObject:obj.dataDescribe];
      }];

  //绘制bar
  CGFloat width = (self.bounds.size.width / self.dataItemArray.count) / 3 * 2;
  //每个条的x坐标
  NSMutableArray<NSNumber*>* xArray = [[NSMutableArray alloc] init];
  [self.dataItemArray
      enumerateObjectsUsingBlock:^(XBarItem* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        CGFloat x =
            self.bounds.size.width *
            [[XAuxiliaryCalculationHelper shareCalculationHelper]
                calculateTheProportionOfWidthByIdx:idx
                                             count:self.dataItemArray.count];
        [xArray addObject:@(x)];
      }];

  //每个背景条的rect
  NSMutableArray<NSValue*>* rectArray = [[NSMutableArray alloc] init];
  [xArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                       BOOL* _Nonnull stop) {
    //每个背景条的高度
    CGFloat height = self.bounds.size.height;
    NSNumber* number = obj;
    CGRect rect = CGRectMake(number.doubleValue - width / 2, 0, width, height);
    [rectArray addObject:[NSValue valueWithCGRect:rect]];
  }];

  //根据rect 绘制背景条
  [rectArray enumerateObjectsUsingBlock:^(NSValue* _Nonnull obj, NSUInteger idx,
                                          BOOL* _Nonnull stop) {
    CGRect rect = obj.CGRectValue;
    CAShapeLayer* rectShapeLayer =
        [self rectShapeLayerWithBounds:rect fillColor:BarBackgroundFillColor];
    [self.fillLayerArray addObject:rectShapeLayer];
    [self.layer addSublayer:rectShapeLayer];
  }];

  // fillHeightArray 是高度的绝对值
  //每个条根据数值大小填充的高度
  NSMutableArray<NSNumber*>* fillHeightArray = [[NSMutableArray alloc] init];
  [self.dataItemArray enumerateObjectsUsingBlock:^(XBarItem* _Nonnull obj,
                                                   NSUInteger idx,
                                                   BOOL* _Nonnull stop) {
    // 正负判断
    if (self.dataNumberArray[idx].doubleValue >= 0) {
      CGFloat topH = self.top.doubleValue * (self.bounds.size.height) /
                     (self.top.doubleValue - self.bottom.doubleValue);
      CGFloat height = fabs(
          [[XAuxiliaryCalculationHelper shareCalculationHelper]
              calculateThePositiveNegativeProportionOfHeightByTop:
                  self.top.doubleValue
                                                           bottom:
                                                               self.bottom
                                                                   .doubleValue
                                                           height:
                                                               self
                                                                   .dataNumberArray
                                                                       [idx]
                                                                   .doubleValue] *
          topH);
      [fillHeightArray addObject:@(height)];
    } else {
      CGFloat bottomH = self.bottom.doubleValue * (self.bounds.size.height) /
                        (self.top.doubleValue - self.bottom.doubleValue);
      CGFloat height = fabs(
          [[XAuxiliaryCalculationHelper shareCalculationHelper]
              calculateThePositiveNegativeProportionOfHeightByTop:
                  self.top.doubleValue
                                                           bottom:
                                                               self.bottom
                                                                   .doubleValue
                                                           height:
                                                               self
                                                                   .dataNumberArray
                                                                       [idx]
                                                                   .doubleValue] *
          bottomH);
      [fillHeightArray addObject:@(height)];
    }
  }];
  //计算填充的矩形
  NSMutableArray<NSValue*>* fillRectArray = [[NSMutableArray alloc] init];
  [xArray enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj, NSUInteger idx,
                                       BOOL* _Nonnull stop) {
    // height - fillHeightArray[idx].doubleValue 计算起始Y...
    CGRect fillRect;
    // 正负判断,高度是否大于0
    if (self.dataNumberArray[idx].doubleValue >= 0) {
      CGFloat y = (self.top.doubleValue /
                   (self.top.doubleValue - self.bottom.doubleValue)) *
                  self.bounds.size.height;
      fillRect = CGRectMake(obj.doubleValue - width / 2,
                            y - fillHeightArray[idx].doubleValue, width,
                            fillHeightArray[idx].doubleValue);
    } else {
      CGFloat y = (self.top.doubleValue /
                   (self.top.doubleValue - self.bottom.doubleValue)) *
                  self.bounds.size.height;
      fillRect = CGRectMake(obj.doubleValue - width / 2, y, width,
                            fillHeightArray[idx].doubleValue);
    }
    [fillRectArray addObject:[NSValue valueWithCGRect:fillRect]];
  }];

  //根据fillrect 绘制填充的fillrect 与 topLabel
  NSMutableArray* fillShapeLayerArray = [[NSMutableArray alloc] init];

  [fillRectArray enumerateObjectsUsingBlock:^(NSValue* _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL* _Nonnull stop) {
    CGRect fillRect = obj.CGRectValue;

    CAShapeLayer* fillRectShapeLayer;

    if (self.dataNumberArray[idx].doubleValue >= 0) {
      fillRectShapeLayer =
          [self rectAnimationLayerWithBounds:fillRect
                                   fillColor:self.dataItemArray[idx].color
                                    Valuence:Positive];
    } else {
      fillRectShapeLayer =
          [self rectAnimationLayerWithBounds:fillRect
                                   fillColor:self.dataItemArray[idx].color
                                    Valuence:Negative];
    }

    CGPoint tempCenter;
    XAnimationLabel* topLabel;

    if (self.dataNumberArray[idx].doubleValue >= 0) {
      topLabel = [self
          topLabelWithRect:CGRectMake(fillRect.origin.x, fillRect.origin.y - 15,
                                      fillRect.size.width, 15)
                 fillColor:[UIColor clearColor]
                      text:self.dataNumberArray[idx].stringValue];
      [self addSubview:topLabel];
      tempCenter = topLabel.center;
      topLabel.center = CGPointMake(topLabel.center.x,
                                    topLabel.center.y + fillRect.size.height);
    } else {
      topLabel = [self
          topLabelWithRect:CGRectMake(fillRect.origin.x,
                                      fillRect.origin.y + fillRect.size.height,
                                      fillRect.size.width, 15)
                 fillColor:[UIColor clearColor]
                      text:self.dataNumberArray[idx].stringValue];
      [self addSubview:topLabel];
      tempCenter = topLabel.center;
      topLabel.center = CGPointMake(topLabel.center.x,
                                    topLabel.center.y - fillRect.size.height);
    }

    [topLabel countFromCurrentTo:topLabel.text.floatValue
                        duration:animationDuration];
    topLabel.center = tempCenter;

    [self.layer addSublayer:fillRectShapeLayer];
    //将绘制的Layer保存
    [self.layerArray addObject:fillRectShapeLayer];

    [fillShapeLayerArray addObject:fillRectShapeLayer];
  }];

  // 绘制正负分割线
  CGFloat y;
  y = self.top.doubleValue /
      (self.top.doubleValue + fabs(self.bottom.doubleValue)) *
      self.frame.size.height;
  CGContextRef contentRef = UIGraphicsGetCurrentContext();
  CGContextSetStrokeColorWithColor(contentRef, XJYRed.CGColor);
  CGContextSetLineWidth(contentRef, 1.0);
  CGContextMoveToPoint(contentRef, 0, y);
  CGContextAddLineToPoint(contentRef, self.frame.size.width, y);
  CGContextStrokePath(contentRef);
}

#pragma mark HelpMethods

- (CAShapeLayer*)rectAnimationLayerWithBounds:(CGRect)rect
                                    fillColor:(UIColor*)fillColor {
  CGPoint startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2,
                                   (rect.origin.y + rect.size.height));
  CGPoint endPoint =
      CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));

  CAShapeLayer* chartLine = [CAShapeLayer layer];
  chartLine.lineCap = kCALineCapSquare;
  chartLine.lineJoin = kCALineJoinRound;
  chartLine.lineWidth = rect.size.width;

  //显示的线
  CGPoint temStartPoint =
      CGPointMake(startPoint.x, startPoint.y + rect.size.width / 2);
  CGPoint temEndPoint =
      CGPointMake(endPoint.x, endPoint.y + rect.size.width / 2);
  UIBezierPath* temPath = [[UIBezierPath alloc] init];
  [temPath moveToPoint:temStartPoint];
  [temPath addLineToPoint:temEndPoint];
  //动画的path
  chartLine.path = temPath.CGPath;
  chartLine.strokeStart = 0.0;
  chartLine.strokeEnd = 1.0;
  chartLine.strokeColor = fillColor.CGColor;
  [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
  //由于CAShapeLayer.frame = (0,0,0,0) 所以用这个判断点击
  chartLine.frameValue = [NSValue valueWithCGRect:rect];

  chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
  return chartLine;
}

- (CAShapeLayer*)rectAnimationLayerWithBounds:(CGRect)rect
                                    fillColor:(UIColor*)fillColor
                                     Valuence:(Valuence)valyence {
  CGPoint startPoint;
  CGPoint endPoint;
  CGPoint temStartPoint;
  CGPoint temEndPoint;
  BOOL canAnimation = YES;
  if (valyence == Positive) {
    //矩形中一条线path
    startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2,
                             (rect.origin.y + rect.size.height));
    endPoint =
        CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));

    // 做不做动画
    // 由于利用starpoint endpoint 要考虑线宽
    if (rect.size.width / 2 > rect.size.height / 2) {
      //不做动画
      temStartPoint = CGPointMake(startPoint.x, startPoint.y);
      temEndPoint = CGPointMake(endPoint.x, endPoint.y);
      canAnimation = NO;
    } else {
      //动画path
      temStartPoint =
          CGPointMake(startPoint.x, startPoint.y - rect.size.width / 2);
      temEndPoint = CGPointMake(endPoint.x, endPoint.y + rect.size.width / 2);
    }

  } else {
    //动画的path
    startPoint =
        CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));
    endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2,
                           (rect.origin.y + rect.size.height));
    // 做不做动画
    // 由于利用starpoint endpoint 要考虑线宽
    if (rect.size.width / 2 > rect.size.height / 2) {
      temStartPoint = CGPointMake(startPoint.x, startPoint.y);
      temEndPoint = CGPointMake(endPoint.x, endPoint.y);
      canAnimation = NO;
    } else {
      temStartPoint =
          CGPointMake(startPoint.x, startPoint.y + rect.size.width / 2);
      temEndPoint = CGPointMake(endPoint.x, endPoint.y - rect.size.width / 2);
    }
  }

  //临时调试 以后添加动画
  canAnimation = NO;
  // 做动画 line+strokeStartEnd
  // 不做 shapelayer
  if (canAnimation) {
    CAShapeLayer* chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapSquare;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = rect.size.width;

    //显示的线
    UIBezierPath* temPath = [[UIBezierPath alloc] init];
    [temPath moveToPoint:temStartPoint];
    [temPath addLineToPoint:temEndPoint];

    chartLine.path = temPath.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = fillColor.CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    //由于CAShapeLayer.frame = (0,0,0,0) 所以用这个判断点击
    chartLine.frameValue = [NSValue valueWithCGRect:rect];
    chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
    return chartLine;
  } else {
    CAShapeLayer* noAnimationLayer =
        [self rectShapeLayerWithBounds:rect fillColor:fillColor];
    noAnimationLayer.frameValue = [NSValue valueWithCGRect:rect];
    noAnimationLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
    return noAnimationLayer;
  }
}

- (CAShapeLayer*)rectShapeLayerWithBounds:(CGRect)rect
                                fillColor:(UIColor*)fillColor {
  //正常的
  UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
  CAShapeLayer* rectLayer = [CAShapeLayer layer];
  rectLayer.path = path.CGPath;
  rectLayer.fillColor = fillColor.CGColor;
  rectLayer.path = path.CGPath;
  rectLayer.frameValue = [NSValue valueWithCGRect:rect];

  return rectLayer;
}

- (XAnimationLabel*)topLabelWithRect:(CGRect)rect
                           fillColor:(UIColor*)color
                                text:(NSString*)text {
  CGFloat number = text.floatValue;
  NSString* labelText = [NSString stringWithFormat:@"%.0f", number];
  XAnimationLabel* topLabel = [[XAnimationLabel alloc] initWithFrame:rect];
  topLabel.backgroundColor = color;
  [topLabel setTextAlignment:NSTextAlignmentCenter];
  topLabel.text = labelText;
  [topLabel setFont:[UIFont systemFontOfSize:10]];
  [topLabel setTextColor:[UIColor black50PercentColor]];
  return topLabel;
}

- (CAGradientLayer*)rectGradientLayerWithBounds:(CGRect)rect {
  //颜色渐变层
  CAGradientLayer* gradientLayer = [CAGradientLayer layer];
  gradientLayer.frame = rect;
  gradientLayer.colors =
      @[ (__bridge id)GradientFillColor1, (__bridge id)GradientFillColor2 ];

  gradientLayer.startPoint = CGPointMake(0.5, 0);
  gradientLayer.endPoint = CGPointMake(0.5, 1);
  return gradientLayer;
}

- (CABasicAnimation*)pathAnimation {
  _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  _pathAnimation.duration = animationDuration;
  _pathAnimation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  _pathAnimation.fromValue = @0.0f;
  _pathAnimation.toValue = @1.0f;
  return _pathAnimation;
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  CGPoint __block point = [[touches anyObject] locationInView:self];

  //点击整个柱子
  [self.fillLayerArray enumerateObjectsUsingBlock:^(CALayer* _Nonnull obj,
                                                    NSUInteger idx,
                                                    BOOL* _Nonnull stop) {
    CAShapeLayer* shapeLayer = (CAShapeLayer*)obj;
    CGRect layerFrame = shapeLayer.frameValue.CGRectValue;

    if (CGRectContainsPoint(layerFrame, point)) {
      //上一次点击的layer,清空上一次的状态
      CAShapeLayer* preShapeLayer =
          (CAShapeLayer*)
              self.layerArray[self.coverLayer.selectIdxNumber.intValue];
      preShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
      [self.coverLayer removeFromSuperlayer];

      //得到对应 填充高度frame
      CAShapeLayer* subShapeLayer = (CAShapeLayer*)self.layerArray[idx];
      //如果已经高亮了
      if (subShapeLayer.selectStatusNumber.boolValue == YES) {
        subShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
        [self.coverLayer removeFromSuperlayer];
        return;
      }

      BOOL boolValue = subShapeLayer.selectStatusNumber.boolValue;
      subShapeLayer.selectStatusNumber = [NSNumber numberWithBool:!boolValue];
      self.coverLayer = [self
          rectGradientLayerWithBounds:subShapeLayer.frameValue.CGRectValue];
      self.coverLayer.selectIdxNumber = @(idx);

      [subShapeLayer addSublayer:self.coverLayer];

      // Notification + Deleagte To CallBack
      [[NSNotificationCenter defaultCenter]
          postNotificationName:[XNotificationBridge shareXNotificationBridge]
                                   .TouchPNBarNotification
                        object:nil
                      userInfo:
                          @{
                                [XNotificationBridge shareXNotificationBridge].
                                PNBarIdxNumberKey : @(idx)
                          }];

      return;
    }
  }];
}


@end
