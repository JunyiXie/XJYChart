//
//  XJYIPTools.h
//  实验室签到MVVM
//
//  Created by 谢俊逸 on 17/12/2016.
//  Copyright © 2016 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJYIPTools : NSObject

/**
 Share IP Tools

 @return XJYIPTools
 */
+ (instancetype)shareIPTools;

/**
 Get IP Adress . . . .

 @return  @" . . . . "

 */
- (NSString *)getIPAddress;
@end
