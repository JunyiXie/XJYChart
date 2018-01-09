//
//  XJYChartDelegate.h
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJYChartDelegate<NSObject>
@optional

/**
 * Touch Bar
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex;

/**
 * Touch Pie
 */
- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex;
- (void)didUnselectPieItem;
@end
