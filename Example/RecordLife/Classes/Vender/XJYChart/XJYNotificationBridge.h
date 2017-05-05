//
//  XJYNotificationBridge.h
//  RecordLife
//
//  Created by 谢俊逸 on 03/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJYNotificationBridge : NSObject

+ (instancetype)shareXJYNotificationBridge;
@property (nonatomic, strong) NSString *TouchBarNotification;
@property (nonatomic, strong) NSString *BarIdxNumberKey;

@end
