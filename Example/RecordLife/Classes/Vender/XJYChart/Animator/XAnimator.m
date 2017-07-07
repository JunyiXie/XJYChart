//
//  XAnimator.m
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimator.h"
#import "easing.h"
typedef NS_ENUM(NSUInteger, XDisplayLinkAnimatorResultType) {
  XPercentage,
  XResult,
};

@interface XAnimator ()
@property(nonatomic, assign) CGFloat animationDuration;
@property(nonatomic, assign) CGFloat startingValue;
@property(nonatomic, assign) CGFloat destinationValue;
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, assign) CGFloat lastUpdateTime;
@property(nonatomic, assign) CGFloat totalTime;
@property(nonatomic, strong) CADisplayLink* timer;
@property(nonatomic, assign) CGFloat currentValue;
@property(nonatomic, assign) XDisplayLinkAnimatorResultType resultType;

@property(nonatomic, strong)
    AnimatorCurrentValueBlock animationCurrentValueBlock;
@property(nonatomic, strong) AnimatorPercentageBlock animationPercentageBlock;
@end

@implementation XAnimator


#pragma mark Entrance
- (void)AnimatorCountFrom:(CGFloat)from
                 CurrentTo:(CGFloat)to
                  duration:(CGFloat)duration
            animationBlock:(AnimatorCurrentValueBlock)block {
    // 外部值 赋值
    self.startingValue = from;
    self.destinationValue = to;
    self.animationCurrentValueBlock = block;
    
    // 结果类型
    self.resultType = XResult;
    // 开始迭代
    [self countFrom:self.currentValue to:to duration:duration];
}

- (void)AnimatorDuration:(CGFloat)duration
           animationBlock:(AnimatorPercentageBlock)block {
    self.startingValue = 0;
    self.destinationValue = 100;
    self.animationPercentageBlock = block;
    
    // 结果类型
    self.resultType = XPercentage;
    
    [self countFrom:0 to:100 duration:duration];
}


///add displaylink
- (void)addDisplayLink {
  self.timer = [CADisplayLink displayLinkWithTarget:self
                                           selector:@selector(updateValue:)];
  [self.timer addToRunLoop:[NSRunLoop currentRunLoop]
                   forMode:NSRunLoopCommonModes];
}

- (void)updateValue:(CADisplayLink*)timer {
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
  // 更新值
  [self updateIterationResultValue];
}

- (void)updateIterationResultValue {
  switch (self.resultType) {
    case XResult: {
      [self iterationCurrentValue:self.currentValue];
    } break;
    case XPercentage: {
        [self iterationPercentage:[self timingFunctionMapping:[self getPercentage] functionType:XBounceEaseInOut]];
    } break;
  }
}

- (AHFloat)timingFunctionMapping:(AHFloat)value functionType:(XTimingFunctionsType)type {
    switch (type) {
        case XBounceEaseInOut:
        {
            return BounceEaseInOut(value);
        }
        break;
        
        default:
        {
            return CubicEaseIn(value);
        }
        break;
    }
    
}
    
// 当前值作为迭代结果
- (void)iterationCurrentValue:(CGFloat)currentValue {
  self.animationCurrentValueBlock(currentValue);
}

// 百分比作为迭代结果
- (CGFloat)getPercentage {
  return self.progress / self.totalTime;
}

- (void)iterationPercentage:(CGFloat)precentage {
  self.animationPercentageBlock(precentage);
}

// 从当前value 迭代, 准备工作
- (void)countFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration {
  // timer 处理
  if (self.timer != nil) {
    [self.timer invalidate];
    self.timer = nil;
  }

  // 迭代有关值处理
  self.progress = 0.0;
  self.totalTime = duration;
  self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];

  // 添加DisplayLink
  [self addDisplayLink];
}



#pragma mark Get
// 计算当前的值，包括了开始状态 和 进行中状态
- (CGFloat)currentValue {
  if (self.progress >= self.totalTime) {
    return self.destinationValue;
  }
  return self.startingValue +
         (self.progress / self.totalTime) *
             (self.destinationValue - self.startingValue);
}

@end
