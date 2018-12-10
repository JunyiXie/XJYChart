//
//  XJYNumberLabelDecoration.m
//  XJYChart
//
//  Created by JunyiXie on 11/12/2018.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

#import "XJYNumberLabelDecoration.h"
#import "XAnimationLabel.h"
#import "XColor.h"
@implementation XJYNumberLabelDecoration

- (instancetype)initWithViewer:(UIView *)viewer {
  if (self = [super init]) {
    _labelArray = [NSMutableArray new];
    _viewer = viewer;
  }
  return self;
}

- (void)drawWithPoints:(NSArray<NSValue *> *)points TextNumbers:(NSArray<NSNumber *> *)textNumbers isEnableAnimation:(BOOL)isEnableAnimation {
  [points
   enumerateObjectsUsingBlock:^(
                                NSValue* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
     CGPoint point = obj.CGPointValue;
     XAnimationLabel* label =
     [XAnimationLabel topLabelWithPoint:point
                                   text:@"0"
                              textColor:XJYBlack
                              fillColor:[UIColor clearColor]];
     CGFloat textNum = textNumbers[idx].doubleValue;
     [self.labelArray addObject:label];
     [self.viewer addSubview:label];
     [label countFromCurrentTo:textNum duration:isEnableAnimation?0.5:0];
   }];
}

- (void)removeNumberLabels {
  [self.labelArray enumerateObjectsUsingBlock:^(
                                                XAnimationLabel* _Nonnull obj, NSUInteger idx,
                                                BOOL* _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  [self.labelArray removeAllObjects];
}


@end
