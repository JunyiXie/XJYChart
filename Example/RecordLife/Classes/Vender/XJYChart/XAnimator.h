//
//  XAnimator.h
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AnimatorPercentageBlock)(CGFloat percentage);
typedef void(^AnimatorCurrentValueBlock)(CGFloat result);
@interface XAnimator : NSObject
- (void)AnimatorCountFrom:(CGFloat)from
                 CurrentTo:(CGFloat)to
                  duration:(CGFloat)duration
            animationBlock:(AnimatorCurrentValueBlock)block;

- (void)AnimatorDuration:(CGFloat)duration
           animationBlock:(AnimatorPercentageBlock)block;

@end
