//
//  XAnimator.h
//  RecordLife
//
//  Created by 谢俊逸 on 05/07/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AnimatorNumberBlock)(CGFloat nowNumber);

@interface XAnimator : NSObject

- (void)XAnimatorCountFrom:(CGFloat)from CurrentTo:(CGFloat)to duration:(CGFloat)duration animationBlock:(AnimatorNumberBlock)block;
@end
