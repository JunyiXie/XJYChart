//
//  XJYBarChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYBarChart.h"
#import "XJYAuxiliaryCalculationHelper.h"
#import "XJYColor.h"

#define BarBackgroundFillColor [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]

#define GradientFillColor1 [UIColor colorWithRed:117/255.0 green:184/255.0 blue:245/255.0 alpha:1].CGColor
#define GradientFillColor2 [UIColor colorWithRed:24/255.0 green:141/255.0 blue:240/255.0 alpha:1].CGColor


//每个条和间隔的宽度
#define PartWidth 50.0


@interface XJYBarChart ()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray<UILabel *> *abscissaLabelArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *ordinateLabelArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *ordinateDataArray;

@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;


@property (nonatomic, strong) UIView *ordinateView;
@property (nonatomic, strong) UIView *abscissalView;
@property (nonatomic, strong) UIView *barChartView;

@end

@implementation XJYBarChart

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber {
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataItemArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataDescribeArray = [[NSMutableArray alloc] init];
        self.ordinateLabelArray = [[NSMutableArray alloc] init];
        self.abscissaLabelArray = [[NSMutableArray alloc] init];
        self.ordinateDataArray = [[NSMutableArray alloc] init];
        
        self.dataItemArray = dataItemArray;
        self.top = topNumbser;
        self.bottom = bottomNumber;
        
//        [self setContentView];

        self.ordinateView = [[UIView alloc] init];
        //        self.ordinateView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.ordinateView];
        
        self.abscissalView = [[UIView alloc] init];
        //        self.abscissalView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.abscissalView];
        
        self.barChartView = [[UIView alloc] init];
        //        self.barChartView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.barChartView];
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataItemArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataDescribeArray = [[NSMutableArray alloc] init];
        
        self.ordinateLabelArray = [[NSMutableArray alloc] init];
        self.abscissaLabelArray = [[NSMutableArray alloc] init];
        
        self.ordinateDataArray = [[NSMutableArray alloc] init];
        
//        self.ordinateView = [[UIView alloc] init];
////        self.ordinateView.backgroundColor = [UIColor greenColor];
//        [self addSubview:self.ordinateView];
//        
//        self.abscissalView = [[UIView alloc] init];
////        self.abscissalView.backgroundColor = [UIColor yellowColor];
//        [self addSubview:self.abscissalView];
//        
//        self.barChartView = [[UIView alloc] init];
////        self.barChartView.backgroundColor = [UIColor blueColor];
//        [self addSubview:self.barChartView];
//        

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

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
    CGFloat width = (self.barChartView.bounds.size.width / self.dataItemArray.count) / 3 * 2;
    
    //每个条的x坐标
    NSMutableArray<NSNumber *> *xArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = self.barChartView.bounds.size.width * [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:idx count:self.dataItemArray.count];
        [xArray addObject:@(x)];
    }];

    //每个条的高度
    CGFloat height = self.barChartView.bounds.size.height;
    
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
        [self.barChartView.layer addSublayer:rectShapeLayer];
    }];
    
    //每个条根据数值大小填充的高度
    NSMutableArray<NSNumber *> *fillHeightArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(XJYBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = [[XJYAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:self.dataNumberArray[idx].doubleValue] * self.barChartView.bounds.size.height;
        [fillHeightArray addObject:@(height)];
    }];
    //计算填充的矩形
    NSMutableArray<NSValue *> *fillRectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //height - fillHeightArray[idx].doubleValue 计算起始Y
        CGRect fillRect = CGRectMake(obj.doubleValue - width/2,height - fillHeightArray[idx].doubleValue, width, fillHeightArray[idx].doubleValue);
        [fillRectArray addObject:[NSValue valueWithCGRect:fillRect]];
    }];

    //根据fillrect 绘制填充的fillrect
    NSMutableArray *fillShapeLayerArray = [[NSMutableArray alloc] init];
    
    [fillRectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect fillRect = obj.CGRectValue;
//        CAShapeLayer *fillRectShapeLayer = [self rectShapeLayerWithBounds:fillRect fillColor:self.dataItemArray[idx].color];
        CAShapeLayer *fillRectShapeLayer = [self rectShapeLayerWithBounds:fillRect fillColor:[[XJYColor shareXJYColor] randomColorInColorArray]];


//        CAGradientLayer *fillRectGradientLayer = [self rectGradientLayerWithBounds:fillRect];
        //
        [self.barChartView.layer addSublayer:fillRectShapeLayer];
        [fillShapeLayerArray addObject:fillRectShapeLayer];
    }];

#pragma mark Animation
    //add Animation Mask

    [fillShapeLayerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        NSValue *value = fillRectArray[idx];
        CGRect rect = value.CGRectValue;
        CGRect rect1 = CGRectMake(rect.origin.x + rect.size.width/4, rect.origin.y, rect.size.width/2, rect.size.height);
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect1];
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        CAShapeLayer *rectMaskLayer = [CAShapeLayer layer];
        rectMaskLayer.path = path.CGPath;
        
        rectMaskLayer.fillColor = [UIColor clearColor].CGColor;
        rectMaskLayer.strokeColor = [UIColor blackColor].CGColor;
        rectMaskLayer.strokeStart = 0;
        rectMaskLayer.strokeEnd   = 1;
        rectMaskLayer.lineWidth   = rect1.size.width;
        //关闭动画
//        layer.mask = rectMaskLayer;
        
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 2;
        animation.fromValue = @0;
        animation.toValue   = @1;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.removedOnCompletion = YES;
        [layer.mask addAnimation:animation forKey:@"barAnimation"];
    }];
    
}

- (void)setupsOrdinateAbscissalLabels {
    
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
    
    //初始化纵坐标labels
    [_ordinateDataArray removeAllObjects];
    for (int i = 0; i < 4; i++) {
        //坐标计算 注意 这里牵扯到了布局的label排列
        //(4 - 1) 分成了三等份的距离
        [_ordinateDataArray addObject:@(floor((self.top.doubleValue - self.bottom.doubleValue)/(4 - 1) * (3 - i) + self.bottom.doubleValue))];
    }
    
    //防止多次调用 必须清理数据
    [self.ordinateLabelArray removeAllObjects];
    for (UIView *view in self.ordinateView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0 ; i < 4; i++) {
        UILabel *label= [[UILabel alloc] init];
        label.textAlignment=NSTextAlignmentCenter;
        NSNumber *number = _ordinateDataArray[i];
        NSString *text = [NSString stringWithFormat:@"%ld",number.integerValue];
        label.text = text;
//        label.backgroundColor=[UIColor redColor];
        label.textColor = UIColorFromRGBHex(0x333333);
        label.adjustsFontSizeToFitWidth = YES;
        [_ordinateLabelArray addObject:label];
        [_ordinateView addSubview:label];
    }
    
    
    //初始化横坐标labels
    //防止多次调用 必须清理数据
    [self.abscissaLabelArray removeAllObjects];
    for (UIView *view in self.abscissalView.subviews) {
        [view removeFromSuperview];
    }
    [self.dataDescribeArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label= [[UILabel alloc] init];
        label.textAlignment=NSTextAlignmentCenter;
        NSString *text = [NSString stringWithFormat:@"%@",obj];
        label.text = text;
//        label.backgroundColor=[UIColor redColor];
        label.textColor = UIColorFromRGBHex(0x333333);
        label.adjustsFontSizeToFitWidth = YES;
        [_abscissaLabelArray addObject:label];
        [_abscissalView addSubview:label];
    }];
    
}







#pragma mark Auto Layout

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    //布局前 你要确保有数据
    [self strokeChart];
    [self setupsOrdinateAbscissalLabels];
    
    [self.ordinateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.width.equalTo(@40);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.abscissalView.mas_top).offset(10);
        
    }];
    [self.abscissalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@40);
        make.left.equalTo(self.ordinateView.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.ordinateView.mas_right).offset(0);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.abscissalView.mas_top);
    }];
    
    //布局纵坐标label
    [self.ordinateLabelArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:30 leadSpacing:0 tailSpacing:-15];
    [self.ordinateLabelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.ordinateView.mas_width);
            make.centerX.equalTo(self.ordinateView.mas_centerX);
        }];
    }];
    
    //布局横坐标label
    [self.abscissaLabelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:5 tailSpacing:5];
    [self.abscissaLabelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.abscissalView.mas_height);
        make.centerY.equalTo(self.abscissalView.mas_centerY);
    }];
    
    [super updateConstraints];
}


#pragma mark Helper

/**
 计算点通过 数值 idx bounds
 
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


- (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.path = path.CGPath;
    rectLayer.fillColor   = fillColor.CGColor;
//    rectLayer.strokeColor = borderColor.CGColor;
//    rectLayer.strokeStart = startPercentage;
//    rectLayer.strokeEnd   = endPercentage;
//    rectLayer.lineWidth   = borderWidth;
    rectLayer.path        = path.CGPath;
//    rectLayer.shouldRasterize = YES;
    return rectLayer;
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


#pragma mark Update 1.1 可滚动的bar



@end
