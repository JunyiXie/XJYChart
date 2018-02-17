//
//  XRandomNumerHelper.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XRandomNumerHelper.h"

@implementation XRandomNumerHelper

+ (instancetype)shareRandomNumberHelper {
  static XRandomNumerHelper* helper = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    helper = [[XRandomNumerHelper alloc] init];
  });
  return helper;
}

- (int)randomNumberSmallThan:(NSInteger)max {
  int idx = arc4random() % max;
  return idx;
}

@end
