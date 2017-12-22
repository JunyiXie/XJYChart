//
//  XNotificationBridge.m
//  RecordLife
//
//  Created by 谢俊逸 on 03/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XNotificationBridge.h"

@implementation XNotificationBridge

+ (instancetype)shareXNotificationBridge {
  static XNotificationBridge* share = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    share = [[XNotificationBridge alloc] init];
  });
  return share;
}

- (instancetype)init {
  if (self = [super init]) {
    self.TouchBarNotification = @"TouchBarNotification";
    self.BarIdxNumberKey = @"TouchBarNotificationKey";

    self.TouchPNBarNotification = @"TouchPNBarNotification";
    self.PNBarIdxNumberKey = @"TouchPNBarNotificationKey";
  }
  return self;
}

@end
