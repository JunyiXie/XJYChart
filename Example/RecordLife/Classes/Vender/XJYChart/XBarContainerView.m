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

#define GradientFillColor1 [UIColor colorWithRed:117/255.0 green:184/255.0 blue:245/255.0 alpha:1].CGColor
#define GradientFillColor2 [UIColor colorWithRed:24/255.0 green:141/255.0 blue:240/255.0 alpha:1].CGColor
#define BarBackgroundFillColor [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]

@interface XBarContainerView ()
@property (nonatomic, strong) CABasicAnimation *pathAnimation;

@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;


@end

@implementation XBarContainerView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber  {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
    //从BarItem 中提取各类数据
    //防止多次调用 必须清理数据
    [self.colorArray removeAllObjects];
    [self.dataNumberArray removeAllObjects];
    [self.dataDescribeArray removeAllObjects];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.colorArray addObject:obj.color];
        [self.dataNumberArray addObject:obj.dataNumber];
        [self.dataDescribeArray addObject:obj.dataDescribe];
    }];
    
    
    //绘制条
    
    
    //每个条的宽度
    CGFloat width = (self.bounds.size.width / self.dataItemArray.count) / 3 * 2;
    //每个条的x坐标
    NSMutableArray<NSNumber *> *xArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = self.bounds.size.width * [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:idx count:self.dataItemArray.count];
        [xArray addObject:@(x)];
    }];
        
    //每个条的高度
    CGFloat height = self.bounds.size.height;
        
    //每个条的rect
    NSMutableArray<NSValue *> *rectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number = obj;
        CGRect rect = CGRectMake(number.doubleValue - width/2, 0, width, height);
        [rectArray addObject:[NSValue valueWithCGRect:rect]];
    }];
        
        //根据rect 绘制背景条
    [rectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = obj.CGRectValue;
        CAShapeLayer *rectShapeLayer = [self rectShapeLayerWithBounds:rect fillColor:BarBackgroundFillColor];
        [self.layer addSublayer:rectShapeLayer];
    }];
        
        //每个条根据数值大小填充的高度
    NSMutableArray<NSNumber *> *fillHeightArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:self.dataNumberArray[idx].doubleValue] * self.bounds.size.height;
        [fillHeightArray addObject:@(height)];
    }];
    //计算填充的矩形
    NSMutableArray<NSValue *> *fillRectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //height - fillHeightArray[idx].doubleValue 计算起始Y
        CGRect fillRect = CGRectMake(obj.doubleValue - width/2,height - fillHeightArray[idx].doubleValue , width, fillHeightArray[idx].doubleValue);
        [fillRectArray addObject:[NSValue valueWithCGRect:fillRect]];
    }];
        
    //根据fillrect 绘制填充的fillrect 与 topLabel
    NSMutableArray *fillShapeLayerArray = [[NSMutableArray alloc] init];
        
    [fillRectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect fillRect = obj.CGRectValue;
        
        CAShapeLayer *fillRectShapeLayer = [self rectAnimationLayerWithBounds:fillRect fillColor:self.dataItemArray[idx].color];
        UILabel *topLabel = [self topLabelWithRect:CGRectMake(fillRect.origin.x, fillRect.origin.y - 30, fillRect.size.width, 15) fillColor:[UIColor clearColor] text:self.dataNumberArray[idx].stringValue];
//        CAGradientLayer *fillRectGradientLayer = [self rectGradientLayerWithBounds:fillRect];
        //
        
        //动画完成之后 添加label
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.pathAnimation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addSubview:topLabel];
        });
        [self.layer addSublayer:fillRectShapeLayer];

        [fillShapeLayerArray addObject:fillRectShapeLayer];
    }];
    
}


#pragma mark Get



#pragma mark HelpMethods

- (CAShapeLayer *)rectAnimationLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    //动画的path
    CGPoint startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y + rect.size.height));
    CGPoint endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));
    UIBezierPath *animationPath = [[UIBezierPath alloc] init];
    [animationPath moveToPoint:startPoint];
    [animationPath addLineToPoint:endPoint];
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapSquare;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = rect.size.width;
    chartLine.path = animationPath.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = [UIColor orangeColor].CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    return chartLine;
}

- (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    
    //正常的
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.path = path.CGPath;
    rectLayer.fillColor   = fillColor.CGColor;
    rectLayer.path        = path.CGPath;
    return rectLayer;
}

- (UILabel *)topLabelWithRect:(CGRect)rect fillColor:(UIColor *)color text:(NSString *)text {
    
    CGFloat number = text.floatValue;
    NSString *labelText = [NSString stringWithFormat:@"%.1f", number];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:rect];
    topLabel.backgroundColor = color;
    [topLabel setTextAlignment:NSTextAlignmentCenter];
    topLabel.text = labelText;
    [topLabel setFont:[UIFont systemFontOfSize:10]];
    [topLabel setTextColor:XJYGreen];
    return topLabel;
}

- (CAGradientLayer *)rectGradientLayerWithBounds:(CGRect)rect {
    //颜色渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = @[(__bridge id)GradientFillColor1,(__bridge id)GradientFillColor2];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    return gradientLayer;
    
}

- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = 1.5;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}



@end
