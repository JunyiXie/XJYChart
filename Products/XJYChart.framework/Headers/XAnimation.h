//
//  XAnimation.h
//  RecordLife
//
//  Created by 谢俊逸 on 06/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XAnimation : NSObject
+ (instancetype)shareInstance;
- (void)addLSSpringFrameAnimation:(CALayer*)layer;
- (void)addLSSpringScaleAnimation:(UIView*)view;
+ (CABasicAnimation*)morphAnimationFromPath:(UIBezierPath*)fromPath
                                     toPath:(UIBezierPath*)toPath
                                   duration:(CGFloat)duration;
+ (CABasicAnimation*)frameAnimatonFromRect:(CGRect)fromRect
                                    toRect:(CGRect)toRect
                                  duration:(CGFloat)duration;

@end
