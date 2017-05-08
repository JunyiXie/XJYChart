//
//  XJYAnimation.m
//  RecordLife
//
//  Created by 谢俊逸 on 06/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYAnimation.h"
@implementation XJYAnimation



+ (CASpringAnimation *)getLineChartSpringAnimationWithLayer:(CALayer *)layer {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    springAnimation.damping = 5;
    springAnimation.stiffness = 100;
    springAnimation.mass = 1;
    springAnimation.initialVelocity = 0;
    springAnimation.fromValue = @(layer.position.y - 5);
    springAnimation.toValue = @(layer.position.y + 0);
    springAnimation.duration = springAnimation.settlingDuration;
    return springAnimation;
}

+ (CASpringAnimation *)getBarChartSpringAnimationWithLayer:(CALayer *)layer {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    springAnimation.damping = 5;
    springAnimation.stiffness = 100;
    springAnimation.mass = 1;
    springAnimation.initialVelocity = 0;
    springAnimation.fromValue = @(layer.position.y - 15);
    springAnimation.toValue = @(layer.position.y + 0);
    springAnimation.duration = springAnimation.settlingDuration;
    return springAnimation;
}


@end
