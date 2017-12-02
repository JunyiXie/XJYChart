//
//  XRemoveFromSuperArray.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/2.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XRemoveFromSuperArray.h"
#import <pthread/pthread.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>

typedef NS_ENUM(NSUInteger, XRemoveArrayElementType) {
  XCALayer,
  XUIView,
};

@implementation XRemoveFromSuperArray



- (void)removeFromSuperDisplayAndEmptyArray {
  __block XRemoveArrayElementType elemType = 0;

  pthread_mutex_t lock;
  pthread_mutex_init(&lock, NULL);

  pthread_mutex_lock(&lock);
  for (id item in self) {
    // Type Judge
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      if (classDescendsFromClass([item class], [UIView class])) {
        elemType = XUIView;
      } else if (classDescendsFromClass([item class], [CALayer class])) {
        elemType = XCALayer;
      } else {
        [NSException raise:@"wrong array item type." format:@""];
      }
    });

    // Romve from Super layer or view
    if (elemType == XUIView) {
      [(UIView*)item removeFromSuperview];
    } else {
      [(CALayer*)item removeFromSuperlayer];
    }
  }
  [self removeAllObjects];
  pthread_mutex_unlock(&lock);
}

BOOL classDescendsFromClass(Class classA, Class classB) {
  while (1) {
    if (classA == classB)
      return YES;
    id superClass = class_getSuperclass(classA);
    if (classA == superClass)
      return (superClass == classB);
    classA = superClass;
  }
}

@end
