//
//  XAnimation.m
//  RecordLife
//
//  Created by 谢俊逸 on 06/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimation.h"
//#import "LSAnimator.h"
@implementation XAnimation

+ (instancetype)shareInstance {
  static XAnimation* ivar = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    ivar = [XAnimation new];
  });
  return ivar;
}

+ (CASpringAnimation*)getLineChartSpringAnimationWithLayer:(CALayer*)layer {
  CASpringAnimation* springAnimation =
      [CASpringAnimation animationWithKeyPath:@"position.y"];
  springAnimation.damping = 5;
  springAnimation.stiffness = 100;
  springAnimation.mass = 1;
  springAnimation.initialVelocity = 0;
  springAnimation.fromValue = @(layer.position.y - 5);
  springAnimation.toValue = @(layer.position.y + 0);
  springAnimation.duration = springAnimation.settlingDuration;
  return springAnimation;
}

+ (CASpringAnimation*)getBarChartSpringAnimationWithLayer:(CALayer*)layer {
  CASpringAnimation* springAnimation =
      [CASpringAnimation animationWithKeyPath:@"position.y"];
  springAnimation.damping = 5;
  springAnimation.stiffness = 100;
  springAnimation.mass = 1;
  springAnimation.initialVelocity = 0;
  springAnimation.fromValue = @(layer.position.y - 15);
  springAnimation.toValue = @(layer.position.y + 0);
  springAnimation.duration = springAnimation.settlingDuration;
  return springAnimation;
}

+ (CABasicAnimation*)morphAnimationFromPath:(UIBezierPath*)fromPath
                                     toPath:(UIBezierPath*)toPath
                                   duration:(CGFloat)duration {
  CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"path"];
  animation.duration = duration;
  animation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.fromValue = (id)fromPath.CGPath;
  animation.toValue = (id)toPath.CGPath;

  return animation;
}

+ (CABasicAnimation*)frameAnimatonFromRect:(CGRect)fromRect
                                    toRect:(CGRect)toRect
                                  duration:(CGFloat)duration {
  CABasicAnimation* animation =
      [CABasicAnimation animationWithKeyPath:@"frame"];
  animation.duration = duration;
  animation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.fromValue = (id)[NSValue valueWithCGRect:fromRect];
  animation.toValue = (id)[NSValue valueWithCGRect:toRect];

  return animation;
}

- (void)addLSSpringFrameAnimation:(CALayer*)layer {
  //    layer.ls_spring.ls_scale(1.1).ls_spring.ls_thenAfter(0.3).ls_scale(1.0/1.1).ls_spring.ls_animate(1);
}

- (void)addLSSpringScaleAnimation:(UIView*)view {
  //    view.ls_spring.ls_scale(1.1).ls_spring.ls_thenAfter(0.3).ls_scale(1.0/1.1).ls_spring.ls_animate(1);
}


@end
