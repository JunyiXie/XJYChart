//
//  XJYLineChart.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

//你可能好奇为什么我不重用 用数组 来避免重复的代码
//我的回答是 可修改性强，可定制性强。
//没必要为了一点代码量 影响代码的灵活性.

#import "XJYLineChart.h"
#import "Masonry.h"
#import "XJYPointView.h"
#define POINT_CIRCLE  6.0f

#define ChartTopInsetToView 5.0f
#define ChartLeftInsetToView 10.0f
#define ChartRightInsetToView 5.0f
#define ChartBottomInsetToView 10.0f




@interface XJYLineChart ()
{
@private
    NSMutableArray *_SeconArry; //计算时间的数据
    NSMutableArray *_linePointArray;
    NSMutableArray *_secondLinePointArray;
    NSMutableArray *_thirdLinePointArray;
    
    CGFloat ChartX;
    CGFloat ChartY;
    CGFloat ChartWidth;
    CGFloat ChartHeight;
    
    //横坐标Labels
    NSMutableArray *_abscissaLabelArray;
    //纵坐标Labels
    NSMutableArray *_ordinateLabelArray;
    //横坐标视图
    UIView *_abscissaView;
    //纵坐标视图
    UIView *_ordinateView;

}

//KVO观察记号
@property (nonatomic, strong) id frameObserveToken;

@end

@implementation XJYLineChart

//首先进init
- (instancetype)init {
    if (self = [super init]) {
        
        self.XJYLineChartType = XJYLineChartTypeSimple;
        self.backgroundColor = [UIColor whiteColor];
        //初始化数组
        _ordinateDateArray = [[NSMutableArray alloc] init];
        _levelDataArray = [[NSMutableArray alloc] init];
        
        _abscissaLabelArray = [[NSMutableArray alloc] init];
        _ordinateLabelArray = [[NSMutableArray alloc] init];
        
        _linePointArray = [[NSMutableArray alloc] init];
        _secondLinePointArray = [[NSMutableArray alloc] init];
        _thirdLinePointArray = [[NSMutableArray alloc] init];

        //初始化View
        _abscissaView = [[UIView alloc] init];
        _ordinateView = [[UIView alloc] init];
        
        //添加子视图
        [self addSubview:_abscissaView];
        [self addSubview:_ordinateView];
        

        
        [self addObserver:self forKeyPath:@"lineColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
//        [self addObserver:self forKeyPath:@"pointColor" options:NSKeyValueObservingOptionNew context:nil];
        

    }
    return self;
}



#pragma mark DrawRect
//3.drawRect
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
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
    
    
    if (_XJYLineChartType == XJYLineChartTypeNormal) {
        //垂直辅助线
        for (int i= 0; i< _levelDataArray.count + 1; i++) {
            if (i==0||i== (_levelDataArray.count)) {
                CGFloat lengths[] = {1,1};
                CGContextSetLineDash(ContextRef, 0, lengths, 0);
            }
            else
            {
                CGFloat lengths[] = {3,3};
                CGContextSetLineDash(ContextRef, 0, lengths, 2);
            }
            
            CGContextMoveToPoint(ContextRef, i*self.frame.size.width/(_levelDataArray.count), self.frame.size.height);
            CGContextAddLineToPoint(ContextRef, i*self.frame.size.width/(_levelDataArray.count),0);
            CGContextStrokePath(ContextRef);
        }
    }

    
#pragma mark 计算点的 CGPoint
    //通过数值把点计算出来 添加到数组中
    //如果有数据就计算点
    NSLog(@"%lu",_verticalNumberDataArray.count);
    NSLog(@"%lu",_verticalSecondNumberDataArray.count);
    NSLog(@"%lu",_verticalThirdNumberDataArray.count);

    if (self.verticalNumberDataArray != nil) {
        [_verticalNumberDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *number = obj;
            CGPoint point = [self calculatePointWithNumber:number idx:idx numberArray:_verticalNumberDataArray bounds:self.bounds];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [_linePointArray addObject:pointValue];
        }];
    }
    //如果有数据就计算点
    if (self.verticalSecondNumberDataArray != nil) {
        [_verticalSecondNumberDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *number = obj;
            CGPoint point = [self calculatePointWithNumber:number idx:idx numberArray:_verticalSecondNumberDataArray bounds:self.bounds];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [_secondLinePointArray addObject:pointValue];
        }];
    }
    //如果有数据就计算点
    if (self.verticalThirdNumberDataArray != nil) {
        [_verticalThirdNumberDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *number = obj;
            CGPoint point = [self calculatePointWithNumber:number idx:idx numberArray:_verticalThirdNumberDataArray bounds:self.bounds];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            [_thirdLinePointArray addObject:pointValue];
        }];
    }
    
#pragma mark 画折线
    //画折线
    [_linePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSValue *pointValue = obj;
        CGPoint point = pointValue.CGPointValue;
        NSValue *priorPointValue = [[NSValue alloc] init];
        if (idx == 0) {
            //这地方的处理 识情况而定
            priorPointValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
        } else {
            priorPointValue = _linePointArray[idx - 1];
            
            CGPoint priorPoint = priorPointValue.CGPointValue;
            CGContextSetStrokeColorWithColor(ContextRef, self.lineColor.CGColor);
            CGContextSetLineWidth(ContextRef, 1.6f);
            CGContextSetLineDash(ContextRef, 0, 0, 0);
            CGContextMoveToPoint(ContextRef, priorPoint.x,self.bounds.size.height -  priorPoint.y);
            CGContextAddLineToPoint(ContextRef, point.x,self.bounds.size.height -  point.y);
            CGContextStrokePath(ContextRef);
        }
    }];
    
    [_secondLinePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSValue *pointValue = obj;
        CGPoint point = pointValue.CGPointValue;
        NSValue *priorPointValue = [[NSValue alloc] init];
        if (idx == 0) {
            //这地方的处理 识情况而定
            priorPointValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
        } else {
            priorPointValue = _secondLinePointArray[idx - 1];
            
            CGPoint priorPoint = priorPointValue.CGPointValue;
            CGContextSetStrokeColorWithColor(ContextRef, self.secondLineColor.CGColor);
            CGContextSetLineWidth(ContextRef, 1.6f);
            CGContextSetLineDash(ContextRef, 0, 0, 0);
            CGContextMoveToPoint(ContextRef, priorPoint.x, self.bounds.size.height - priorPoint.y);
            CGContextAddLineToPoint(ContextRef, point.x, self.bounds.size.height - point.y);
            CGContextStrokePath(ContextRef);
        }
    }];
    
    [_thirdLinePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSValue *pointValue = obj;
        CGPoint point = pointValue.CGPointValue;
        NSValue *priorPointValue = [[NSValue alloc] init];
        if (idx == 0) {
            //这地方的处理 识情况而定
            priorPointValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
        } else {
            priorPointValue = _thirdLinePointArray[idx - 1];
            
            CGPoint priorPoint = priorPointValue.CGPointValue;
            CGContextSetStrokeColorWithColor(ContextRef, self.thirdLineColor.CGColor);
            CGContextSetLineWidth(ContextRef, 1.6f);
            CGContextSetLineDash(ContextRef, 0, 0, 0);
            CGContextMoveToPoint(ContextRef, priorPoint.x, self.bounds.size.height - priorPoint.y);
            CGContextAddLineToPoint(ContextRef, point.x, self.bounds.size.height - point.y);
            CGContextStrokePath(ContextRef);
        }
    }];
    
#pragma mark 画点
    //1
    if (_linePointArray != nil) {
        [_linePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //画点
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;

            CGContextSetFillColorWithColor(ContextRef, self.pointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, self.pointColor.CGColor);//线框颜色
            CGContextFillEllipseInRect(ContextRef, CGRectMake(point.x - 3, self.bounds.size.height - point.y - 3, 6.0, 6.0));
        }];
    }
    //2
    if (_secondLinePointArray != nil) {
        [_secondLinePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //画点
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;
            CGPoint sPoints[3];//坐标点
            sPoints[0] =CGPointMake(3 + point.x - 3, self.bounds.size.height - point.y - 3 + 0);//坐标1
            sPoints[1] =CGPointMake(0 + point.x - 3, self.bounds.size.height - point.y - 3 + 6);//坐标2
            sPoints[2] =CGPointMake(6 + point.x - 3, self.bounds.size.height - point.y - 3 + 6);//坐标3
            CGContextAddLines(ContextRef, sPoints, 3);//添加线
            CGContextClosePath(ContextRef);//封起来
            CGContextSetFillColorWithColor(ContextRef, self.secondPointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, self.secondPointColor.CGColor);//线框颜色
            CGContextDrawPath(ContextRef, kCGPathFillStroke); //根据坐标绘制路径
        }];
    }
    //3
    if (_thirdLinePointArray != nil) {
        [_thirdLinePointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //画点
            NSValue *pointValue = obj;
            CGPoint point = pointValue.CGPointValue;
            CGContextSetLineWidth(ContextRef, 1.0);//线的宽度
            CGContextSetFillColorWithColor(ContextRef, self.thirdPointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, self.thirdPointColor.CGColor);//线框颜色
            CGContextAddRect(ContextRef,CGRectMake(point.x - 3, self.bounds.size.height - point.y - 3, 6, 6));//画方框
            CGContextDrawPath(ContextRef, kCGPathFillStroke);//绘画路径
        }];
    }


}



#pragma mark Auto Layout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
//2.更新约束
- (void)updateConstraints {
    
    //横坐标Labels
    [_abscissaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@19);
    }];
    [_abscissaLabelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:5 tailSpacing:5];
    [_abscissaLabelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = obj;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.centerY.equalTo(_abscissaView.mas_centerY);
        }];
    }];
    
    //纵坐标Labels
    [_ordinateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_left);
        make.width.equalTo(@35);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [_ordinateLabelArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:20 leadSpacing:-10 tailSpacing:-10];
    [_ordinateLabelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = obj;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@35);
            make.centerX.equalTo(_ordinateView.mas_centerX);
        }];
    }];
    [super updateConstraints];
    NSLog(@"updateConstraints");

}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    NSLog(@"setNeedsLayout");

}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    NSLog(@"setNeedsDisplay");

}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    NSLog(@"layoutIfNeeded");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}


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


#pragma mark Setup Label
- (void)setupLevelLabelUI {
    // 水平坐标的数据
    for (int i = 0 ; i < _levelDataArray.count; i++) {
        UILabel * LevelLabel= [[UILabel alloc] init];
        LevelLabel.textAlignment=NSTextAlignmentCenter;
        LevelLabel.text = _levelDataArray[i];
//        LevelLabel.backgroundColor=[UIColor redColor];
        LevelLabel.textColor = UIColorFromRGBHex(0x333333);
        LevelLabel.font = [UIFont systemFontOfSize:12];
        [_abscissaLabelArray addObject:LevelLabel];
        [_abscissaView addSubview:LevelLabel];
    }
}

- (void)setupordinateLabelUI {
    // 垂直坐标的数据
    // 默认 就根据坐标来了!
    if (_ordinateDateArray.count == 0) {
        
        for (int i = 0; i < 4; i++) {
            //坐标计算 注意 这里牵扯到了布局的label排列
            //(4 - 1) 分成了三等份的距离
            [_ordinateDateArray addObject:@(floor((self.top.doubleValue - self.bottom.doubleValue)/(4 - 1) * (3 - i) + self.bottom.doubleValue))];
        }
        
        for (int i = 0 ; i < 4; i++) {
            UILabel * LevelLabel= [[UILabel alloc] init];
            LevelLabel.textAlignment=NSTextAlignmentCenter;
            
            NSNumber *number = _ordinateDateArray[i];
            NSString *text = [NSString stringWithFormat:@"%ld",number.integerValue];
            LevelLabel.text = text;
//            LevelLabel.backgroundColor=[UIColor redColor];
            LevelLabel.textColor = UIColorFromRGBHex(0x333333);
            LevelLabel.font = [UIFont systemFontOfSize:12];
            [_ordinateLabelArray addObject:LevelLabel];
            [_ordinateView addSubview:LevelLabel];
        }
    } else {
        for (int i = 0 ; i < _ordinateLabelArray.count; i++) {
            UILabel * LevelLabel= [[UILabel alloc] init];
            LevelLabel.textAlignment=NSTextAlignmentCenter;
            LevelLabel.text = _ordinateLabelArray[i];
//            LevelLabel.backgroundColor=[UIColor redColor];
            LevelLabel.textColor = UIColorFromRGBHex(0x333333);
            LevelLabel.font = [UIFont systemFontOfSize:12];
            [_ordinateLabelArray addObject:LevelLabel];
            [_ordinateView addSubview:LevelLabel];
        }
    }

}


#pragma mark Lazy Loading
- (void)setLevelDataArray:(NSMutableArray *)levelDataArray {
    _levelDataArray = levelDataArray;
    [self setupLevelLabelUI];
    [self setupordinateLabelUI];
}

//可以自己设定 或者采用默认的
- (void)setOrdinateDateArray:(NSMutableArray *)ordinateDateArray {
    _ordinateLabelArray = ordinateDateArray;
    [self setupordinateLabelUI];
}
- (void)setVerticalNumberDataArray:(NSMutableArray *)verticalNumberDataArray {
    _verticalNumberDataArray = verticalNumberDataArray;
}

//线的颜色
- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

- (UIColor *)secondLineColor {
    if (!_secondLineColor) {
        _secondLineColor = [UIColor blackColor];
    }
    return _secondLineColor;
}

- (UIColor *)thirdLineColor {
    if (!_thirdLineColor) {
        _thirdLineColor = [UIColor blackColor];
    }
    return _thirdLineColor;
}
//点的颜色
- (UIColor *)pointColor {
    if (!_pointColor) {
        _pointColor = [UIColor redColor];
    }
    return _pointColor;
}
- (UIColor *)secondPointColor {
    if (!_secondPointColor) {
        _secondPointColor = [UIColor redColor];
    }
    return _secondPointColor;
}
- (UIColor *)thirdPointColor {
    if (!_thirdPointColor) {
        _thirdPointColor = [UIColor redColor];
    }
    return _thirdPointColor;
}

- (UIColor *)chartBackgroundColor {
    if (!_chartBackgroundColor) {
        _chartBackgroundColor = [UIColor whiteColor];
    }
    return _chartBackgroundColor;
}

#pragma mark KVO


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"lineColor"]) {
//        [self setNeedsDisplay];
//    } else if ([keyPath isEqualToString:@"pointColor"]) {
//        [self setNeedsDisplay];
//    } 
}
#pragma mark Dealloc
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"lineColor"];
}
@end


