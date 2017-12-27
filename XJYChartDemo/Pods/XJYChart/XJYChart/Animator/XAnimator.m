//
//  XAnimator.m
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimator.h"
#include <math.h>
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
@property(nonatomic, assign) XTimingFunctionsType timingFuncType;
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
          timingFuncType:(XTimingFunctionsType)timingFuncType
          animationBlock:(AnimatorPercentageBlock)block {
  self.startingValue = 0;
  self.destinationValue = 100;
  self.animationPercentageBlock = block;
  self.timingFuncType = timingFuncType;
  // 结果类型
  self.resultType = XPercentage;

  [self countFrom:0 to:100 duration:duration];
}

/// add displaylink
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
      [self
          iterationPercentage:[self timingFunctionMapping:[self getPercentage]
                                             functionType:self.timingFuncType]];
    } break;
  }
}

- (AHFloat)timingFunctionMapping:(AHFloat)value
                    functionType:(XTimingFunctionsType)type {
  switch (type) {
    case XBounceEaseInOut: {
      return BounceEaseInOut(value);
    } break;
    case XQuarticEaseInOut: {
      return QuarticEaseInOut(value);
    }

    default: { return CubicEaseIn(value); } break;
  }
  return 0;
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

#pragma mark Fuck the cocoapods!

// Modeled after the line y = x
AHFloat LinearInterpolation(AHFloat p) {
  return p;
}

// Modeled after the parabola y = x^2
AHFloat QuadraticEaseIn(AHFloat p) {
  return p * p;
}

// Modeled after the parabola y = -x^2 + 2x
AHFloat QuadraticEaseOut(AHFloat p) {
  return -(p * (p - 2));
}

// Modeled after the piecewise quadratic
// y = (1/2)((2x)^2)             ; [0, 0.5)
// y = -(1/2)((2x-1)*(2x-3) - 1) ; [0.5, 1]
AHFloat QuadraticEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 2 * p * p;
  } else {
    return (-2 * p * p) + (4 * p) - 1;
  }
}

// Modeled after the cubic y = x^3
AHFloat CubicEaseIn(AHFloat p) {
  return p * p * p;
}

// Modeled after the cubic y = (x - 1)^3 + 1
AHFloat CubicEaseOut(AHFloat p) {
  AHFloat f = (p - 1);
  return f * f * f + 1;
}

// Modeled after the piecewise cubic
// y = (1/2)((2x)^3)       ; [0, 0.5)
// y = (1/2)((2x-2)^3 + 2) ; [0.5, 1]
AHFloat CubicEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 4 * p * p * p;
  } else {
    AHFloat f = ((2 * p) - 2);
    return 0.5 * f * f * f + 1;
  }
}

// Modeled after the quartic x^4
AHFloat QuarticEaseIn(AHFloat p) {
  return p * p * p * p;
}

// Modeled after the quartic y = 1 - (x - 1)^4
AHFloat QuarticEaseOut(AHFloat p) {
  AHFloat f = (p - 1);
  return f * f * f * (1 - p) + 1;
}

// Modeled after the piecewise quartic
// y = (1/2)((2x)^4)        ; [0, 0.5)
// y = -(1/2)((2x-2)^4 - 2) ; [0.5, 1]
AHFloat QuarticEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 8 * p * p * p * p;
  } else {
    AHFloat f = (p - 1);
    return -8 * f * f * f * f + 1;
  }
}

// Modeled after the quintic y = x^5
AHFloat QuinticEaseIn(AHFloat p) {
  return p * p * p * p * p;
}

// Modeled after the quintic y = (x - 1)^5 + 1
AHFloat QuinticEaseOut(AHFloat p) {
  AHFloat f = (p - 1);
  return f * f * f * f * f + 1;
}

// Modeled after the piecewise quintic
// y = (1/2)((2x)^5)       ; [0, 0.5)
// y = (1/2)((2x-2)^5 + 2) ; [0.5, 1]
AHFloat QuinticEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 16 * p * p * p * p * p;
  } else {
    AHFloat f = ((2 * p) - 2);
    return 0.5 * f * f * f * f * f + 1;
  }
}

// Modeled after quarter-cycle of sine wave
AHFloat SineEaseIn(AHFloat p) {
  return sin((p - 1) * M_PI_2) + 1;
}

// Modeled after quarter-cycle of sine wave (different phase)
AHFloat SineEaseOut(AHFloat p) {
  return sin(p * M_PI_2);
}

// Modeled after half sine wave
AHFloat SineEaseInOut(AHFloat p) {
  return 0.5 * (1 - cos(p * M_PI));
}

// Modeled after shifted quadrant IV of unit circle
AHFloat CircularEaseIn(AHFloat p) {
  return 1 - sqrt(1 - (p * p));
}

// Modeled after shifted quadrant II of unit circle
AHFloat CircularEaseOut(AHFloat p) {
  return sqrt((2 - p) * p);
}

// Modeled after the piecewise circular function
// y = (1/2)(1 - sqrt(1 - 4x^2))           ; [0, 0.5)
// y = (1/2)(sqrt(-(2x - 3)*(2x - 1)) + 1) ; [0.5, 1]
AHFloat CircularEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 0.5 * (1 - sqrt(1 - 4 * (p * p)));
  } else {
    return 0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1);
  }
}

// Modeled after the exponential function y = 2^(10(x - 1))
AHFloat ExponentialEaseIn(AHFloat p) {
  return (p == 0.0) ? p : pow(2, 10 * (p - 1));
}

// Modeled after the exponential function y = -2^(-10x) + 1
AHFloat ExponentialEaseOut(AHFloat p) {
  return (p == 1.0) ? p : 1 - pow(2, -10 * p);
}

// Modeled after the piecewise exponential
// y = (1/2)2^(10(2x - 1))         ; [0,0.5)
// y = -(1/2)*2^(-10(2x - 1))) + 1 ; [0.5,1]
AHFloat ExponentialEaseInOut(AHFloat p) {
  if (p == 0.0 || p == 1.0)
    return p;

  if (p < 0.5) {
    return 0.5 * pow(2, (20 * p) - 10);
  } else {
    return -0.5 * pow(2, (-20 * p) + 10) + 1;
  }
}

// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
AHFloat ElasticEaseIn(AHFloat p) {
  return sin(13 * M_PI_2 * p) * pow(2, 10 * (p - 1));
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
AHFloat ElasticEaseOut(AHFloat p) {
  return sin(-13 * M_PI_2 * (p + 1)) * pow(2, -10 * p) + 1;
}

// Modeled after the piecewise exponentially-damped sine wave:
// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))      ; [0,0.5)
// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2) ; [0.5, 1]
AHFloat ElasticEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 0.5 * sin(13 * M_PI_2 * (2 * p)) * pow(2, 10 * ((2 * p) - 1));
  } else {
    return 0.5 *
           (sin(-13 * M_PI_2 * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) +
            2);
  }
}

// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
AHFloat BackEaseIn(AHFloat p) {
  return p * p * p - p * sin(p * M_PI);
}

// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
AHFloat BackEaseOut(AHFloat p) {
  AHFloat f = (1 - p);
  return 1 - (f * f * f - f * sin(f * M_PI));
}

// Modeled after the piecewise overshooting cubic function:
// y = (1/2)*((2x)^3-(2x)*sin(2*x*pi))           ; [0, 0.5)
// y = (1/2)*(1-((1-x)^3-(1-x)*sin((1-x)*pi))+1) ; [0.5, 1]
AHFloat BackEaseInOut(AHFloat p) {
  if (p < 0.5) {
    AHFloat f = 2 * p;
    return 0.5 * (f * f * f - f * sin(f * M_PI));
  } else {
    AHFloat f = (1 - (2 * p - 1));
    return 0.5 * (1 - (f * f * f - f * sin(f * M_PI))) + 0.5;
  }
}

AHFloat BounceEaseIn(AHFloat p) {
  return 1 - BounceEaseOut(1 - p);
}

AHFloat BounceEaseOut(AHFloat p) {
  if (p < 4 / 11.0) {
    return (121 * p * p) / 16.0;
  } else if (p < 8 / 11.0) {
    return (363 / 40.0 * p * p) - (99 / 10.0 * p) + 17 / 5.0;
  } else if (p < 9 / 10.0) {
    return (4356 / 361.0 * p * p) - (35442 / 1805.0 * p) + 16061 / 1805.0;
  } else {
    return (54 / 5.0 * p * p) - (513 / 25.0 * p) + 268 / 25.0;
  }
}

AHFloat BounceEaseInOut(AHFloat p) {
  if (p < 0.5) {
    return 0.5 * BounceEaseIn(p * 2);
  } else {
    return 0.5 * BounceEaseOut(p * 2 - 1) + 0.5;
  }
}

@end
