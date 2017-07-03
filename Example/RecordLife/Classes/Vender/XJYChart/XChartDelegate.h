//
//  XChartDelegate.h
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XChartDelegate <NSObject>
@optional
/**
 * Callback method that gets invoked when the user taps on the chart line.
 */
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex;

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex;

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex;


- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex;
- (void)didUnselectPieItem;
@end
