//
//  CAKeyframeAnimation+AHEasing.m
//
//  Copyright (c) 2011, Auerhaus Development, LLC
//
//  This program is free software. It comes without any warranty, to
//  the extent permitted by applicable law. You can redistribute it
//  and/or modify it under the terms of the Do What The Fuck You Want
//  To Public License, Version 2, as published by Sam Hocevar. See
//  http://sam.zoy.org/wtfpl/COPYING for more details.
//

#import "CAKeyframeAnimation+AHEasing.h"
#import <UIKit/UIKit.h>
#if !defined(AHEasingDefaultKeyframeCount)

// The larger this number, the smoother the animation
#define AHEasingDefaultKeyframeCount 60

#endif

@implementation CAKeyframeAnimation (AHEasing)

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                           fromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue
                       keyframeCount:(size_t)keyframeCount {
  NSMutableArray* values = [NSMutableArray arrayWithCapacity:keyframeCount];

  CGFloat t = 0.0;
  CGFloat dt = 1.0 / (keyframeCount - 1);
  for (size_t frame = 0; frame < keyframeCount; ++frame, t += dt) {
    CGFloat value = fromValue + function(t) * (toValue - fromValue);
    [values addObject:[NSNumber numberWithFloat:(float)value]];
  }

  CAKeyframeAnimation* animation =
      [CAKeyframeAnimation animationWithKeyPath:path];
  [animation setValues:values];
  return animation;
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                           fromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue {
  return [self animationWithKeyPath:path
                           function:function
                          fromValue:fromValue
                            toValue:toValue
                      keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                           fromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint
                       keyframeCount:(size_t)keyframeCount {
  NSMutableArray* values = [NSMutableArray arrayWithCapacity:keyframeCount];

  CGFloat t = 0.0;
  CGFloat dt = 1.0 / (keyframeCount - 1);
  for (size_t frame = 0; frame < keyframeCount; ++frame, t += dt) {
    CGFloat x = fromPoint.x + function(t) * (toPoint.x - fromPoint.x);
    CGFloat y = fromPoint.y + function(t) * (toPoint.y - fromPoint.y);
#if TARGET_OS_IPHONE
    [values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
#else
    [values addObject:[NSValue valueWithPoint:NSMakePoint(x, y)]];
#endif
  }

  CAKeyframeAnimation* animation =
      [CAKeyframeAnimation animationWithKeyPath:path];
  [animation setValues:values];
  return animation;
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                           fromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint {
  return [self animationWithKeyPath:path
                           function:function
                          fromPoint:fromPoint
                            toPoint:toPoint
                      keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                            fromSize:(CGSize)fromSize
                              toSize:(CGSize)toSize
                       keyframeCount:(size_t)keyframeCount {
  NSMutableArray* values = [NSMutableArray arrayWithCapacity:keyframeCount];

  CGFloat t = 0.0;
  CGFloat dt = 1.0 / (keyframeCount - 1);
  for (size_t frame = 0; frame < keyframeCount; ++frame, t += dt) {
    CGFloat w = fromSize.width + function(t) * (toSize.width - fromSize.width);
    CGFloat h =
        fromSize.height + function(t) * (toSize.height - fromSize.height);
#if TARGET_OS_IPHONE
    [values addObject:[NSValue valueWithCGSize:CGSizeMake(w, h)]];
#else
    [values addObject:[NSValue valueWithSize:NSMakeSize(w, h)]];
#endif
  }

  CAKeyframeAnimation* animation =
      [CAKeyframeAnimation animationWithKeyPath:path];
  [animation setValues:values];
  return animation;
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                            fromSize:(CGSize)fromSize
                              toSize:(CGSize)toSize {
  return [self animationWithKeyPath:path
                           function:function
                           fromSize:fromSize
                             toSize:toSize
                      keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                       fromTransform:(CGAffineTransform)fromTransform
                         toTransform:(CGAffineTransform)toTransform
                       keyframeCount:(size_t)keyframeCount {
  NSMutableArray* values = [NSMutableArray arrayWithCapacity:keyframeCount];

  CGPoint fromTranslation = CGPointMake(fromTransform.tx, fromTransform.ty);
  CGPoint toTranslation = CGPointMake(toTransform.tx, toTransform.ty);

  CGFloat fromScale = hypot(fromTransform.a, fromTransform.c);
  CGFloat toScale = hypot(toTransform.a, toTransform.c);

  CGFloat fromRotation = atan2(fromTransform.c, fromTransform.a);
  CGFloat toRotation = atan2(toTransform.c, toTransform.a);

  CGFloat deltaRotation = toRotation - fromRotation;

  if (deltaRotation < -M_PI)
    deltaRotation += (2 * M_PI);
  else if (deltaRotation > M_PI)
    deltaRotation -= (2 * M_PI);

  CGFloat t = 0.0;
  CGFloat dt = 1.0 / (keyframeCount - 1);
  for (size_t frame = 0; frame < keyframeCount; ++frame, t += dt) {
    CGFloat interp = function(t);

    CGFloat translateX =
        fromTranslation.x + interp * (toTranslation.x - fromTranslation.x);
    CGFloat translateY =
        fromTranslation.y + interp * (toTranslation.y - fromTranslation.y);

    CGFloat scale = fromScale + interp * (toScale - fromScale);

    CGFloat rotate = fromRotation + interp * deltaRotation;

    CGAffineTransform affineTransform = CGAffineTransformMake(
        scale * cos(rotate), -scale * sin(rotate), scale * sin(rotate),
        scale * cos(rotate), translateX, translateY);

    CATransform3D transform = CATransform3DMakeAffineTransform(affineTransform);

    [values addObject:[NSValue valueWithCATransform3D:transform]];
  }

  CAKeyframeAnimation* animation =
      [CAKeyframeAnimation animationWithKeyPath:path];
  [animation setValues:values];
  return animation;
}

+ (instancetype)animationWithKeyPath:(NSString*)path
                            function:(AHEasingFunction)function
                       fromTransform:(CGAffineTransform)fromTransform
                         toTransform:(CGAffineTransform)toTransform {
  return [self animationWithKeyPath:path
                           function:function
                      fromTransform:fromTransform
                        toTransform:toTransform
                      keyframeCount:AHEasingDefaultKeyframeCount];
}

@end
