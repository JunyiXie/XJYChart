//
//  XJYCycleView.m
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "XJYCycleView.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )


@interface XJYCycleView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *hLayer;

@end
@implementation XJYCycleView {
    CGFloat radius;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _lineWidth = 3.5;
        _angle = 90;
        radius = self.frame.size.width/2 - 25;
        self.progress = 0;
        self.backgroundColor = [UIColor whiteColor];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _lineWidth = 3.5;
    _angle = 90;
    radius = self.frame.size.width/2 - 25;
    self.progress = 0;
    self.backgroundColor = [UIColor whiteColor];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    // 去除上次绘制的图层
    if (_progressLayer != nil) {
        [self.progressLayer removeFromSuperlayer];
    }
    if (_gradientLayer != nil) {
        [self.gradientLayer removeFromSuperlayer];
    }
    if (_hLayer != nil) {
        [self.hLayer removeFromSuperlayer];
    }
    
    // 进度条的center
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat startA =  M_PI_2 +0.065;  //设置进度条起点位置
    CGFloat endA = M_PI_2 + M_PI*2*_progress +0.065;  //设置进度条终点位置
    
    // 外围装饰环
    for (int i = 0; i < 180; i ++) {
        CGFloat angle = DEGREES_TO_RADIANS(i*2);
        CGFloat radiusLineCycle = rect.size.width/2 - 10;
        CGPoint point1 = CGPointMake(cos(angle)*radiusLineCycle + center.x, sin(angle)*radiusLineCycle + center.y);
        CGPoint point2 = CGPointMake(cos(angle)*7 + point1.x, sin(angle)*7 + point1.y);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);  //线宽
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetRGBStrokeColor(context, 180 / 255.0, 180.0 / 255.0, 180.0 / 255.0, 1.0);  //线的颜色
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, point1.x, point1.y);  //起点坐标
        CGContextAddLineToPoint(context, point2.x, point2.y);   //终点坐标
        CGContextStrokePath(context);
    }
    

    // 绘制环形
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    // The color used to stroke the shape’s path. Animatable.
    _progressLayer.strokeColor = [[UIColor redColor] CGColor];     _progressLayer.opacity = 1;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 10;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    _progressLayer.path =[path CGPath];
    [self.layer addSublayer:_progressLayer];
    
    //生成渐变色
    self.gradientLayer = [CALayer layer];
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[UIColor colorWithRed:123/255.0 green:138/255.0 blue:146/255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:178/255.0 green:187/255.0 blue:192/255.0 alpha:1].CGColor];
    [self.gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[UIColor colorWithRed:123/255.0 green:138/255.0 blue:146/255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:64/255.0 green:89/255.0 blue:100/255.0 alpha:1].CGColor];
    [self.gradientLayer addSublayer:rightLayer];
    [self.gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:self.gradientLayer];
    
    //绘制拖动小块
    CGPoint handleCenter =  [self pointFromAngle: (self.angle)];
    self.hLayer = [CAShapeLayer layer];
    UIBezierPath *hpath = [UIBezierPath bezierPathWithArcCenter:handleCenter radius:_lineWidth*3.2 startAngle:0 endAngle:M_PI*2 clockwise:YES];//上面
    self.hLayer.path = hpath.CGPath;
    self.hLayer.fillColor = [UIColor colorWithRed:64/255.0 green:89/255.0 blue:100/255.0 alpha:1].CGColor;
    [self.layer addSublayer:self.hLayer];
    
}


#pragma mark Touch

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}


-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint = [touch locationInView:self];
    [self movehandle:lastPoint];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}


-(void)movehandle:(CGPoint)lastPoint{

    //获得中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2,
                                      self.frame.size.height/2);
    //计算中心点到任意点的角度
    float currentAngle = AngleFromNorth(centerPoint,
                                        lastPoint,
                                        NO);
    int angleInt = floor(currentAngle);
    //因为改变了起始点,要做些判断
    self.angle = angleInt;
    if (self.angle >= 90 && self.angle <= 360 ) {
        self.progress = (self.angle - 90)/360.0;
    } else {
        self.progress = (self.angle + 270)/360.0;
    }
    [self.cycleViewDeleagte ratioChange:self.progress];
    [self setNeedsDisplay];
}

//计算中心点到任意点的角度
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}


-(CGPoint)pointFromAngle:(int)angleInt{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //根据角度得到圆环上的坐标
    CGPoint result;
    //加上了前置的量(处理渐变颜色的问题)
    result.y = round(centerPoint.y + radius * sin(ToRad(angleInt+3))) ;
    result.x = round(centerPoint.x + radius * cos(ToRad(angleInt+3)));
    return result;
}

#pragma mark Set

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

@end
