//
//  XPointDetect.m
//  RecordLife
//
//  Created by JunyiXie on 2017/11/25.
//  Copyright © 2017年 谢俊逸. All rights reserved.
//

#import "XPointDetect.h"
#import "XAuxiliaryCalculationHelper.h"
@implementation XPointDetect

#pragma mark Touch Expand algorithm
/*
 * 新的算法
 * 逐级扩展范围
 * 仅仅做了4点 扩散
 */

+ (BOOL)detectPoint:(CGPoint)point InExpandArea:(NSArray<NSValue*>*)area {
  BOOL result = NO;
  return result = [self point:point inArea:[self expandRectArea:area expandLength:10]]
    ?: [self point:point inArea:[self expandRectArea:area expandLength:30]]
    ?: [self point:point inArea:[self expandRectArea:area expandLength:60]]
    ?: [self point:point inArea:[self expandRectArea:area expandLength:100]]
    ?: [self point:point inArea:[self expandRectArea:area expandLength:140]]
    ?: [self point:point inArea:[self expandRectArea:area expandLength:200]];
}

+ (BOOL)point:(CGPoint)point inArea:(NSArray<NSValue*>*)area {
  if ([[XAuxiliaryCalculationHelper shareCalculationHelper]
          containPoint:[NSValue valueWithCGPoint:point]
                Points:[NSMutableArray arrayWithArray:area]]) {
    return YES;
  } else {
    return NO;
  }
}
+ (NSArray<NSValue*>*)expandRectArea:(NSArray<NSValue*>*)area
                        expandLength:(CGFloat)length {
  CGPoint originP1 = area[0].CGPointValue;
  CGPoint originP2 = area[1].CGPointValue;
  CGPoint originP3 = area[2].CGPointValue;
  CGPoint originP4 = area[3].CGPointValue;

  CGPoint rectPoint1 =
      CGPointMake(originP1.x - length / 2, originP1.y - length / 2);
  NSValue* value1 = [NSValue valueWithCGPoint:rectPoint1];
  CGPoint rectPoint2 =
      CGPointMake(originP2.x - length / 2, originP2.y + length / 2);
  NSValue* value2 = [NSValue valueWithCGPoint:rectPoint2];
  CGPoint rectPoint3 =
      CGPointMake(originP3.x + length / 2, originP3.y - length / 2);
  NSValue* value3 = [NSValue valueWithCGPoint:rectPoint3];
  CGPoint rectPoint4 =
      CGPointMake(originP4.x + length / 2, originP4.y + length / 2);
  NSValue* value4 = [NSValue valueWithCGPoint:rectPoint4];

  NSArray<NSValue*>* tempoints = @[ value1, value2, value3, value4 ];
  NSMutableArray<NSValue*>* points = [NSMutableArray new];
  for (NSValue* pointV in tempoints) {
    CGPoint point = pointV.CGPointValue;
    CGFloat pointX = point.x;
    CGFloat pointY = point.y;
    pointX > 0 ? pointX : (point.x = 0);
    pointY > 0 ? pointY : (point.y = 0);
    NSValue* value = [NSValue valueWithCGPoint:point];
    [points addObject:value];
  }
  return points;
}

@end
