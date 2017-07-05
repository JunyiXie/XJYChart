//
//  XAnimator.m
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimator.h"

@interface XAnimator()
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat startingValue;
@property (nonatomic, assign) CGFloat destinationValue;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat lastUpdateTime;
@property (nonatomic, assign) CGFloat totalTime;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) CGFloat currentValue;


@property (nonatomic, strong) AnimatorNumberBlock animationBlock;
@end

@implementation XAnimator

- (void)addDisplayLink {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


// 值的更新 以后还要加上 x->f(x)->y 映射
- (void)updateValue:(CADisplayLink *)timer {
    CGFloat now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdateTime;
    self.lastUpdateTime = now;
    
    if (self.progress >= self.totalTime) {
        if (self.timer != nil) {
            [self.timer invalidate];
            self.timer = nil;
            self.progress = self.totalTime;
        }
    }
    [self setProgressValue:self.currentValue];
}

- (void)setProgressValue:(CGFloat)number {
    self.animationBlock(number);
}
// 从当前value 迭代, 准备工作
- (void)countFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration {

    // timer 处理
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    // duration 处理
    if (duration == 0.0) {
        [self setProgressValue:to];
        return ;
    }
   
    // 迭代有关值处理
    self.progress = 0.0;
    self.totalTime = duration;
    self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];
    
    // 添加DisplayLink
    [self addDisplayLink];
}

- (void)XAnimatorCountFrom:(CGFloat)from CurrentTo:(CGFloat)to duration:(CGFloat)duration animationBlock:(AnimatorNumberBlock)block {
    // 外部值 赋值
    self.startingValue = from;
    self.destinationValue = to;
    self.animationBlock = block;
    // 开始迭代
    [self countFrom:self.currentValue to:to duration:duration];
}

#pragma mark Get
// 计算当前的值，包括了开始状态 和 进行中状态
- (CGFloat)currentValue {
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    return self.startingValue + (self.progress/self.totalTime)*(self.destinationValue - self.startingValue);
}

@end
