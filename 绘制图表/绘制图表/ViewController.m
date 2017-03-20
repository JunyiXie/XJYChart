//
//  ViewController.m
//  绘制图表
//
//  Created by 谢俊逸 on 20/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
@interface ViewController ()

@property (nonatomic, strong) CABasicAnimation *pathAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self strokeLine];
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(50, 50);
    CGPoint point3 = CGPointMake(70, 70);
    CGPoint point4 = CGPointMake(200, 200);
    
    NSValue *value1 = [NSValue valueWithCGPoint:point1];
    NSValue *value2 = [NSValue valueWithCGPoint:point2];
    NSValue *value3 = [NSValue valueWithCGPoint:point3];
    NSValue *value4 = [NSValue valueWithCGPoint:point4];

    NSMutableArray *pointValueArray = [NSMutableArray arrayWithObjects:value1,value2,value3,value4, nil];
    
    CAShapeLayer *lineLayer = [self shapeLayerWithPoints:pointValueArray];

//    [CATransaction begin];
    [self.view.layer addSublayer:lineLayer];
//    [CATransaction commit];
    
    // Do any additional setup after loading the view, typically from a nib;
//    LineView *view = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:view];
}
- (void)strokeLine {
    UIBezierPath *line = [[UIBezierPath alloc] init];
    //设置线宽
    line.lineWidth = 3;
    [line moveToPoint:CGPointMake(50, 20)];
    [line addLineToPoint:CGPointMake(150, 20)];
    
    [line moveToPoint:CGPointMake(150, 20)];
    [line addLineToPoint:CGPointMake(200, 49)];
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = 5;
    chartLine.path = line.CGPath;
    chartLine.strokeStart = 0.0;
    //
    chartLine.strokeColor = [UIColor orangeColor].CGColor;
    [chartLine  addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    chartLine.strokeEnd = 1.0;

    [self.view.layer addSublayer:chartLine];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = 1.0;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}

- (CAShapeLayer *)shapeLayerWithPoints:(NSMutableArray<NSValue *> *)pointsValueArray{
    UIBezierPath *line = [[UIBezierPath alloc] init];
    for (int i = 0; i < pointsValueArray.count - 1; i++) {
        CGPoint point1 = pointsValueArray[i].CGPointValue;
        CGPoint point2 = pointsValueArray[i + 1].CGPointValue;
        [line moveToPoint:point1];
        [line addLineToPoint:point2];
    }
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = 5;
    chartLine.path = line.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = [UIColor orangeColor].CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    return chartLine;
}



@end
