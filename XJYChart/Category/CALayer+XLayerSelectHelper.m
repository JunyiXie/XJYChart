//
//  CALayer+XXLayer.m
//  RecordLife
//
//  Created by 谢俊逸 on 24/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "CALayer+XLayerSelectHelper.h"
#import <objc/runtime.h>
@implementation CALayer (XXLayer)

// selectIdx
// For CAGradientLayer
static char kSelectIdxNumber;

- (void)setSelectIdxNumber:(id)selectIdxNumber {
  objc_setAssociatedObject(self, &kSelectIdxNumber, selectIdxNumber,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)selectIdxNumber {
  return objc_getAssociatedObject(self, &kSelectIdxNumber);
}

// http://stackoverflow.com/questions/28447744/frame-origin-and-bounds-size-of-cashapelayer-are-set-to-0
// frame
static char kFrameKey;

// selected status
static char kSelectedStatusKey;

// backgroundFrame
static char kBackgroundFrameKey;

// segementPointsArrays
static char kSegementPointsArraysKey;

- (void)setFrameValue:(id)frameValue {
  objc_setAssociatedObject(self, &kFrameKey, frameValue,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)frameValue {
  return objc_getAssociatedObject(self, &kFrameKey);
}

- (void)setSelectStatusNumber:(id)selectStatusNumber {
  objc_setAssociatedObject(self, &kSelectedStatusKey, selectStatusNumber,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)selectStatusNumber {
  return objc_getAssociatedObject(self, &kSelectedStatusKey);
}

- (void)setBackgroundFrameValue:(id)backgroundFrameValue {
  objc_setAssociatedObject(self, &kBackgroundFrameKey, backgroundFrameValue,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)backgroundFrameValue {
  return objc_getAssociatedObject(self, &kBackgroundFrameKey);
}

- (void)setSegementPointsArrays:(id)segementPointsArrays {
  objc_setAssociatedObject(self, &kSegementPointsArraysKey,
                           segementPointsArrays,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)segementPointsArrays {
  return objc_getAssociatedObject(self, &kSegementPointsArraysKey);
}


@end
