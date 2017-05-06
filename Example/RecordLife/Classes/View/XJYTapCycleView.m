//
//  XJYTapCycleView.m
//  RecordLife
//
//  Created by 谢俊逸 on 01/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYTapCycleView.h"

@implementation XJYTapCycleView {
    CAShapeLayer *cycleLayer;
    CGFloat radius;
    UIColor *fillColor;
    UIColor *textColor;
    CGFloat fontSize;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];

    
    
    radius = self.frame.size.width/2 - 15;
    fillColor = [UIColor whiteColor];
    textColor = [UIColor colorWithRed:65/255.0 green:91/255.0 blue:101/255.0 alpha:1];
    fontSize = 14;
    self.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    if (cycleLayer != nil) {
        [cycleLayer removeFromSuperlayer];
    }

    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat startA =  0;  //设置进度条起点位置
    CGFloat endA = M_PI * 2;  //设置进度条终点位置
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    cycleLayer = [CAShapeLayer layer];//创建一个track shape layer
    cycleLayer.frame = self.bounds;
    cycleLayer.fillColor = [fillColor CGColor];  //填充色为无色
    cycleLayer.strokeColor = [[UIColor colorWithRed:65/255.0 green:91/255.0 blue:101/255.0 alpha:1] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    cycleLayer.opacity = 1; //背景颜色的透明度
    cycleLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    cycleLayer.lineWidth = 3;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    cycleLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    [self.layer addSublayer:cycleLayer];
    
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 20, self.frame.size.height/2 - 20, 40, 40)];
    self.label.text = @"1周";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = textColor;
    self.label.font = [UIFont systemFontOfSize:fontSize];
    [self addSubview:self.label];

}


- (void)tapChange:(BOOL)height {
    if (height) {
        radius = self.frame.size.width/2 - 5;
        fillColor = [UIColor colorWithRed:65/255.0 green:91/255.0 blue:101/255.0 alpha:1];
        textColor = [UIColor whiteColor];
        fontSize = 18;
    } else {
        radius = self.frame.size.width/2 - 15;
        fillColor = [UIColor whiteColor];
        textColor = [UIColor colorWithRed:65/255.0 green:91/255.0 blue:101/255.0 alpha:1];
        fontSize = 12;
    }
    [self setNeedsDisplay];

}


@end
