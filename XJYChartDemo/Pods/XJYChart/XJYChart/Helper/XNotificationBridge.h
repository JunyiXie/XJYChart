//
//  XNotificationBridge.h
//  RecordLife
//
//  Created by 谢俊逸 on 03/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Cross layer using the same Notification info
 */
@interface XNotificationBridge : NSObject

+ (instancetype)shareXNotificationBridge;

/// BarChart
@property(nonatomic, strong) NSString* TouchBarNotification;
@property(nonatomic, strong) NSString* BarIdxNumberKey;

/// PositiveNegativeBarChart
@property(nonatomic, strong) NSString* TouchPNBarNotification;
@property(nonatomic, strong) NSString* PNBarIdxNumberKey;

@end
