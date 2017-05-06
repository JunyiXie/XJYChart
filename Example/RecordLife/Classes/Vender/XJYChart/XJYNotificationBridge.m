//
//  XJYNotificationBridge.m
//  RecordLife
//
//  Created by 谢俊逸 on 03/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYNotificationBridge.h"

@implementation XJYNotificationBridge

+ (instancetype)shareXJYNotificationBridge {
    static XJYNotificationBridge *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[XJYNotificationBridge alloc] init];
    });
    return share;
}

- (instancetype) init {
    if (self = [super init]) {
        self.TouchBarNotification = @"TouchBarNotification";
        self.BarIdxNumberKey = @"TouchBarNotification";
    }
    return self;
}

@end
