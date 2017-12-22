//
//  XPointDetect.h
//  RecordLife
//
//  Created by JunyiXie on 2017/11/25.
//  Copyright © 2017年 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XPointDetect : NSObject

/**
 Detect Point whether in area
 The gradient range expand
 @param point target
 @param area 4 CGPoint values array
 @return BOOL
 */
+ (BOOL)detectPoint:(CGPoint)point InExpandArea:(NSArray<NSValue*>*)area;

+ (BOOL)point:(CGPoint)point inArea:(NSArray<NSValue*>*)area;

+ (NSArray<NSValue*>*)expandRectArea:(NSArray<NSValue*>*)area
                        expandLength:(CGFloat)length;
@end
