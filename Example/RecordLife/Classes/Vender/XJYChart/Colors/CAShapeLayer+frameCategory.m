//
//  CAShapeLayer+frameCategory.m
//  RecordLife
//
//  Created by 谢俊逸 on 20/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "CAShapeLayer+frameCategory.h"
#import <objc/runtime.h>

// To solve CAShapeLayer Frame(0,0,0,0)

@implementation CAShapeLayer (frameCategory)

//http://stackoverflow.com/questions/28447744/frame-origin-and-bounds-size-of-cashapelayer-are-set-to-0

// frame
static char kAssociatedObjectKey;

//selected status
static char kAssociatedObjectKey2;

- (void)setFrameValue:(id)frameValue {
    objc_setAssociatedObject(self, &kAssociatedObjectKey, frameValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)frameValue {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey);
}

- (void)setSelectStatusNumber:(id)selectStatusNumber {
    objc_setAssociatedObject(self, &kAssociatedObjectKey2, selectStatusNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)selectStatusNumber {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey2);
}




@end
