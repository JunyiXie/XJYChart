//
//  RandomNumerHelper.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "RandomNumerHelper.h"

@implementation RandomNumerHelper

+ (instancetype)shareRandomNumberHelper {
    static RandomNumerHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[RandomNumerHelper alloc] init];
    });
    return helper;
}

- (int)randomNumberSmallThan:(int)max {
    int idx = arc4random() % max;
    return idx;
}

@end
