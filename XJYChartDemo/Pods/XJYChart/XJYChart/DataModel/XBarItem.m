//
//  XBarItem.m
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XBarItem.h"

@implementation XBarItem

- (instancetype)initWithDataNumber:(NSNumber*)dataNumber
                             color:(UIColor*)color
                      dataDescribe:(NSString*)dataDescribe {
  if (self = [super init]) {
    self.dataNumber = dataNumber;
    self.color = color;
    self.dataDescribe = dataDescribe;
  }
  return self;
}
@end
