//
//  UIGestureRecognizer+XXGes.m
//  RecordLife
//
//  Created by 谢俊逸 on 11/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "UIGestureRecognizer+XGesHelper.h"
#import <objc/runtime.h>

static char kHasTapBoolNumber;

@implementation UIGestureRecognizer (XXGes)

- (void)setHasTapedBoolNumber:(NSNumber*)hasTapedBoolNumber {
  objc_setAssociatedObject(self, &kHasTapBoolNumber, hasTapedBoolNumber,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber*)hasTapedBoolNumber {
  return objc_getAssociatedObject(self, &kHasTapBoolNumber);
}

@end
