//
//  XAnimator.h
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XTimingFunctionsType) {
    XLinearInterpolation,
    XQuadraticEaseIn,
    XQuadraticEaseOut,
    XQuadraticEaseInOut,
    XCubicEaseIn,
    XCubicEaseOut,
    XCubicEaseInOut,
    XQuarticEaseIn,
    XQuarticEaseOut,
    XQuarticEaseInOut,
    XQuinticEaseIn,
    XSineEaseIn,
    XSineEaseOut,
    XSineEaseInOut,
    XCircularEaseIn,
    XCircularEaseOut,
    XCircularEaseInOut,
    XExponentialEaseIn,
    XExponentialEaseOut,
    XExponentialEaseInOut,
    XElasticEaseIn,
    XElasticEaseOut,
    XElasticEaseInOut,
    XBackEaseIn,
    XBackEaseOut,
    XBackEaseInOut,
    XBounceEaseIn,
    XBounceEaseOut,
    XBounceEaseInOut,
};


@protocol XAnimationDelegate

- (void)animationAfterIteration;

@end

typedef void(^AnimatorPercentageBlock)(CGFloat percentage);
typedef void(^AnimatorCurrentValueBlock)(CGFloat result);
@interface XAnimator : NSObject

@property (nonatomic, weak) id animationDeleagte;

- (void)AnimatorDuration:(CGFloat)duration
          timingFuncType:(XTimingFunctionsType)timingFuncType
          animationBlock:(AnimatorPercentageBlock)block;

@end
