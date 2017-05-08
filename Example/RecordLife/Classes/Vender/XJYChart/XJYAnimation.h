//
//  XJYAnimation.h
//  RecordLife
//
//  Created by 谢俊逸 on 06/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XJYAnimation : NSObject
+ (instancetype)shareInstance;
- (void)addLSSpringFrameAnimation:(CALayer *)layer;
+ (CASpringAnimation *)getLineChartSpringAnimationWithLayer:(CALayer *)layer;
+ (CASpringAnimation *)getBarChartSpringAnimationWithLayer:(CALayer *)layer;
@end
