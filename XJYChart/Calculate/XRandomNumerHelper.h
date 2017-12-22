//
//  XRandomNumerHelper.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRandomNumerHelper : NSObject

/**
 Singleton

 @return Singleton
 */
+ (instancetype)shareRandomNumberHelper;

/**
 a number small than max

 @param max max
 @return number
 */
- (int)randomNumberSmallThan:(NSInteger)max;
@end
