//
//  XRemoveManager.m
//  XJYChart
//
//  Created by JunyiXie on 2017/12/2.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import "XRemoveManager.h"

@interface XRemoveManager ()

@property(nonatomic, strong) NSMutableSet* arrays;

@end

@implementation XRemoveManager

- (instancetype)init {
  if (self = [super init]) {
    self.arrays = [NSMutableSet new];
  }
  return self;
}

- (void)appendArray:(XRemoveFromSuperArray*)array {
  [self.arrays addObject:array];
}

- (void)removeDisplayContentAndItem {
  for (XRemoveFromSuperArray* ary in self.arrays) {
    [ary removeFromSuperDisplayAndEmptyArray];
  }
}

@end
