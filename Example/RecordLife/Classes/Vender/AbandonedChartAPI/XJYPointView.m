//
//  XJYPointView.m
//  RecordLife
//
//  Created by 谢俊逸 on 20/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//
//绘制的图形 是(0,0,6,6)矩形内的
#import "XJYPointView.h"


@interface XJYPointView ()



@end

@implementation XJYPointView

- (instancetype) init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.pointShapeType = XJYPointShapeTypeSquare;
        self.bounds = CGRectMake(0, 0, 6, 6);

    }
    return self;
}


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pointShapeType = XJYPointShapeTypeTriangle;

    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ContextRef = UIGraphicsGetCurrentContext();

    switch (self.pointShapeType) {
        case XJYPointShapeTypeTriangle:{
            //画三角形
            CGPoint sPoints[3];//坐标点
            sPoints[0] =CGPointMake(3, 0);//坐标1
            sPoints[1] =CGPointMake(0, 6);//坐标2
            sPoints[2] =CGPointMake(6, 6);//坐标3
            CGContextAddLines(ContextRef, sPoints, 3);//添加线
            CGContextClosePath(ContextRef);//封起来
            CGContextDrawPath(ContextRef, kCGPathFillStroke); //根据坐标绘制路径
        }
            break;

        case XJYPointShapeTypeSquare:{
            //矩形，并填颜色
            CGContextSetLineWidth(ContextRef, 1.0);//线的宽度
            CGContextSetFillColorWithColor(ContextRef, self.secondPointColor.CGColor);//填充颜色
            CGContextSetStrokeColorWithColor(ContextRef, self.secondPointColor.CGColor);//线框颜色
            CGContextAddRect(ContextRef,CGRectMake(0, 0, 6, 6));//画方框
            CGContextDrawPath(ContextRef, kCGPathFillStroke);//绘画路径
        }
            break;
        case XJYPointShapeTypeCircular:{
            //画点
            CGContextSetFillColor(ContextRef,  CGColorGetComponents(self.pointColor.CGColor));
            CGContextFillEllipseInRect(ContextRef, CGRectMake(0, 0, 6.0, 6.0));
        }
            break;
        default:{
            //画点
            CGContextSetFillColor(ContextRef,  CGColorGetComponents(self.pointColor.CGColor));
            CGContextFillEllipseInRect(ContextRef, CGRectMake(0, 0, 6.0, 6.0));
        }
            break;
    }
}


@end
