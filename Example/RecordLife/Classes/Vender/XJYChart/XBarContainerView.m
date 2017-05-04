//
//  XBarContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XBarContainerView.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "AbscissaView.h"
#import "XJYColor.h"
#import "CAShapeLayer+frameCategory.h"
#import "XXAnimationLabel.h"
#import "CALayer+XXLayer.h"

#import "XJYNotificationBridge.h"

#define GradientFillColor1 [UIColor colorWithRed:117/255.0 green:184/255.0 blue:245/255.0 alpha:1].CGColor
#define GradientFillColor2 [UIColor colorWithRed:24/255.0 green:141/255.0 blue:240/255.0 alpha:1].CGColor
#define BarBackgroundFillColor [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]

#define animationDuration 3



@interface XBarContainerView ()
@property (nonatomic, strong) CABasicAnimation *pathAnimation;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;
@property (nonatomic, strong) NSMutableArray<CALayer *> *layerArray;//value layer
@property (nonatomic, strong) NSMutableArray<CALayer *> *fillLayerArray;//background layer
@property (nonatomic, strong) CALayer *coverLayer;
@end

@implementation XBarContainerView

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber  {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layerArray = [[NSMutableArray alloc] init];
        self.fillLayerArray = [[NSMutableArray alloc] init];
        self.dataItemArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataItemArray = dataItemArray;
        self.top = topNumbser;
        self.bottom = bottomNumber;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self strokeChart];
}

- (void)strokeChart {
    //To prevent multiple calls ,must clean up the data
    [self.colorArray removeAllObjects];
    [self.dataNumberArray removeAllObjects];
    [self.dataDescribeArray removeAllObjects];
    // data filter
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.colorArray addObject:obj.color];
        [self.dataNumberArray addObject:obj.dataNumber];
        [self.dataDescribeArray addObject:obj.dataDescribe];
    }];
    
    CGFloat width = (self.bounds.size.width / self.dataItemArray.count) / 3 * 2;
    CGFloat height = self.bounds.size.height;
    
    // x coordinates
    NSMutableArray<NSNumber *> *xArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = self.bounds.size.width * [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:idx count:self.dataItemArray.count];
        [xArray addObject:@(x)];
    }];
    
    NSMutableArray<NSValue *> *rectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        CGRect rect = CGRectMake(number.doubleValue - width/2, 0, width, height);
        [rectArray addObject:[NSValue valueWithCGRect:rect]];
    }];
    
    //background layer
    [rectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = obj.CGRectValue;
        CAShapeLayer *rectShapeLayer = [self rectShapeLayerWithBounds:rect fillColor:BarBackgroundFillColor];
        [self.fillLayerArray addObject:rectShapeLayer];
        [self.layer addSublayer:rectShapeLayer];
    }];
    
    //fill layer
    NSMutableArray<NSNumber *> *fillHeightArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:self.dataNumberArray[idx].doubleValue] * self.bounds.size.height;
        [fillHeightArray addObject:@(height)];
    }];
    
    NSMutableArray<NSValue *> *fillRectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //height - fillHeightArray[idx].doubleValue 计算起始Y
        CGRect fillRect = CGRectMake(obj.doubleValue - width/2,height - fillHeightArray[idx].doubleValue , width, fillHeightArray[idx].doubleValue);
        [fillRectArray addObject:[NSValue valueWithCGRect:fillRect]];
    }];
    
    //fill layer
    NSMutableArray *fillShapeLayerArray = [[NSMutableArray alloc] init];
    [fillRectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect fillRect = obj.CGRectValue;
        CAShapeLayer *fillRectShapeLayer = [self rectAnimationLayerWithBounds:fillRect fillColor:self.dataItemArray[idx].color];
        // animation number labei
        XXAnimationLabel *topLabel = [self topLabelWithRect:CGRectMake(fillRect.origin.x, fillRect.origin.y - 15, fillRect.size.width, 15) fillColor:[UIColor clearColor] text:self.dataNumberArray[idx].stringValue];
        [self addSubview:topLabel];
        CGPoint tempCenter = topLabel.center;
        topLabel.center = CGPointMake(topLabel.center.x, topLabel.center.y + fillRect.size.height );
        [topLabel countFromCurrentTo:topLabel.text.floatValue duration:animationDuration];
        [UIView animateWithDuration:animationDuration animations:^{
            topLabel.center = tempCenter;
        }];
        [self.layer addSublayer:fillRectShapeLayer];
        [self.layerArray addObject:fillRectShapeLayer];
        [fillShapeLayerArray addObject:fillRectShapeLayer];
    }];
    
}


#pragma mark Get



#pragma mark HelpMethods

- (CAShapeLayer *)rectAnimationLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    //动画的path
    CGPoint startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y + rect.size.height));
    CGPoint endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapSquare;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = rect.size.width;
    
    //显示的线
    CGPoint temStartPoint = CGPointMake(startPoint.x, startPoint.y + rect.size.width/2);
    CGPoint temEndPoint = CGPointMake(endPoint.x, endPoint.y + rect.size.width/2);
    UIBezierPath *temPath = [[UIBezierPath alloc] init];
    [temPath moveToPoint:temStartPoint];
    [temPath addLineToPoint:temEndPoint];
    
    chartLine.path = temPath.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = XJYBlue.CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    //由于CAShapeLayer.frame = (0,0,0,0) 所以用这个判断点击
    chartLine.frameValue = [NSValue valueWithCGRect:rect];
    
    chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
    return chartLine;
}

- (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.path = path.CGPath;
    rectLayer.fillColor   = fillColor.CGColor;
    rectLayer.path        = path.CGPath;
    rectLayer.frameValue = [NSValue valueWithCGRect:rect];
    return rectLayer;
}

- (XXAnimationLabel *)topLabelWithRect:(CGRect)rect fillColor:(UIColor *)color text:(NSString *)text {
    CGFloat number = text.floatValue;
    NSString *labelText = [NSString stringWithFormat:@"%.1f", number];
    XXAnimationLabel *topLabel = [[XXAnimationLabel alloc] initWithFrame:rect];
    topLabel.backgroundColor = color;
    [topLabel setTextAlignment:NSTextAlignmentCenter];
    topLabel.text = labelText;
    [topLabel setFont:[UIFont systemFontOfSize:14]];
    [topLabel setTextColor:XJYRed];
    return topLabel;
}

- (CAGradientLayer *)rectGradientLayerWithBounds:(CGRect)rect {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = @[(__bridge id)GradientFillColor1,(__bridge id)GradientFillColor2];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    return gradientLayer;
}

- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = animationDuration;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint __block point = [[touches anyObject] locationInView:self];
    
    //touch value area
    [self.layerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        point = [obj convertPoint:point toLayer:self.layer];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
        CGRect layerFrame = shapeLayer.frameValue.CGRectValue;
        if (CGRectContainsPoint(layerFrame, point)) {
            CAShapeLayer *preShapeLayer =  (CAShapeLayer *)self.layerArray[self.coverLayer.selectIdxNumber.intValue];
            // change state
            preShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
            NSLog(@"点击了 %lu bar  boolvalue", (unsigned long)idx + 1);
            
            // Notification + Deleagte To CallBack
            [[NSNotificationCenter defaultCenter] postNotificationName:[XJYNotificationBridge shareXJYNotificationBridge].TouchBarNotification object:nil userInfo:@{[XJYNotificationBridge shareXJYNotificationBridge].BarIdxNumberKey:@(idx)}];
            
            if (shapeLayer.selectStatusNumber.boolValue == TRUE) {
                shapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
                [self.coverLayer removeFromSuperlayer];
                return ;
            }
            //remove last cover layer
            [self.coverLayer removeFromSuperlayer];
            BOOL boolValue = shapeLayer.selectStatusNumber.boolValue;
            shapeLayer.selectStatusNumber = [NSNumber numberWithBool:!boolValue];
            self.coverLayer = [self rectGradientLayerWithBounds:layerFrame];
            self.coverLayer.selectIdxNumber = @(idx);
            [shapeLayer addSublayer:self.coverLayer];
            return ;
        }
        
    }];
    
    //touch whole bar
    [self.fillLayerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
        CGRect layerFrame = shapeLayer.frameValue.CGRectValue;
        
        if (CGRectContainsPoint(layerFrame, point)) {
        
            //上一次点击的layer,清空上一次的状态
            CAShapeLayer *preShapeLayer =  (CAShapeLayer *)self.layerArray[self.coverLayer.selectIdxNumber.intValue];
            preShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
            [self.coverLayer removeFromSuperlayer];
            
            
            // Notification + Deleagte To CallBack
            [[NSNotificationCenter defaultCenter] postNotificationName:[XJYNotificationBridge shareXJYNotificationBridge].TouchBarNotification object:nil userInfo:@{[XJYNotificationBridge shareXJYNotificationBridge].BarIdxNumberKey:@(idx)}];
            
            CAShapeLayer *subShapeLayer = (CAShapeLayer *)self.layerArray[idx];
            if (subShapeLayer.selectStatusNumber.boolValue == YES) {
                subShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
                [self.coverLayer removeFromSuperlayer];
                return ;
            }
            
            BOOL boolValue = subShapeLayer.selectStatusNumber.boolValue;
            subShapeLayer.selectStatusNumber = [NSNumber numberWithBool: !boolValue];
            self.coverLayer = [self rectGradientLayerWithBounds:subShapeLayer.frameValue.CGRectValue];
            self.coverLayer.selectIdxNumber = @(idx);
            [subShapeLayer addSublayer:self.coverLayer];
            return ;
        }
    }];
    
}


@end
