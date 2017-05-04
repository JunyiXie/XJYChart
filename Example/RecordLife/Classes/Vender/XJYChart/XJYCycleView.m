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
    // remove layer
    if (_progressLayer != nil) {
        [self.progressLayer removeFromSuperlayer];
    }
    if (_gradientLayer != nil) {
        [self.gradientLayer removeFromSuperlayer];
    }
    if (_hLayer != nil) {
        [self.hLayer removeFromSuperlayer];
    }
    // center
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat startA =  M_PI_2 +0.065;
    CGFloat endA = M_PI_2 + M_PI*2*_progress +0.065;
    // decorative cycle
    for (int i = 0; i < 180; i ++) {
        CGFloat angle = DEGREES_TO_RADIANS(i*2);
        CGFloat radiusLineCycle = rect.size.width/2 - 10;
        CGPoint point1 = CGPointMake(cos(angle)*radiusLineCycle + center.x, sin(angle)*radiusLineCycle + center.y);
        CGPoint point2 = CGPointMake(cos(angle)*7 + point1.x, sin(angle)*7 + point1.y);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetRGBStrokeColor(context, 180 / 255.0, 180.0 / 255.0, 180.0 / 255.0, 1.0);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
    // draw cycle
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    // The color used to stroke the shape’s path. Animatable.
    _progressLayer.strokeColor = [[UIColor redColor] CGColor];     _progressLayer.opacity = 1;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 10;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    _progressLayer.path =[path CGPath];
    [self.layer addSublayer:_progressLayer];
    //gradientLayer
    self.gradientLayer = [CALayer layer];
    //left gradient
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[UIColor colorWithRed:123/255.0 green:138/255.0 blue:146/255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:178/255.0 green:187/255.0 blue:192/255.0 alpha:1].CGColor];
    [self.gradientLayer addSublayer:leftLayer];
    //right gradient
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[UIColor colorWithRed:123/255.0 green:138/255.0 blue:146/255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:64/255.0 green:89/255.0 blue:100/255.0 alpha:1].CGColor];
    [self.gradientLayer addSublayer:rightLayer];
    [self.gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:self.gradientLayer];
    //draw head
    CGPoint handleCenter =  [self pointFromAngle: (self.angle)];
    self.hLayer = [CAShapeLayer layer];
    UIBezierPath *hpath = [UIBezierPath bezierPathWithArcCenter:handleCenter radius:_lineWidth*3.2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.hLayer.path = hpath.CGPath;
    self.hLayer.fillColor = [UIColor colorWithRed:64/255.0 green:89/255.0 blue:100/255.0 alpha:1].CGColor;
    [self.layer addSublayer:self.hLayer];
}

#pragma mark Touch Deal
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint = [touch locationInView:self];
    [self movehandle:lastPoint];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)movehandle:(CGPoint)lastPoint{

    //centerPoint
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2,
                                      self.frame.size.height/2);
    //center to point angle
    float currentAngle = AngleFromNorth(centerPoint,
                                        lastPoint,
                                        NO);
    int angleInt = floor(currentAngle);
    //change the starting point so do judge
    self.angle = angleInt;
    if (self.angle >= 90 && self.angle <= 360 ) {
        self.progress = (self.angle - 90)/360.0;
    } else {
        self.progress = (self.angle + 270)/360.0;
    }
    
    NSLog(@"%f",self.progress);
    [self.cycleViewDeleagte ratioChange:self.progress];
    [self setNeedsDisplay];
}

// computing center to the Angle of the arbitrary point
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = RADIANS_TO_DEGREES(radians);
    return (result >=0  ? result : result + 360.0);
}

-(CGPoint)pointFromAngle:(int)angleInt{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint result;
    //Plus the amount of the front (deal with the issue of gradual change color)
    result.y = round(centerPoint.y + radius * sin(DEGREES_TO_RADIANS(angleInt+3))) ;
    result.x = round(centerPoint.x + radius * cos(DEGREES_TO_RADIANS(angleInt+3)));
    return result;
}

#pragma mark Set

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

@end
