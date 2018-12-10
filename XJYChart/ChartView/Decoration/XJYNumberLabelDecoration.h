//
//  XJYNumberLabelDecoration.h
//  XJYChart
//
//  Created by JunyiXie on 11/12/2018.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class XAnimationLabel;
@interface XJYNumberLabelDecoration : NSObject
@property(nonatomic, weak) UIView *viewer;
@property(nonatomic, strong) NSMutableArray<XAnimationLabel*>* labelArray;
- (instancetype)initWithViewer:(UIView *)viewer;
- (void)drawWithPoints:(NSArray<NSValue *> *)points TextNumbers:(NSArray<NSNumber *> *)textNumbers isEnableAnimation:(BOOL)isEnableAnimation;
- (void)removeNumberLabels;
@end

NS_ASSUME_NONNULL_END

